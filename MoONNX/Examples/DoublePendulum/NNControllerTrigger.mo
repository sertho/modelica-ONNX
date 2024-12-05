within MoONNX.Examples.DoublePendulum;
model NNControllerTrigger "Example of a double pendulum controlled by a neural network using a fixed time trigger."
  extends MoONNX.Examples.DoublePendulum.NNController(controller(use_trigger=true));
  Modelica.Blocks.Sources.BooleanPulse TriggerPulse(
    width=1,
    period=0.01,
    startTime=0.0)
    "Pulse to trigger neural network execution" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-2,-100})));
equation
  connect(TriggerPulse.y, controller.trigger) annotation (Line(points={{9,-100},{30,-100},{30,-74.2}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(extent={{-100,-120},{100,100}})),
      Icon(coordinateSystem(extent={{-100,-120},{100,100}})),
    Documentation(revisions="<html>
Revisions
November 21, 2024 by Thomas Sergi and Joshua Brun: Implemented.
</html>", info="<html>
<p>This example model demonstrates a double pendulum controlled by a neural network in Modelica, seamlessly integrated using the MoONNX Library. The controller is activated manually using a fixed-time trigger.</p>
</html>"));
end NNControllerTrigger;
