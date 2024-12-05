# MoONNX

---

Integrate machine learning models **directly into your Modelica models** with **MoONNX**.

---

<br/>

<p align="center">
    <img src="images/Block.PNG" alt="Block in Modelica" width=35%>
</p>

<p align="center">
    <b>Fig 1: RunONNX block to implemented neural networks in Modelica</b>
</p>

<br/>
<br/>


## Features of MoONNX
MoONNX empowers you to run  pre trained machine learning models directly integrated in your Modelica
modeling and simulation environment. This is achieved by utilizing external C functions which utilize the ONNX Runtime [library](https://github.com/microsoft/onnxruntime).
As shown in the example, can neural networks easily be added by drag and drop the block "RunONNX" from the library.


<br/>

<p align="center">
    <img src="images/Dymola-Graphics_wo_lines.PNG" alt="Dymola graphics of a double pendulum model controlled by a integrated neural network" width=40%>
    <img src="images/Double_Pendulum.gif" alt="Animation of double pendulum controlled by neural network" width=40%>
</p>

<p align="center">
    <b>Fig 2/3: Double pendulum model controlled with a neural network</b>
</p>

<br/>
<br/>

## Areas of application
**Test neural networks in various simulation scenarios** <br/>
Utilize all the modeling and simulation tools available to observe how your neural networks respond to different scenarios.

<p align="center">
    <img src="images/Example_Double_Pendulum_pass.gif" alt="Animation of double pendulum controlled by neural network test pass" width=45%>
    <img src="images/Example_Double_Pendulum_fail.gif" alt="Animation of double pendulum controlled by neural network test fail" width=45%>
</p>

<p align="center">
    <b>Fig 4/5: Test of a double pendulum model controlled with a neural network</b>
</p>

<br/>
<br/>

**Integrate surrogate models for faster simulations** <br/>
Replace detailed system models with machine learning-based surrogate models to speed up simulations.

**ToDo:**
add example

<br/>
<br/>

## Getting Started
Follow these steps to use MoONNX in your projects:

1. Download the repository, then copy the folder "MoONNX" to your Dymola libraries.
2. Save your trained machine learning model as ONNX and move it to the working directory.
3. Add the ONNX model into your Modelica simulations.
4. Choose the desired ONNX for the parameter "fileName".
5. Configure parameters in your modelica simulation to match those from your trained neural network.

<br/>

 <p align="center">
    <img src="images/Setting_NN.PNG" alt="Graphics of neural ONNX-Modelica-Framework settings" width=50%>
 </p>

<br/>

## Further questions?
Please feel free to bring up Ideas for improvement!
If you have any questions or suggestions for improvement, please raise an issue on our GitHub [issue](https://github.com/BrunJoshHSLU/ONNX-Modelica-Framework/issues) page.
