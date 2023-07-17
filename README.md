# vsdscl180

We are checking the compatibility of scl180 with openroad flow.

## example 
  1. ![gcd](https://github.com/vsdip/vsdscl180/blob/main/synthesis/scl180/1_1_yosys.v)
     - we have chosen a simple example and started analyzing and comparing the outputs with sky130hd gcd example already availiable in the openroad flow.

Tools : ![OpenRoad flow](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts).

## Firstly, we start with synthesis:

we use the OpenRoad tools flow to generate the required synthesized code.(Gate level netlist)

then we use the OpenSTA tool to get details such as timing & power.

we can see the comparision below:

### instances 
1. scl180: ![stats](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/scl180/synth_stat.txt)
 <br>  Chip area for module '\gcd': 8313.580000

        
2. sky130: ![stats](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/sky130/synth_stat.txt)
<br>  Chip area for module '\gcd': 2623.766400



### power 
1. scl180: ![power_report](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/scl180/power_scl.txt)
   Total power consumption - 3.85e-04 Watt

        
2. sky130: ![power_report](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/sky130/power_sky.txt)
   Total power consumption - 3.60e-04 Watt

### timing 
1. scl180:![timing_report](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/scl180/timing_details_scl130.txt)
  <br>Startpoint: reset (input port clocked by clk)
  <br>Endpoint: _484_ (rising edge-triggered flip-flop clocked by clk)
  <br>Path Group: clk
  <br>Path Type: min
   <br>_**0.20   slack (MET)**_

    <br>Startpoint: _493_ (rising edge-triggered flip-flop clocked by clk)
    <br>Endpoint: _505_ (rising edge-triggered flip-flop clocked by clk)
    <br>Path Group: clk
    <br>Path Type: max 
    <br>_**5.47   slack (MET)**_
        
2. sky130: ![timing_report](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/sky130/timing_details_sky130.txt)
   <br> Startpoint: reset (input port clocked by clk)
   <br>Endpoint: _544_ (rising edge-triggered flip-flop clocked by clk)
   <br>Path Group: clk
   <br>Path Type: min
   <br>_**0.17   slack (MET)**_
  
    <br>Startpoint: _546_ (rising edge-triggered flip-flop clocked by clk)
    <br>Endpoint: _546_ (rising edge-triggered flip-flop clocked by clk)
    <br>Path Group: clk
    <br>Path Type: max
    <br>_**7.52   slack (MET)**_

