within MoONNX.Examples.DoublePendulum;
model DoublePendulumSystem "Modelica model of a double pendulum driven by a torque applied to the centre."

  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.Units.SI.Density pendulum_density=7900;
  parameter Modelica.Units.SI.Angle initangle1=-Modelica.Constants.pi*0.5;
  parameter Modelica.Units.SI.Angle initangle2=0;

  inner Modelica.Mechanics.MultiBody.World world
    annotation (Placement(transformation(extent={{50,-90},{30,-70}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(useAxisFlange=true,
    phi(
      fixed=true,
      start=initangle1,
      displayUnit="rad"),
    w(start=0, fixed=true))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-40})));
  Modelica.Mechanics.Rotational.Components.Damper damper1(d=0.1)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-40,-38})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(
    r={0.5,0,0},
    width=0.06,
    density=pendulum_density)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90)));

  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(useAxisFlange=true,
      phi(start=initangle2, fixed=true),
    w(start=0, fixed=true))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,40})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody2(
    r={0.5,0,0},
    width=0.06,
    density=pendulum_density)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,78})));
  Modelica.Mechanics.MultiBody.Sensors.RelativeSensor relativeSensor2(
      get_angles=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,38})));
  Modelica.Mechanics.MultiBody.Sensors.RelativeAngularVelocity
    relativeAngularVelocity2
    annotation (Placement(transformation(extent={{10.5,10},{-10.5,-10}},
        rotation=270,
        origin={30,39.5})));
  Modelica.Mechanics.Rotational.Components.Damper damper2(d=3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,60})));
  Modelica.Mechanics.Rotational.Sources.Torque torque1
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Interfaces.RealInput input_torque          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput angle2
    annotation (Placement(transformation(extent={{100,20},{120,40}}),
        iconTransformation(extent={{100,20},{120,40}})));
  Modelica.Mechanics.MultiBody.Sensors.RelativeAngularVelocity
    relativeAngularVelocity1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-40})));
  Modelica.Mechanics.MultiBody.Sensors.RelativeSensor relativeSensor1(
      get_angles=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-42})));

  Modelica.Blocks.Interfaces.RealOutput anglevelocity2
    annotation (Placement(transformation(extent={{100,70},{120,90}}),
        iconTransformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput anglevelocity1
    annotation (Placement(transformation(extent={{100,-40},{120,-20}}),
        iconTransformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput angle1
    annotation (Placement(transformation(extent={{100,-90},{120,-70}}), iconTransformation(extent={{100,-90},{120,-70}})));
  Modelica.Mechanics.MultiBody.Forces.WorldForce force_tip annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-28,90})));
  Modelica.Mechanics.MultiBody.Forces.WorldForce force_joint annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,20})));
  Modelica.Blocks.Interfaces.RealInput input_force_joint
    "Disturbance force on joint"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput input_force_tip
    "Disturbance force on tip"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Math.Gain Torque_multiplier(k=200) "torque multiplier"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-80,-40})));
  Modelica.Blocks.Sources.Constant const(k=0)
    "Constant for the forces acting in x-, z-direction (always = 0)"
                                              annotation (Placement(transformation(extent={{-90,40},
            {-70,60}})));
  Modelica.Blocks.Sources.RealExpression MotorTorqueSize(y=torque1.tau)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-70})));
  Modelica.Blocks.Interfaces.RealOutput MotorTorque annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-110}), iconTransformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
equation
  connect(boxBody1.frame_b, revolute2.frame_a) annotation (Line(
      points={{0,10},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b, boxBody2.frame_a) annotation (Line(
      points={{0,50},{0,68}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_a, relativeSensor2.frame_a) annotation (Line(
      points={{0,30},{0,20},{60,20},{60,28}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b, relativeSensor2.frame_b) annotation (Line(
      points={{0,50},{0,60},{60,60},{60,48}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeAngularVelocity2.frame_a, revolute2.frame_a) annotation (Line(
      points={{30,29},{30,20},{0,20},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(damper2.flange_a, revolute2.support) annotation (Line(points={{-40,50},
          {-40,34},{-10,34}},          color={0,0,0}));
  connect(damper2.flange_b, revolute2.axis) annotation (Line(points={{-40,70},
          {-40,80},{-20,80},{-20,40},{-10,40}},
                                   color={0,0,0}));
  connect(revolute1.frame_b, boxBody1.frame_a) annotation (Line(
      points={{0,-30},{0,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.axis, torque1.flange) annotation (Line(points={{-10,-40},
          {-20,-40},{-20,-20},{-50,-20}},          color={0,0,0}));
  connect(damper1.flange_b, revolute1.axis) annotation (Line(points={{-40,-28},
          {-40,-20},{-20,-20},{-20,-40},{-10,-40}},
                                         color={0,0,0}));
  connect(damper1.flange_a, revolute1.support) annotation (Line(points={{-40,-48},
          {-40,-60},{-20,-60},{-20,-46},{-10,-46}}, color={0,0,0}));
  connect(relativeAngularVelocity1.frame_b, revolute1.frame_b) annotation (Line(
      points={{30,-30},{30,-20},{0,-20},{0,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeSensor1.frame_b, revolute1.frame_b) annotation (Line(
      points={{60,-32},{60,-20},{0,-20},{0,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeSensor1.frame_a, revolute1.frame_a) annotation (Line(
      points={{60,-52},{60,-60},{0,-60},{0,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeAngularVelocity1.frame_a, revolute1.frame_a) annotation (Line(
      points={{30,-50},{30,-60},{0,-60},{0,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(anglevelocity1, anglevelocity1)
    annotation (Line(points={{110,-30},{110,-30}}, color={0,0,127}));
  connect(world.frame_b, revolute1.frame_a) annotation (Line(
      points={{30,-80},{0,-80},{0,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeAngularVelocity1.w_rel[3], anglevelocity1) annotation (Line(
        points={{40.6667,-40},{44,-40},{44,-30},{110,-30}},
                                                    color={0,0,127}));
  connect(relativeSensor1.angles[3], angle1) annotation (Line(points={{70.6667,
          -40},{80,-40},{80,-80},{110,-80}},  color={0,0,127}));
  connect(relativeAngularVelocity2.w_rel[3], anglevelocity2)
    annotation (Line(points={{40.6667,39.5},{44,39.5},{44,80},{110,80}},
                                                             color={0,0,127}));
  connect(relativeSensor2.angles[3], angle2) annotation (Line(points={{70.6667,
          40},{90,40},{90,30},{110,30}},     color={0,0,127}));
  connect(relativeAngularVelocity2.frame_b, revolute2.frame_b) annotation (Line(
      points={{30,50},{30,60},{0,60},{0,50}},
      color={95,95,95},
      thickness=0.5));
  connect(force_tip.frame_b, boxBody2.frame_b) annotation (Line(
      points={{-16,90},{0,90},{0,88}},
      color={95,95,95},
      thickness=0.5));
  connect(force_joint.frame_b, revolute2.frame_a) annotation (Line(
      points={{-20,20},{0,20},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(Torque_multiplier.y, torque1.tau) annotation (Line(points={{-80,
          -29},{-80,-20},{-72,-20}}, color={0,0,127}));
  connect(input_torque, Torque_multiplier.u) annotation (Line(points={{-120,
          -80},{-80,-80},{-80,-52}}, color={0,0,127}));
  connect(input_force_tip, force_tip.force[1]) annotation (Line(points={{
          -120,80},{-60,80},{-60,90},{-44,90},{-44,89.2},{-42.4,89.2}},
        color={0,0,127}));
  connect(const.y, force_tip.force[2]) annotation (Line(points={{-69,50},{
          -60,50},{-60,90},{-42.4,90}}, color={0,0,127}));
  connect(const.y, force_tip.force[3]) annotation (Line(points={{-69,50},{
          -60,50},{-60,90},{-44,90},{-44,90.8},{-42.4,90.8}}, color={0,0,
          127}));
  connect(input_force_joint, force_joint.force[1]) annotation (Line(points={{-120,0},
          {-60,0},{-60,19.3333},{-42,19.3333}},           color={0,0,127}));
  connect(const.y, force_joint.force[2]) annotation (Line(points={{-69,50},
          {-60,50},{-60,20},{-42,20}}, color={0,0,127}));
  connect(const.y, force_joint.force[3]) annotation (Line(points={{-69,50},{-60,
          50},{-60,20},{-42,20},{-42,20.6667}},      color={0,0,127}));
  connect(MotorTorqueSize.y, MotorTorque)
    annotation (Line(points={{-60,-81},{-60,-110}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=30,
      Interval=0.001,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>
This example demonstrates at hand of a double pendulum,
how non-standard initialization can be defined:
The absolute position of the pendulum tip, and its absolute speed
shall be initially defined. This can be performed with the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit\">Joints.FreeMotionScalarInit</a>
joint that allows to initialize individual elements of its relative vectors.
In this case, the x-, and y-coordinates of the relative position vector
(visualized by the yellow arrow in the figure below) and of its
derivative shall have a defined value at initial time.
The configuration of the double pendulum at the initial time is
shown below, where the tip position is required to have the coordinates
x=0.7, y=0.3.
</p>
<p>
Setting only the tip&#39;s start position results in an ambiguous initialization since
two valid solutions for <code>revolute1.phi</code> and <code>revolute2.phi</code> exist.
Moreover, the calculated angles <code>revolute1.phi</code> and <code>revolute2.phi</code>
can be a multiple of expected solution <code>phi1</code> and <code>phi2</code>,
</p>
<ul>
<li>revolute1.phi(k1) = phi1 + 2 &pi; k1,</li>
<li>revolute2.phi(k2) = phi2 + 2 &pi; k2.</li>
</ul>
<p>
To clearly indicate the preferred solution, guess initial angles can be additionally given.
In this example, it is simply done by <code>revolute2.phi.start&nbsp;=&nbsp;Modelica.Constants.pi/2</code>.
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulumInitTip.png\">
</blockquote>
</html>", revisions="<html>
Revisions
November 21, 2024 by Thomas Sergi and Joshua Brun: Implemented.
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-14,14},{16,-16}},
          lineColor={0,0,0},
          lineThickness=1,
          closure=EllipseClosure.None),
        Rectangle(
          extent={{-20,20},{22,-2}},
          lineColor={255,255,255},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-8,42},{10,-4}}, lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Forward,
          radius=7.5),
        Ellipse(extent={{-8,8},{10,-10}},  lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Rectangle(
          extent={{-8,86},{10,40}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Forward,
          radius=7.5),
        Ellipse(extent={{-8,50},{10,32}},  lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Line(
          points={{-100,80},{-50,80},{-44,80},{-44,80}},
          color={0,0,127}),
        Line(
          points={{-44,80},{-8,80}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-18,88},{-8,80}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-8,80},{-18,72}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-18,48},{-8,40}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-8,40},{-18,32}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-44,40},{-8,40}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-100,0},{-52,0},{-52,40},{-44,40}},
          color={0,0,127}),
        Text(
          extent={{-36,64},{-26,34}},
          textColor={0,0,0},
          textStyle={TextStyle.Bold},
          textString="F"),
        Text(
          extent={{-36,104},{-26,74}},
          textColor={0,0,0},
          textStyle={TextStyle.Bold},
          textString="F"),
        Line(
          points={{-100,-80},{0,-80},{0,-20}},
          color={0,0,127}),
        Line(
          points={{14,-6},{16,0}},
          color={255,255,255},
          thickness=1),
        Line(
          points={{12,-6},{16,-2},{18,-6}},
          color={0,0,0},
          thickness=1),
        Text(
          extent={{12,-4},{24,-36}},
          textColor={0,0,0},
          textStyle={TextStyle.Bold},
          textString="M"),
        Line(
          points={{0,-100},{0,-80}},
          color={0,0,127})}));
end DoublePendulumSystem;
