within MoONNX.Examples.DoublePendulum;
model NNControllerNormalizedInputs "Example of a double pendulum controlled by a neural network using normalized inputs."
  extends NNController(controller(
      fileName=Modelica.Utilities.Files.loadResource("modelica://MoONNX/Resources/ML-Models/ONNX-DoublePendulum_NormObs.onnx"),
      input_variables=5,
      use_NormalizedInputs=true,
      ObsNormmeanfile=Modelica.Utilities.Files.loadResource("modelica://MoONNX/Resources/ML-Models/obs_mean.txt"),
      ObsNormvarfile=Modelica.Utilities.Files.loadResource("modelica://MoONNX/Resources/ML-Models/obs_var.txt")));
equation
  connect(doublePendulum.MotorTorque, controller.observations[5])
    annotation (Line(points={{26,31.4},{26,20},{80,20},{80,-40},{64.2,-40}}, color={0,0,127}));
end NNControllerNormalizedInputs;
