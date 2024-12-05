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
  annotation (Documentation(revisions="<html>
Revisions
November 21, 2024 by Thomas Sergi and Joshua Brun: Implemented.
</html>", info="<html>
<p>This example model demonstrates a double pendulum controlled by a neural network in Modelica, seamlessly integrated using the MoONNX Library. The controller utilizes normalized inputs, and its performance can be tested by applying forces to the pendulum&apos;s tip or joint</p>
</html>"));
end NNControllerNormalizedInputs;
