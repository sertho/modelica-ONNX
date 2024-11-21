within MoONNX;
block RunONNX "Block that runs ONNX models from modelica"
  extends Modelica.Blocks.Icons.Block;
  parameter String fileName = "NoName" "ONNX file" annotation (Dialog(loadSelector(filter="ONNX files (*.onnx)", caption="Choose onnx file")));
  parameter Integer input_variables  "Number of Input variables";
  parameter Integer output_variables "Number of Output variables";
  parameter Boolean use_trigger = false "Set true to use external trigger signal" annotation(choices(checkBox=true));
  parameter Integer initializer = 0;
  parameter Modelica.Units.SI.Time period(final min=Modelica.Constants.small) if not use_trigger "Sample period" annotation(Dialog(enable = not use_trigger, groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/SampleTrigger.png"));
  parameter Modelica.Units.SI.Time startTime if not use_trigger "Time instant of first sample trigger" annotation(Dialog(enable = not use_trigger));
  parameter Boolean use_NormalizedInputs = false "Set true to use normalized inputs" annotation(choices(checkBox=true));
  parameter String ObsNormmeanfile = "NoName" "Choose txt file with the mean values of the inputs for normalization" annotation (Dialog(loadSelector(filter="txt files (*.txt)", caption="Choose txt file with parameter for normalization")));
  parameter String ObsNormvarfile = "NoName" "Choose txt file with the var values of the inputs for normalization" annotation (Dialog(loadSelector(filter="txt files (*.txt)", caption="Choose txt file with parameter for normalization")));

  Modelica.Blocks.Interfaces.RealInput observations[input_variables]
    annotation (
    Placement(
      transformation(extent={{-128,-14},{-100,14}}),
      iconTransformation(extent={{-128,-14},{-100,14}})));
  Modelica.Blocks.Interfaces.RealOutput actions[output_variables]
    annotation (
    Placement(transformation(
      extent={{-14,-14},{14,14}},
      rotation=0,
      origin={114,0}),
      iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={114,0})));
  Modelica.Blocks.Interfaces.BooleanInput trigger if use_trigger
    annotation (
      Placement(transformation(
        extent={{14,14},{-14,-14}},
        rotation=-90,
        origin={0,-114}),iconTransformation(
        extent={{14,14},{-14,-14}},
        rotation=-90,
        origin={0,-114})));
  Modelica.Blocks.Sources.SampleTrigger sampleTrigger(period=period, startTime=startTime) if not use_trigger
    annotation (Placement(transformation(extent={{-48,-70},{-28,-50}})));
  Modelica.Blocks.Routing.BooleanPassThrough local_trigger annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-20})));

protected
  final parameter Boolean init = MoONNX.Functions.InitializeONNXModel(
    input_variables, output_variables, fileName, use_NormalizedInputs, ObsNormmeanfile, ObsNormvarfile) annotation(Hide=true);

equation
  when local_trigger.y then
    MoONNX.Functions.RunONNXModel(observations, size(observations, 1),
      use_NormalizedInputs);
   for i in 1:output_variables loop
      actions[i] = MoONNX.Functions.GetDatafromStorage(i - 1);
   end for;

  end when;

  connect(trigger, local_trigger.u)
    annotation (Line(points={{0,-114},{0,-32}},
                                              color={255,0,255}));
  connect(sampleTrigger.y, local_trigger.u)
    annotation (Line(points={{-27,-60},{0,-60},{0,-32}},
                                                      color={255,0,255}));
  annotation (
    Icon(
      graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,100},{100,72}},
          textString="Neural Network",
          textColor={0,0,0}),
        Ellipse(
          extent={{-76,66},{-56,46}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,40},{-56,20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,-38},{-56,-58}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,-12},{-56,-32}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,14},{-56,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,-66},{-56,-86}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,52},{10,32}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,26},{10,6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,0},{10,-20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,-26},{10,-46}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,-52},{10,-72}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{56,12},{76,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{56,-14},{76,-34}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-56,54},{-8,48}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,28},{-10,18}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,2},{-10,-8}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,-24},{-10,-34}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,-50},{-10,-60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,-76},{-10,-64}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,-48},{-10,-38}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,-22},{-10,-12}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,4},{-10,14}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,32},{-10,44}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-58,50},{-8,22}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-58,24},{-8,-4}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-58,-2},{-8,-30}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-58,-28},{-8,-56}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,-74},{-8,-42}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,-46},{-8,-16}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-56,-20},{-8,10}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-58,10},{-10,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-58,-16},{-8,36}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,-40},{-6,34}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-58,-42},{-6,8}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,-68},{-2,6}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-58,-70},{-6,-18}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,48},{-6,-2}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-64,46},{-6,-28}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,-4},{-6,-54}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,22},{-2,-52}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{10,40},{58,8}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{8,36},{60,-16}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{8,10},{58,-18}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{10,-12},{56,-22}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{10,-34},{56,-24}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{8,-56},{58,-30}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{10,16},{56,4}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{10,-8},{56,0}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{8,-30},{58,-4}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{6,-54},{60,-6}},
          color={0,0,0},
          thickness=0.5)}),
    experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=200,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Documentation(info="<html>
<p>Block for running neural networks (saved as ONNX files) from Modelica.</p>
<p>Neural networks can be easily added by dragging and dropping the &quot;RunONNX&quot; block from the library. Then it&apos;s only necessary to adapt the parameters (inputs, outputs, ...) to match the neural network saved in the onnx file.</p>
</html>"));
end RunONNX;
