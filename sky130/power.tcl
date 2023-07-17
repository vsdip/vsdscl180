read_liberty sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog 1_synth.v
link_design gcd
create_clock -name clk -period 10 {clk}
set_input_delay -clock clk 0.1 {req_msg req_val reset resp_rdy}
set_power_activity -input -activity 0.1
set_power_activity -input_port reset -activity 0
report_power > power_sky.txt
exit
