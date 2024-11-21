within MoONNX;
class Functions "Functions for ONNX interface"
  extends Modelica.Icons.FunctionsPackage;

  //extends ModelicaReference.Classes.ExternalObject;

  function InitializeONNXModel "Initializes the ONNX Model and Storage spaces"
    extends Modelica.Icons.Function;
    input Integer input_variables;                // Number of input variables
    input Integer output_variables;               // Number of output variables
    input String fileName;                        // Name of the ONNX model file
    input Boolean use_NormalizedInputs;           // Choose if Normalized inputs are used or not
    input String ObsNormmeanfile;                 // Name of the file which contains the mean values for normalization
    input String ObsNormvarfile;                  // Name of the file which contains the variance values for normalization
    output Boolean init;
    external "C" init = InitializeONNXModel(input_variables, output_variables, fileName, use_NormalizedInputs, ObsNormmeanfile, ObsNormvarfile)
      annotation (
        IncludeDirectory={"modelica://MoONNX/Resources/include"},
        LibraryDirectory={"modelica://MoONNX/Resources"},
        Library={"onnxruntime"},
        Include="#include <ONNXCWrapper.c>");
  end InitializeONNXModel;

  function RunONNXModel "Runs the ONNX Model and saves calculated actions in Storage"
    input Real observations[:];                  // Array of input observations
    input Integer observation_size;              // Size of Input Array
    input Boolean use_NormalizedInputs;           // Choose if Normalized inputs are used or not
    external "C" RunONNXModel(observations, observation_size, use_NormalizedInputs)
      annotation (
        IncludeDirectory={"modelica://MoONNX/Resources/include"},
        LibraryDirectory={"modelica://MoONNX/Resources"},
        Library={"onnxruntime"},
        Include="#include <ONNXCWrapper.c>");
  end RunONNXModel;

  function GetDatafromStorage "Gets the saved actions from Storage"
  input Integer out;
  output Real actions;
  external "C" actions = GetDatafromStorage(out)
    annotation (
      IncludeDirectory={"modelica://MoONNX/Resources/include"},
      LibraryDirectory={"modelica://MoONNX/Resources"},
      Library={"onnxruntime"},
      Include="#include <ONNXCWrapper.c>");
  end GetDatafromStorage;

  function ReleaseONNXModel "Runs the ONNX Model and saves calculated actions in Storage"
    external "C" ReleaseONNXModel()
      annotation (
        IncludeDirectory={"modelica://MoONNX/Resources/include"},
        LibraryDirectory={"modelica://MoONNX/Resources"},
        Library={"onnxruntime"},
        Include="#include <ONNXCWrapper.c>");
  end ReleaseONNXModel;

end Functions;
