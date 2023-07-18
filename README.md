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
1. <ins>scl180: ![stats](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/scl180/synth_stat.txt)</ins>
   
2. <ins>sky130: ![stats](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/sky130/synth_stat.txt)</ins>

### power 
1. <ins>scl180: ![power_report](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/scl180/power_scl.txt)</ins>
 
2. <ins>sky130: ![power_report](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/sky130/power_sky.txt)</ins>


### timing 
1. <ins>scl180:![timing_report](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/scl180/timing_details_scl130.txt)</ins>

2. <ins>sky130: ![timing_report](https://github.com/vsdip/vsdscl180/blob/83f85ed33278ba3519867a79d0f2ba641ea1c1a4/synthesis/sky130/timing_details_sky130.txt)</ins>



|                 |SCL180                         |SKY130                        |
|-----------------|-------------------------------|----------------------------- |
|Area(nm²)        |      8313.580000              |    2623.766400               |
|Power(μW)        |      385.00                   |    360.00                    |
|Timing-speed(Mhz)|      220.75                   |    403.22                    |
  


