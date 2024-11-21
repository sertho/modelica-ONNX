within ;
package MoONNX
  "Toolchain for including neural networks (saved as ONNX) in Modelica"

  extends Modelica.Icons.Package;

  annotation (uses(Modelica(version="4.0.0"), UserInteraction(version="0.70")),
                                               Icon(graphics={
        Polygon(
          points={{62,-58},{30,-32},{68,-16},{62,-58}},
          lineColor={0,0,0},
          fillColor={243,245,247},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{62,-58},{26,-74},{30,-32},{62,-58}},
          lineColor={0,0,0},
          fillColor={243,245,247},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{62,-58},{64,-78},{26,-74},{62,-58}},
          lineColor={0,0,0},
          fillColor={217,217,217},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{84,-44},{62,-58},{68,-16},{84,-44}},
          lineColor={0,0,0},
          fillColor={217,217,217},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{68,-16},{30,-32},{36,-8},{68,-16}},
          lineColor={0,0,0},
          fillColor={217,217,217},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,-32},{26,-74},{12,-42},{30,-32}},
          lineColor={0,0,0},
          fillColor={217,217,217},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{84,-44},{64,-78},{62,-58},{84,-44}},
          lineColor={0,0,0},
          fillColor={178,178,178},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{36,-8},{10,-44},{30,-32},{36,-8}},
          lineColor={0,0,0},
          fillColor={178,178,178},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{81,-42},{87,-48}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{65,-14},{71,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{33,-6},{39,-12}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{9,-40},{15,-46}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{23,-72},{29,-78}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{61,-76},{67,-82}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{27,-30},{33,-36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{59,-56},{65,-62}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Line(
          points={{68,-16},{84,-44}},
          color={0,0,0},
          thickness=1),
        Polygon(
          points={{-48,-20},{-48,-20}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{36,-8},{68,-16}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{36,-10},{30,-32}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{68,-16},{30,-32}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{68,-18},{62,-58}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{84,-44},{64,-78}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{84,-44},{62,-58}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{12,-42},{36,-8}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{30,-32},{26,-76}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{62,-58},{64,-80}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{30,-32},{62,-58}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{12,-42},{26,-74}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{26,-74},{62,-58}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{26,-74},{64,-78}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{30,-32},{12,-42}},
          color={0,0,0},
          thickness=1),
  Polygon(
    origin={1.0112,42.048},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
    points={{-93.0112,10.3188},{-93.0112,10.3188},{-73.011,24.6},{-63.011,31.221},{-51.219,36.777},{-39.842,38.629},{-31.376,36.248},{-25.819,29.369},{-24.232,22.49},{-23.703,17.463},{-15.501,25.135},{-6.24,32.015},{3.02,36.777},{15.191,39.423},{27.097,37.306},{32.653,29.633},{35.035,20.108},{43.501,28.046},{54.085,35.19},{65.991,39.952},{77.897,39.688},{87.422,33.338},{91.126,21.696},{90.068,9.525},{86.099,-1.058},{79.749,-10.054},{71.283,-21.431},{62.816,-33.337},{60.964,-32.808},{70.489,-16.14},{77.368,-2.381},{81.072,10.054},{79.749,19.05},{72.605,24.342},{61.758,23.019},{49.587,14.817},{39.003,4.763},{29.214,-6.085},{21.012,-16.669},{13.339,-26.458},{5.401,-36.777},{-1.213,-46.037},{-6.24,-53.446},{-8.092,-52.387},{-0.684,-40.746},{5.401,-30.692},{12.81,-17.198},{19.424,-3.969},{23.658,7.938},{22.335,18.785},{16.514,23.283},{8.047,23.019},{-1.478,19.05},{-11.267,11.113},{-19.734,2.381},{-29.259,-8.202},{-38.519,-19.579},{-48.044,-31.221},{-56.511,-43.392},{-64.449,-55.298},{-72.386,-66.939},{-77.678,-74.612},{-79.53,-74.083},{-71.857,-61.383},{-62.861,-46.037},{-52.278,-28.046},{-44.869,-15.346},{-38.784,-2.117},{-35.344,8.731},{-36.403,19.844},{-42.488,23.813},{-52.013,22.49},{-60.744,16.933},{-68.947,10.054},{-76.884,2.646},{-93.0112,-12.1707},{-93.0112,-12.1707}},
    smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>The ModelicaONNXFramework is a free library which alows you to run pre trained machine learning models directly integrated in your Modelica modeling and simulation environment. This is achieved by utilizing external C functions which utilize the ONNX Runtime&nbsp;library. As shown in the example, can neural networks easily be added by drag and drop the block &quot;RunONNX&quot; from the library.</p>
<p>The development page is <a href=\"https://github.com/sertho/modelica-ONNX\">https://github.com/sertho/modelica-ONNX</a>. Contributions to further advance the library are welcomed. Contributions may not only be in the form of model development, but also through model use, model testing, requirements definition or providing feedback regarding the model applicability to solve specific problems. </p>

<h4>Contact</h4>
Lucerne University of Applied Sciences and Arts<br>
Engineering and Architecture<br>
Institute of Mechanical Engineering and Energy Technology IME<br>
<br>
Technikumstrasse 21<br>
6048 Horw<br>
Switzerland<br>
<br>
Thomas Sergi, <a href=\"mailto:thomas.sergi@hslu.ch\">thomas.sergi@hslu.ch</a><br>
Joshua Brun, <a href=\"mailto:joshua.brun@hslu.ch\">joshua.brun@hslu.ch</a> <br>
</html>", revisions="<html>
<ul>
<li>November 21, 2024 by Thomas Sergi and Joshua Brun:<br>Implemented.</li>
</ul>
</html>"));
end MoONNX;
