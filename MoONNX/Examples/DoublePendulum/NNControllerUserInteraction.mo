within MoONNX.Examples.DoublePendulum;
model NNControllerUserInteraction
  "Example of a double pendulum controlled by a neural network. Extended with live user interaction."
  extends MoONNX.Examples.DoublePendulum.NNController
                                (break disturbance_joint, break disturbance_tip);
  UserInteraction.Inputs.Slider Slider1(min=0, max=100)
    annotation (Placement(transformation(extent={{-116,-10},{-96,10}},
            rotation=0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-30})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,30})));
  UserInteraction.Inputs.ToggleButton ToggleButton1(label="On/Off")
    annotation (Placement(transformation(extent={{-110,-40},{-90,-20}},
                                                                     rotation=
             0)));
  UserInteraction.Inputs.Slider Slider2(min=0, max=100)
    annotation (Placement(transformation(extent={{-116,70},{-96,90}},
            rotation=0)));
  Modelica.Blocks.Math.Product product2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,80})));
  UserInteraction.Inputs.ToggleButton ToggleButton2(label="On/Off")
    annotation (Placement(transformation(extent={{-110,40},{-90,60}},rotation=
             0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,50})));
equation
  connect(product1.y, doublePendulum.input_force_joint) annotation (Line(
        points={{-40,41},{-40,60},{-5.2,60}}, color={0,0,127}));
  connect(booleanToReal.y, product1.u2) annotation (Line(points={{-59,-30},
          {-34,-30},{-34,18}}, color={0,0,127}));
  connect(ToggleButton2.buttonState, booleanToReal1.u)
    annotation (Line(points={{-90,50},{-82,50}}, color={255,0,255}));
  connect(booleanToReal1.y, product2.u2) annotation (Line(points={{-59,50},
          {-50,50},{-50,74},{-42,74}}, color={0,0,127}));
  connect(Slider2.Value, product2.u1) annotation (Line(points={{-96,80},{
          -80,80},{-80,86},{-42,86}}, color={0,0,127}));
  connect(Slider1.Value, product1.u1)
    annotation (Line(points={{-96,0},{-46,0},{-46,18}}, color={0,0,127}));
  connect(ToggleButton1.buttonState, booleanToReal.u)
    annotation (Line(points={{-90,-30},{-82,-30}}, color={255,0,255}));
  connect(product2.y, doublePendulum.input_force_tip) annotation (Line(
        points={{-19,80},{-5.2,80},{-5.2,80.8}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=10,
      Interval=0.001,
      __Dymola_Algorithm="Cvode"),
    Diagram(coordinateSystem(extent={{-120,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-120,-100},{100,100}})),
    Documentation(revisions="<html>
Revisions
November 21, 2024 by Thomas Sergi and Joshua Brun: Implemented.
</html>", info="<html>
<p>This example model demonstrates a double pendulum controlled by a neural network in Modelica, seamlessly integrated using the MoONNX Library. The enhanced version includes an option for user interaction, allowing dynamic testing and exploration of the controller&apos;s behavior.</p>
</html>"));
end NNControllerUserInteraction;
