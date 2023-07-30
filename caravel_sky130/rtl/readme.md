## Info regarding the RTL files for caravel SoC
These RTL files are using for functional simulation.

but a few files have sky130 blocks already included.

such few files are:
1. RAM128.v -> RAM256.v -> mgmt_core.v -> mgmt_core_wrapper.v -> caravel_core.v -> caravel.v
2. simple_por -> caravel_core.v -> caravel.v
3. chip_io.v -> caravel.v
4. digital_pll.v -> caravel_core.v -> caravel.v
5. ring_osc2x13.v -> digital_pll.v    {used with a ifdef GL}
6. housekeeping.v -> caravel_core.v

and a few other rtl files have sky130 nodes already predefined.
