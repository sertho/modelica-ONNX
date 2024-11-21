within MoONNX.Examples.DoublePendulum;
model NNController "Example of a double pendulum controlled by a neural network."
  extends Modelica.Icons.Example;
  MoONNX.Examples.DoublePendulum.DoublePendulumSystem doublePendulum
    annotation (Placement(transformation(
        extent={{-26,-26},{26,26}},
        rotation=0,
        origin={26,60})));

  Modelica.Blocks.Sources.Pulse disturbance_tip(
    amplitude=0,
    width=1,
    period=10,
    startTime=5) "Pulse for the force acting on the tip in x-direction"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,80})));
  Modelica.Blocks.Sources.Pulse disturbance_joint(
    amplitude=0,
    width=2.5,
    period=10,
    startTime=5) "Pulse for the force acting on the joint in y-direction"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,40})));
  MoONNX.RunONNX controller(
    fileName=Modelica.Utilities.Files.loadResource("modelica://MoONNX/Resources/ML-Models/ONNX-DoublePendulum.onnx"),
    input_variables=4,
    output_variables=1,
    use_trigger=false,
    period=0.01,
    startTime=0,
    use_NormalizedInputs=false) annotation (Placement(transformation(extent={{60,-70},{0,-10}})));
equation
  connect(doublePendulum.angle1, controller.observations[1])
    annotation (Line(points={{54.6,39.2},{80,39.2},{80,-40},{64.2,-40},{64.2,-41.575}}, color={0,0,127}));
  connect(doublePendulum.anglevelocity1, controller.observations[3])
    annotation (Line(points={{54.6,52.2},{80,52.2},{80,-40},{74,-40},{74,-39.475},{64.2,-39.475}}, color={0,0,127}));
  connect(doublePendulum.angle2, controller.observations[2])
    annotation (Line(points={{54.6,67.8},{80,67.8},{80,-40},{74,-40},{74,-40.525},{64.2,-40.525}}, color={0,0,127}));
  connect(doublePendulum.anglevelocity2, controller.observations[4])
    annotation (Line(points={{54.6,80.8},{80,80.8},{80,-40},{64.2,-40},{64.2,-38.425}}, color={0,0,127}));
  connect(disturbance_joint.y, doublePendulum.input_force_joint)
    annotation (Line(points={{-59,40},{-40,40},{-40,60},{-5.2,60}}, color={
          0,0,127}));
  connect(controller.actions[1], doublePendulum.input_torque)
    annotation (Line(points={{-4.2,-40},{-20,-40},{-20,40},{-6,40},{-6,39.2},{-5.2,39.2}}, color={0,0,127}));
  connect(disturbance_tip.y, doublePendulum.input_force_tip) annotation (
      Line(points={{-59,80},{-5.2,80},{-5.2,80.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(
      StopTime=10,
      Interval=0.001,
      __Dymola_Algorithm="Cvode"));
end NNController;
