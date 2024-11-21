#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <onnxruntime_c_api.h>

#ifdef _WIN32
#include <wchar.h> // Include for wide character conversion
#define EXPORT __declspec(dllexport)
#define MAX_URI_LENGTH 256  // Adjust size as needed
#define ORTCHAR_T wchar_t
#else
#define EXPORT
#define const ORTCHAR_T char
#endif

// Global variables

// Global variables
float* output = NULL;          // Output array
float* input = NULL;           // Input array
float* norm_mean = NULL;       // Normalization mean array
float* norm_var = NULL;        // Normalization variance array

int input_size = 0;            // Input size
int output_size = 0;           // Output size

const float EPSILON = 1e-8f;   // Small epsilon for numerical stability
const float CLIP_MIN = -10.0f; // Clipping range
const float CLIP_MAX = 10.0f;

OrtEnv* env = NULL;
OrtSession* session = NULL;
OrtMemoryInfo* memory_info = NULL;
OrtValue* input_tensor = NULL;
OrtValue* output_tensor = NULL;
OrtStatus* status = NULL;
const OrtApi* g_ort = NULL;


// Function to check the status of the ONNX Runtime API calls
static void CheckStatus(OrtStatus* status, const OrtApi* g_ort, const char* step) {
    if (status != NULL) {
        const char* msg = g_ort->GetErrorMessage(status);
        fprintf(stderr, "Error in %s: %s\n", step, msg);
        g_ort->ReleaseStatus(status);
        exit(1);
    }
}

#ifdef _WIN32
// Function to convert char* to wchar_t*
static wchar_t* CharToWChar(const char* str) {
    size_t len = strlen(str) + 1;
    wchar_t* wstr = (wchar_t*)malloc(len * sizeof(wchar_t));
    if (wstr != NULL) {
        mbstowcs(wstr, str, len);
    }
    return wstr;
}
#endif

// Function to read normalization data from a file
float* LoadNormalizationData(const char* filename, int size) {
    FILE* file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Error: Could not open file %s\n", filename);
        return NULL;
    }

    float* data = (float*)malloc(size * sizeof(float));
    if (!data) {
        fprintf(stderr, "Error: Could not allocate memory for normalization data\n");
        fclose(file);
        return NULL;
    }

    for (int i = 0; i < size; i++) {
        if (fscanf(file, "%f", &data[i]) != 1) {
            fprintf(stderr, "Error: Incorrect data format in file %s\n", filename);
            free(data);
            fclose(file);
            return NULL;
        }
    }

    fclose(file);
    return data;
}

// Function to initialize the ONNX Runtime environment and session
EXPORT bool InitializeONNXModel(int input_variables, int output_variables, char* model_uri_name, bool use_NormalizedInputs, char* ObsNormmeanfile, char* ObsNormvarfile) {
#ifdef _WIN32
    ORTCHAR_T* model_uri = CharToWChar(model_uri_name);
#else
    const ORTCHAR_T* model_uri = model_uri_name;
#endif

    input_size = input_variables;
    output_size = output_variables;

    input = (float*)malloc(input_size * sizeof(float));
    output = (float*)malloc(output_size * sizeof(float));

    if (input == NULL || output == NULL) {
        fprintf(stderr, "Error: Could not allocate memory for input or output arrays.\n");
        return false;
    }

    memset(input, 0, input_size * sizeof(float));
    memset(output, 0, output_size * sizeof(float));

    // Load normalization parameters if requested
    if (use_NormalizedInputs) {
        norm_mean = LoadNormalizationData(ObsNormmeanfile, input_size);
        norm_var = LoadNormalizationData(ObsNormvarfile, input_size);

        if (norm_mean == NULL || norm_var == NULL) {
            fprintf(stderr, "Error: Could not load normalization parameters.\n");
            return false;
        }
    }

    const char* input_names[] = { "input" };
    const char* output_names[] = { "output" };

    g_ort = OrtGetApiBase()->GetApi(ORT_API_VERSION);

    status = g_ort->CreateEnv(ORT_LOGGING_LEVEL_WARNING, "test", &env);
    CheckStatus(status, g_ort, "CreateEnv");

    status = g_ort->CreateSession(env, model_uri, NULL, &session);
    CheckStatus(status, g_ort, "CreateSession");

    status = g_ort->CreateCpuMemoryInfo(OrtArenaAllocator, OrtMemTypeDefault, &memory_info);
    CheckStatus(status, g_ort, "CreateCpuMemoryInfo");

    return true;
}



EXPORT void RunONNXModel(double observations[], int arrsize, bool use_NormalizedInputs) {
    if (arrsize != input_size) {
        fprintf(stderr, "Error: Input array size does not match the initialized input size.\n");
        return;
    }

    for (int i = 0; i < input_size; i++) {
        input[i] = (float)observations[i];
    }

    // Normalize the input data if requested
    if (use_NormalizedInputs && norm_mean && norm_var) {
        for (int i = 0; i < input_size; i++) {
            // Normalize and clip
            float normalized_value = (input[i] - norm_mean[i]) / sqrtf(norm_var[i] + EPSILON);
            input[i] = fminf(fmaxf(normalized_value, CLIP_MIN), CLIP_MAX);
        }
    }

    size_t input_dims[] = { 1, (size_t)input_size };
    status = g_ort->CreateTensorWithDataAsOrtValue(
        memory_info,
        input,
        input_size * sizeof(float),
        input_dims,
        2,
        ONNX_TENSOR_ELEMENT_DATA_TYPE_FLOAT,
        &input_tensor
    );
    CheckStatus(status, g_ort, "CreateTensorWithDataAsOrtValue");

    const char* input_names[] = { "input" };
    const char* output_names[] = { "output" };
    status = g_ort->Run(
        session,
        NULL,
        input_names,
        (const OrtValue* const*)&input_tensor,
        1,
        output_names,
        1,
        &output_tensor
    );
    CheckStatus(status, g_ort, "Run");

    float* output_data = NULL;
    status = g_ort->GetTensorMutableData(output_tensor, (void**)&output_data);
    CheckStatus(status, g_ort, "GetTensorMutableData");

    for (int i = 0; i < output_size; i++) {
        output[i] = output_data[i];
    }

    return;
}


EXPORT float GetDatafromStorage(int out) {
    // Ensure the requested output index is within the valid range
    if (out >= 0 && out < output_size) {
        return output[out];
    }
    else {
        return -1.0f; // Return -1.0f if the index is out of range
    }
}


EXPORT void ReleaseONNXModel() {
    // Cleanup
    g_ort->ReleaseValue(output_tensor);
    g_ort->ReleaseValue(input_tensor);
    g_ort->ReleaseMemoryInfo(memory_info);
    g_ort->ReleaseSession(session);
    g_ort->ReleaseEnv(env);

    // Free dynamically allocated input and output arrays
    if (input != NULL) {
        free(input);
        input = NULL;
    }
    if (output != NULL) {
        free(output);
        output = NULL;
    }
    if (norm_mean != NULL) {
        free(norm_mean);
        norm_mean = NULL;
    }
    if (norm_var != NULL) {
        free(norm_var);
        norm_var = NULL;
    }

    return;
}
