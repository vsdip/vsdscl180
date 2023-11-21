`include "pc3d01_wrapper.v"
`include "pc3d21.v"
`include "pt3b02_wrapper.v"
`include "pc3b03ed_wrapper.v"
// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

// `default_nettype none
module chip_io(
	// Package Pins
	inout  vddio_pad,		// Common padframe/ESD supply
	inout  vddio_pad2,
	inout  vssio_pad,		// Common padframe/ESD ground
	inout  vssio_pad2,
	inout  vccd_pad,		// Common 1.8V supply
	inout  vssd_pad,		// Common digital ground
	inout  vdda_pad,		// Management analog 3.3V supply
	inout  vssa_pad,		// Management analog ground
	output  vdda1_pad,		// User area 1 3.3V supply
	inout  vdda1_pad2,		
	inout  vdda2_pad,		// User area 2 3.3V supply
	inout  vssa1_pad,		// User area 1 analog ground
	inout  vssa1_pad2,
	inout  vssa2_pad,		// User area 2 analog ground
	inout  vccd1_pad,		// User area 1 1.8V supply
	inout  vccd2_pad,		// User area 2 1.8V supply
	inout  vssd1_pad,		// User area 1 digital ground
	inout  vssd2_pad,		// User area 2 digital ground

	// Core Side
	inout  vddio,		// Common padframe/ESD supply
	inout  vssio,		// Common padframe/ESD ground
	inout  vccd,		// Common 1.8V supply
	inout  vssd,		// Common digital ground
	inout  vdda,		// Management analog 3.3V supply
	inout  vssa,		// Management analog ground
	inout  vdda1,		// User area 1 3.3V supply
	inout  vdda2,		// User area 2 3.3V supply
	inout  vssa1,		// User area 1 analog ground
	inout  vssa2,		// User area 2 analog ground
	inout  vccd1,		// User area 1 1.8V supply
	inout  vccd2,		// User area 2 1.8V supply
	inout  vssd1,		// User area 1 digital ground
	inout  vssd2,		// User area 2 digital ground

	inout  gpio,
	input  clock,
	input  resetb,
	output flash_csb,
	output flash_clk,
	inout  flash_io0,
	inout  flash_io1,
	// Chip Core Interface
	input  porb_h,
	input  por,
	output resetb_core_h,
	output clock_core,
	input  gpio_out_core,
	output gpio_in_core,
	input  gpio_mode0_core,
	input  gpio_mode1_core,
	input  gpio_outenb_core,
	input  gpio_inenb_core,
	input  flash_csb_core,
	input  flash_clk_core,
	input  flash_csb_oeb_core,
	input  flash_clk_oeb_core,
	input  flash_io0_oeb_core,
	input  flash_io1_oeb_core,
	input  flash_io0_ieb_core,
	input  flash_io1_ieb_core,
	input  flash_io0_do_core,
	input  flash_io1_do_core,
	output flash_io0_di_core,
	output flash_io1_di_core,
	// User project IOs
	// we will be using only mprj_io, mprj_io_out, mprj_io_oeb
	inout [`MPRJ_IO_PADS-1:0] mprj_io,
	input [`MPRJ_IO_PADS-1:0] mprj_io_out,
	input [`MPRJ_IO_PADS-1:0] mprj_io_oeb,
	input [`MPRJ_IO_PADS-1:0] mprj_io_inp_dis,
	input [`MPRJ_IO_PADS-1:0] mprj_io_ib_mode_sel,
	input [`MPRJ_IO_PADS-1:0] mprj_io_vtrip_sel,
	input [`MPRJ_IO_PADS-1:0] mprj_io_slow_sel,
	input [`MPRJ_IO_PADS-1:0] mprj_io_holdover,
	input [`MPRJ_IO_PADS-1:0] mprj_io_analog_en,
	input [`MPRJ_IO_PADS-1:0] mprj_io_analog_sel,
	input [`MPRJ_IO_PADS-1:0] mprj_io_analog_pol,
	input [`MPRJ_IO_PADS*3-1:0] mprj_io_dm,
	output [`MPRJ_IO_PADS-1:0] mprj_io_in,
	// Loopbacks to constant value 1 in the 1.8V domain
	input [`MPRJ_IO_PADS-1:0] mprj_io_one,
	// User project direct access to gpio pad connections for analog
	// (all but the lowest-numbered 7 pads)
	inout [`MPRJ_IO_PADS-10:0] mprj_analog_io
);

    wire [`MPRJ_IO_PADS-1:0] dummy_mprj_io_in;
    // To be considered:  Master hold signal on all user pads (?)
    // For now, set holdh_n to 1 internally (NOTE:  This is in the
    // VDDIO 3.3V domain)
    // and setting enh to porb_h.

    wire [`MPRJ_IO_PADS-1:0] mprj_io_enh;

    assign mprj_io_enh = {`MPRJ_IO_PADS{porb_h}};
	
	wire analog_a, analog_b;
	wire vddio_q, vssio_q;
	// updating for pads.
	wire \dm_all[0] ;
        wire \dm_all[1] ;
        wire \dm_all[2] ;        
          wire \flash_io0_mode[0] ;
  wire \flash_io0_mode[1] ;
  wire \flash_io0_mode[2] ;
  wire \flash_io1_mode[0] ;
  wire \flash_io1_mode[1] ;
  wire \flash_io1_mode[2] ;
wire \mprj_pads.analog_a ;
  wire \mprj_pads.analog_b ;
  wire \mprj_pads.analog_en[0] ;
  wire \mprj_pads.analog_en[10] ;
  wire \mprj_pads.analog_en[11] ;
  wire \mprj_pads.analog_en[12] ;
  wire \mprj_pads.analog_en[13] ;
  wire \mprj_pads.analog_en[14] ;
  wire \mprj_pads.analog_en[15] ;
  wire \mprj_pads.analog_en[16] ;
  wire \mprj_pads.analog_en[17] ;
  wire \mprj_pads.analog_en[18] ;
  wire \mprj_pads.analog_en[19] ;
  wire \mprj_pads.analog_en[1] ;
  wire \mprj_pads.analog_en[20] ;
  wire \mprj_pads.analog_en[21] ;
  wire \mprj_pads.analog_en[22] ;
  wire \mprj_pads.analog_en[23] ;
  wire \mprj_pads.analog_en[24] ;
  wire \mprj_pads.analog_en[25] ;
  wire \mprj_pads.analog_en[26] ;
  wire \mprj_pads.analog_en[27] ;
  wire \mprj_pads.analog_en[28] ;
  wire \mprj_pads.analog_en[29] ;
  wire \mprj_pads.analog_en[2] ;
  wire \mprj_pads.analog_en[30] ;
  wire \mprj_pads.analog_en[31] ;
  wire \mprj_pads.analog_en[32] ;
  wire \mprj_pads.analog_en[33] ;
  wire \mprj_pads.analog_en[34] ;
  wire \mprj_pads.analog_en[35] ;
  wire \mprj_pads.analog_en[36] ;
  wire \mprj_pads.analog_en[37] ;
  wire \mprj_pads.analog_en[3] ;
  wire \mprj_pads.analog_en[4] ;
  wire \mprj_pads.analog_en[5] ;
  wire \mprj_pads.analog_en[6] ;
  wire \mprj_pads.analog_en[7] ;
  wire \mprj_pads.analog_en[8] ;
  wire \mprj_pads.analog_en[9] ;
  wire \mprj_pads.analog_io[0] ;
  wire \mprj_pads.analog_io[10] ;
  wire \mprj_pads.analog_io[11] ;
  wire \mprj_pads.analog_io[12] ;
  wire \mprj_pads.analog_io[13] ;
  wire \mprj_pads.analog_io[14] ;
  wire \mprj_pads.analog_io[15] ;
  wire \mprj_pads.analog_io[16] ;
  wire \mprj_pads.analog_io[17] ;
  wire \mprj_pads.analog_io[18] ;
  wire \mprj_pads.analog_io[19] ;
  wire \mprj_pads.analog_io[1] ;
  wire \mprj_pads.analog_io[20] ;
  wire \mprj_pads.analog_io[21] ;
  wire \mprj_pads.analog_io[22] ;
  wire \mprj_pads.analog_io[23] ;
  wire \mprj_pads.analog_io[24] ;
  wire \mprj_pads.analog_io[25] ;
  wire \mprj_pads.analog_io[26] ;
  wire \mprj_pads.analog_io[27] ;
  wire \mprj_pads.analog_io[28] ;
  wire \mprj_pads.analog_io[29] ;
  wire \mprj_pads.analog_io[2] ;
  wire \mprj_pads.analog_io[30] ;
  wire \mprj_pads.analog_io[3] ;
  wire \mprj_pads.analog_io[4] ;
  wire \mprj_pads.analog_io[5] ;
  wire \mprj_pads.analog_io[6] ;
  wire \mprj_pads.analog_io[7] ;
  wire \mprj_pads.analog_io[8] ;
  wire \mprj_pads.analog_io[9] ;
  wire \mprj_pads.analog_pol[0] ;
  wire \mprj_pads.analog_pol[10] ;
  wire \mprj_pads.analog_pol[11] ;
  wire \mprj_pads.analog_pol[12] ;
  wire \mprj_pads.analog_pol[13] ;
  wire \mprj_pads.analog_pol[14] ;
  wire \mprj_pads.analog_pol[15] ;
  wire \mprj_pads.analog_pol[16] ;
  wire \mprj_pads.analog_pol[17] ;
  wire \mprj_pads.analog_pol[18] ;
  wire \mprj_pads.analog_pol[19] ;
  wire \mprj_pads.analog_pol[1] ;
  wire \mprj_pads.analog_pol[20] ;
  wire \mprj_pads.analog_pol[21] ;
  wire \mprj_pads.analog_pol[22] ;
  wire \mprj_pads.analog_pol[23] ;
  wire \mprj_pads.analog_pol[24] ;
  wire \mprj_pads.analog_pol[25] ;
  wire \mprj_pads.analog_pol[26] ;
  wire \mprj_pads.analog_pol[27] ;
  wire \mprj_pads.analog_pol[28] ;
  wire \mprj_pads.analog_pol[29] ;
  wire \mprj_pads.analog_pol[2] ;
  wire \mprj_pads.analog_pol[30] ;
  wire \mprj_pads.analog_pol[31] ;
  wire \mprj_pads.analog_pol[32] ;
  wire \mprj_pads.analog_pol[33] ;
  wire \mprj_pads.analog_pol[34] ;
  wire \mprj_pads.analog_pol[35] ;
  wire \mprj_pads.analog_pol[36] ;
  wire \mprj_pads.analog_pol[37] ;
  wire \mprj_pads.analog_pol[3] ;
  wire \mprj_pads.analog_pol[4] ;
  wire \mprj_pads.analog_pol[5] ;
  wire \mprj_pads.analog_pol[6] ;
  wire \mprj_pads.analog_pol[7] ;
  wire \mprj_pads.analog_pol[8] ;
  wire \mprj_pads.analog_pol[9] ;
  wire \mprj_pads.analog_sel[0] ;
  wire \mprj_pads.analog_sel[10] ;
  wire \mprj_pads.analog_sel[11] ;
  wire \mprj_pads.analog_sel[12] ;
  wire \mprj_pads.analog_sel[13] ;
  wire \mprj_pads.analog_sel[14] ;
  wire \mprj_pads.analog_sel[15] ;
  wire \mprj_pads.analog_sel[16] ;
  wire \mprj_pads.analog_sel[17] ;
  wire \mprj_pads.analog_sel[18] ;
  wire \mprj_pads.analog_sel[19] ;
  wire \mprj_pads.analog_sel[1] ;
  wire \mprj_pads.analog_sel[20] ;
  wire \mprj_pads.analog_sel[21] ;
  wire \mprj_pads.analog_sel[22] ;
  wire \mprj_pads.analog_sel[23] ;
  wire \mprj_pads.analog_sel[24] ;
  wire \mprj_pads.analog_sel[25] ;
  wire \mprj_pads.analog_sel[26] ;
  wire \mprj_pads.analog_sel[27] ;
  wire \mprj_pads.analog_sel[28] ;
  wire \mprj_pads.analog_sel[29] ;
  wire \mprj_pads.analog_sel[2] ;
  wire \mprj_pads.analog_sel[30] ;
  wire \mprj_pads.analog_sel[31] ;
  wire \mprj_pads.analog_sel[32] ;
  wire \mprj_pads.analog_sel[33] ;
  wire \mprj_pads.analog_sel[34] ;
  wire \mprj_pads.analog_sel[35] ;
  wire \mprj_pads.analog_sel[36] ;
  wire \mprj_pads.analog_sel[37] ;
  wire \mprj_pads.analog_sel[3] ;
  wire \mprj_pads.analog_sel[4] ;
  wire \mprj_pads.analog_sel[5] ;
  wire \mprj_pads.analog_sel[6] ;
  wire \mprj_pads.analog_sel[7] ;
  wire \mprj_pads.analog_sel[8] ;
  wire \mprj_pads.analog_sel[9] ;
  wire \mprj_pads.dm[0] ;
  wire \mprj_pads.dm[100] ;
  wire \mprj_pads.dm[101] ;
  wire \mprj_pads.dm[102] ;
  wire \mprj_pads.dm[103] ;
  wire \mprj_pads.dm[104] ;
  wire \mprj_pads.dm[105] ;
  wire \mprj_pads.dm[106] ;
  wire \mprj_pads.dm[107] ;
  wire \mprj_pads.dm[108] ;
  wire \mprj_pads.dm[109] ;
  wire \mprj_pads.dm[10] ;
  wire \mprj_pads.dm[110] ;
  wire \mprj_pads.dm[111] ;
  wire \mprj_pads.dm[112] ;
  wire \mprj_pads.dm[113] ;
  wire \mprj_pads.dm[11] ;
  wire \mprj_pads.dm[12] ;
  wire \mprj_pads.dm[13] ;
  wire \mprj_pads.dm[14] ;
  wire \mprj_pads.dm[15] ;
  wire \mprj_pads.dm[16] ;
  wire \mprj_pads.dm[17] ;
  wire \mprj_pads.dm[18] ;
  wire \mprj_pads.dm[19] ;
  wire \mprj_pads.dm[1] ;
  wire \mprj_pads.dm[20] ;
  wire \mprj_pads.dm[21] ;
  wire \mprj_pads.dm[22] ;
  wire \mprj_pads.dm[23] ;
  wire \mprj_pads.dm[24] ;
  wire \mprj_pads.dm[25] ;
  wire \mprj_pads.dm[26] ;
  wire \mprj_pads.dm[27] ;
  wire \mprj_pads.dm[28] ;
  wire \mprj_pads.dm[29] ;
  wire \mprj_pads.dm[2] ;
  wire \mprj_pads.dm[30] ;
  wire \mprj_pads.dm[31] ;
  wire \mprj_pads.dm[32] ;
  wire \mprj_pads.dm[33] ;
  wire \mprj_pads.dm[34] ;
  wire \mprj_pads.dm[35] ;
  wire \mprj_pads.dm[36] ;
  wire \mprj_pads.dm[37] ;
  wire \mprj_pads.dm[38] ;
  wire \mprj_pads.dm[39] ;
  wire \mprj_pads.dm[3] ;
  wire \mprj_pads.dm[40] ;
  wire \mprj_pads.dm[41] ;
  wire \mprj_pads.dm[42] ;
  wire \mprj_pads.dm[43] ;
  wire \mprj_pads.dm[44] ;
  wire \mprj_pads.dm[45] ;
  wire \mprj_pads.dm[46] ;
  wire \mprj_pads.dm[47] ;
  wire \mprj_pads.dm[48] ;
  wire \mprj_pads.dm[49] ;
  wire \mprj_pads.dm[4] ;
  wire \mprj_pads.dm[50] ;
  wire \mprj_pads.dm[51] ;
  wire \mprj_pads.dm[52] ;
  wire \mprj_pads.dm[53] ;
  wire \mprj_pads.dm[54] ;
  wire \mprj_pads.dm[55] ;
  wire \mprj_pads.dm[56] ;
  wire \mprj_pads.dm[57] ;
  wire \mprj_pads.dm[58] ;
  wire \mprj_pads.dm[59] ;
  wire \mprj_pads.dm[5] ;
  wire \mprj_pads.dm[60] ;
  wire \mprj_pads.dm[61] ;
  wire \mprj_pads.dm[62] ;
  wire \mprj_pads.dm[63] ;
  wire \mprj_pads.dm[64] ;
  wire \mprj_pads.dm[65] ;
  wire \mprj_pads.dm[66] ;
  wire \mprj_pads.dm[67] ;
  wire \mprj_pads.dm[68] ;
  wire \mprj_pads.dm[69] ;
  wire \mprj_pads.dm[6] ;
  wire \mprj_pads.dm[70] ;
  wire \mprj_pads.dm[71] ;
  wire \mprj_pads.dm[72] ;
  wire \mprj_pads.dm[73] ;
  wire \mprj_pads.dm[74] ;
  wire \mprj_pads.dm[75] ;
  wire \mprj_pads.dm[76] ;
  wire \mprj_pads.dm[77] ;
  wire \mprj_pads.dm[78] ;
  wire \mprj_pads.dm[79] ;
  wire \mprj_pads.dm[7] ;
  wire \mprj_pads.dm[80] ;
  wire \mprj_pads.dm[81] ;
  wire \mprj_pads.dm[82] ;
  wire \mprj_pads.dm[83] ;
  wire \mprj_pads.dm[84] ;
  wire \mprj_pads.dm[85] ;
  wire \mprj_pads.dm[86] ;
  wire \mprj_pads.dm[87] ;
  wire \mprj_pads.dm[88] ;
  wire \mprj_pads.dm[89] ;
  wire \mprj_pads.dm[8] ;
  wire \mprj_pads.dm[90] ;
  wire \mprj_pads.dm[91] ;
  wire \mprj_pads.dm[92] ;
  wire \mprj_pads.dm[93] ;
  wire \mprj_pads.dm[94] ;
  wire \mprj_pads.dm[95] ;
  wire \mprj_pads.dm[96] ;
  wire \mprj_pads.dm[97] ;
  wire \mprj_pads.dm[98] ;
  wire \mprj_pads.dm[99] ;
  wire \mprj_pads.dm[9] ;
  wire \mprj_pads.enh[0] ;
  wire \mprj_pads.enh[10] ;
  wire \mprj_pads.enh[11] ;
  wire \mprj_pads.enh[12] ;
  wire \mprj_pads.enh[13] ;
  wire \mprj_pads.enh[14] ;
  wire \mprj_pads.enh[15] ;
  wire \mprj_pads.enh[16] ;
  wire \mprj_pads.enh[17] ;
  wire \mprj_pads.enh[18] ;
  wire \mprj_pads.enh[19] ;
  wire \mprj_pads.enh[1] ;
  wire \mprj_pads.enh[20] ;
  wire \mprj_pads.enh[21] ;
  wire \mprj_pads.enh[22] ;
  wire \mprj_pads.enh[23] ;
  wire \mprj_pads.enh[24] ;
  wire \mprj_pads.enh[25] ;
  wire \mprj_pads.enh[26] ;
  wire \mprj_pads.enh[27] ;
  wire \mprj_pads.enh[28] ;
  wire \mprj_pads.enh[29] ;
  wire \mprj_pads.enh[2] ;
  wire \mprj_pads.enh[30] ;
  wire \mprj_pads.enh[31] ;
  wire \mprj_pads.enh[32] ;
  wire \mprj_pads.enh[33] ;
  wire \mprj_pads.enh[34] ;
  wire \mprj_pads.enh[35] ;
  wire \mprj_pads.enh[36] ;
  wire \mprj_pads.enh[37] ;
  wire \mprj_pads.enh[3] ;
  wire \mprj_pads.enh[4] ;
  wire \mprj_pads.enh[5] ;
  wire \mprj_pads.enh[6] ;
  wire \mprj_pads.enh[7] ;
  wire \mprj_pads.enh[8] ;
  wire \mprj_pads.enh[9] ;
  wire \mprj_pads.hldh_n[0] ;
  wire \mprj_pads.hldh_n[10] ;
  wire \mprj_pads.hldh_n[11] ;
  wire \mprj_pads.hldh_n[12] ;
  wire \mprj_pads.hldh_n[13] ;
  wire \mprj_pads.hldh_n[14] ;
  wire \mprj_pads.hldh_n[15] ;
  wire \mprj_pads.hldh_n[16] ;
  wire \mprj_pads.hldh_n[17] ;
  wire \mprj_pads.hldh_n[18] ;
  wire \mprj_pads.hldh_n[19] ;
  wire \mprj_pads.hldh_n[1] ;
  wire \mprj_pads.hldh_n[20] ;
  wire \mprj_pads.hldh_n[21] ;
  wire \mprj_pads.hldh_n[22] ;
  wire \mprj_pads.hldh_n[23] ;
  wire \mprj_pads.hldh_n[24] ;
  wire \mprj_pads.hldh_n[25] ;
  wire \mprj_pads.hldh_n[26] ;
  wire \mprj_pads.hldh_n[27] ;
  wire \mprj_pads.hldh_n[28] ;
  wire \mprj_pads.hldh_n[29] ;
  wire \mprj_pads.hldh_n[2] ;
  wire \mprj_pads.hldh_n[30] ;
  wire \mprj_pads.hldh_n[31] ;
  wire \mprj_pads.hldh_n[32] ;
  wire \mprj_pads.hldh_n[33] ;
  wire \mprj_pads.hldh_n[34] ;
  wire \mprj_pads.hldh_n[35] ;
  wire \mprj_pads.hldh_n[36] ;
  wire \mprj_pads.hldh_n[37] ;
  wire \mprj_pads.hldh_n[3] ;
  wire \mprj_pads.hldh_n[4] ;
  wire \mprj_pads.hldh_n[5] ;
  wire \mprj_pads.hldh_n[6] ;
  wire \mprj_pads.hldh_n[7] ;
  wire \mprj_pads.hldh_n[8] ;
  wire \mprj_pads.hldh_n[9] ;
  wire \mprj_pads.holdover[0] ;
  wire \mprj_pads.holdover[10] ;
  wire \mprj_pads.holdover[11] ;
  wire \mprj_pads.holdover[12] ;
  wire \mprj_pads.holdover[13] ;
  wire \mprj_pads.holdover[14] ;
  wire \mprj_pads.holdover[15] ;
  wire \mprj_pads.holdover[16] ;
  wire \mprj_pads.holdover[17] ;
  wire \mprj_pads.holdover[18] ;
  wire \mprj_pads.holdover[19] ;
  wire \mprj_pads.holdover[1] ;
  wire \mprj_pads.holdover[20] ;
  wire \mprj_pads.holdover[21] ;
  wire \mprj_pads.holdover[22] ;
  wire \mprj_pads.holdover[23] ;
  wire \mprj_pads.holdover[24] ;
  wire \mprj_pads.holdover[25] ;
  wire \mprj_pads.holdover[26] ;
  wire \mprj_pads.holdover[27] ;
  wire \mprj_pads.holdover[28] ;
  wire \mprj_pads.holdover[29] ;
  wire \mprj_pads.holdover[2] ;
  wire \mprj_pads.holdover[30] ;
  wire \mprj_pads.holdover[31] ;
  wire \mprj_pads.holdover[32] ;
  wire \mprj_pads.holdover[33] ;
  wire \mprj_pads.holdover[34] ;
  wire \mprj_pads.holdover[35] ;
  wire \mprj_pads.holdover[36] ;
  wire \mprj_pads.holdover[37] ;
  wire \mprj_pads.holdover[3] ;
  wire \mprj_pads.holdover[4] ;
  wire \mprj_pads.holdover[5] ;
  wire \mprj_pads.holdover[6] ;
  wire \mprj_pads.holdover[7] ;
  wire \mprj_pads.holdover[8] ;
  wire \mprj_pads.holdover[9] ;
  wire \mprj_pads.ib_mode_sel[0] ;
  wire \mprj_pads.ib_mode_sel[10] ;
  wire \mprj_pads.ib_mode_sel[11] ;
  wire \mprj_pads.ib_mode_sel[12] ;
  wire \mprj_pads.ib_mode_sel[13] ;
  wire \mprj_pads.ib_mode_sel[14] ;
  wire \mprj_pads.ib_mode_sel[15] ;
  wire \mprj_pads.ib_mode_sel[16] ;
  wire \mprj_pads.ib_mode_sel[17] ;
  wire \mprj_pads.ib_mode_sel[18] ;
  wire \mprj_pads.ib_mode_sel[19] ;
  wire \mprj_pads.ib_mode_sel[1] ;
  wire \mprj_pads.ib_mode_sel[20] ;
  wire \mprj_pads.ib_mode_sel[21] ;
  wire \mprj_pads.ib_mode_sel[22] ;
  wire \mprj_pads.ib_mode_sel[23] ;
  wire \mprj_pads.ib_mode_sel[24] ;
  wire \mprj_pads.ib_mode_sel[25] ;
  wire \mprj_pads.ib_mode_sel[26] ;
  wire \mprj_pads.ib_mode_sel[27] ;
  wire \mprj_pads.ib_mode_sel[28] ;
  wire \mprj_pads.ib_mode_sel[29] ;
  wire \mprj_pads.ib_mode_sel[2] ;
  wire \mprj_pads.ib_mode_sel[30] ;
  wire \mprj_pads.ib_mode_sel[31] ;
  wire \mprj_pads.ib_mode_sel[32] ;
  wire \mprj_pads.ib_mode_sel[33] ;
  wire \mprj_pads.ib_mode_sel[34] ;
  wire \mprj_pads.ib_mode_sel[35] ;
  wire \mprj_pads.ib_mode_sel[36] ;
  wire \mprj_pads.ib_mode_sel[37] ;
  wire \mprj_pads.ib_mode_sel[3] ;
  wire \mprj_pads.ib_mode_sel[4] ;
  wire \mprj_pads.ib_mode_sel[5] ;
  wire \mprj_pads.ib_mode_sel[6] ;
  wire \mprj_pads.ib_mode_sel[7] ;
  wire \mprj_pads.ib_mode_sel[8] ;
  wire \mprj_pads.ib_mode_sel[9] ;
  wire \mprj_pads.inp_dis[0] ;
  wire \mprj_pads.inp_dis[10] ;
  wire \mprj_pads.inp_dis[11] ;
  wire \mprj_pads.inp_dis[12] ;
  wire \mprj_pads.inp_dis[13] ;
  wire \mprj_pads.inp_dis[14] ;
  wire \mprj_pads.inp_dis[15] ;
  wire \mprj_pads.inp_dis[16] ;
  wire \mprj_pads.inp_dis[17] ;
  wire \mprj_pads.inp_dis[18] ;
  wire \mprj_pads.inp_dis[19] ;
  wire \mprj_pads.inp_dis[1] ;
  wire \mprj_pads.inp_dis[20] ;
  wire \mprj_pads.inp_dis[21] ;
  wire \mprj_pads.inp_dis[22] ;
  wire \mprj_pads.inp_dis[23] ;
  wire \mprj_pads.inp_dis[24] ;
  wire \mprj_pads.inp_dis[25] ;
  wire \mprj_pads.inp_dis[26] ;
  wire \mprj_pads.inp_dis[27] ;
  wire \mprj_pads.inp_dis[28] ;
  wire \mprj_pads.inp_dis[29] ;
  wire \mprj_pads.inp_dis[2] ;
  wire \mprj_pads.inp_dis[30] ;
  wire \mprj_pads.inp_dis[31] ;
  wire \mprj_pads.inp_dis[32] ;
  wire \mprj_pads.inp_dis[33] ;
  wire \mprj_pads.inp_dis[34] ;
  wire \mprj_pads.inp_dis[35] ;
  wire \mprj_pads.inp_dis[36] ;
  wire \mprj_pads.inp_dis[37] ;
  wire \mprj_pads.inp_dis[3] ;
  wire \mprj_pads.inp_dis[4] ;
  wire \mprj_pads.inp_dis[5] ;
  wire \mprj_pads.inp_dis[6] ;
  wire \mprj_pads.inp_dis[7] ;
  wire \mprj_pads.inp_dis[8] ;
  wire \mprj_pads.inp_dis[9] ;
  wire \mprj_pads.io[0] ;
  wire \mprj_pads.io[10] ;
  wire \mprj_pads.io[11] ;
  wire \mprj_pads.io[12] ;
  wire \mprj_pads.io[13] ;
  wire \mprj_pads.io[14] ;
  wire \mprj_pads.io[15] ;
  wire \mprj_pads.io[16] ;
  wire \mprj_pads.io[17] ;
  wire \mprj_pads.io[18] ;
  wire \mprj_pads.io[19] ;
  wire \mprj_pads.io[1] ;
  wire \mprj_pads.io[20] ;
  wire \mprj_pads.io[21] ;
  wire \mprj_pads.io[22] ;
  wire \mprj_pads.io[23] ;
  wire \mprj_pads.io[24] ;
  wire \mprj_pads.io[25] ;
  wire \mprj_pads.io[26] ;
  wire \mprj_pads.io[27] ;
  wire \mprj_pads.io[28] ;
  wire \mprj_pads.io[29] ;
  wire \mprj_pads.io[2] ;
  wire \mprj_pads.io[30] ;
  wire \mprj_pads.io[31] ;
  wire \mprj_pads.io[32] ;
  wire \mprj_pads.io[33] ;
  wire \mprj_pads.io[34] ;
  wire \mprj_pads.io[35] ;
  wire \mprj_pads.io[36] ;
  wire \mprj_pads.io[37] ;
  wire \mprj_pads.io[3] ;
  wire \mprj_pads.io[4] ;
  wire \mprj_pads.io[5] ;
  wire \mprj_pads.io[6] ;
  wire \mprj_pads.io[7] ;
  wire \mprj_pads.io[8] ;
  wire \mprj_pads.io[9] ;
  wire \mprj_pads.io_in[0] ;
  wire \mprj_pads.io_in[10] ;
  wire \mprj_pads.io_in[11] ;
  wire \mprj_pads.io_in[12] ;
  wire \mprj_pads.io_in[13] ;
  wire \mprj_pads.io_in[14] ;
  wire \mprj_pads.io_in[15] ;
  wire \mprj_pads.io_in[16] ;
  wire \mprj_pads.io_in[17] ;
  wire \mprj_pads.io_in[18] ;
  wire \mprj_pads.io_in[19] ;
  wire \mprj_pads.io_in[1] ;
  wire \mprj_pads.io_in[20] ;
  wire \mprj_pads.io_in[21] ;
  wire \mprj_pads.io_in[22] ;
  wire \mprj_pads.io_in[23] ;
  wire \mprj_pads.io_in[24] ;
  wire \mprj_pads.io_in[25] ;
  wire \mprj_pads.io_in[26] ;
  wire \mprj_pads.io_in[27] ;
  wire \mprj_pads.io_in[28] ;
  wire \mprj_pads.io_in[29] ;
  wire \mprj_pads.io_in[2] ;
  wire \mprj_pads.io_in[30] ;
  wire \mprj_pads.io_in[31] ;
  wire \mprj_pads.io_in[32] ;
  wire \mprj_pads.io_in[33] ;
  wire \mprj_pads.io_in[34] ;
  wire \mprj_pads.io_in[35] ;
  wire \mprj_pads.io_in[36] ;
  wire \mprj_pads.io_in[37] ;
  wire \mprj_pads.io_in[3] ;
  wire \mprj_pads.io_in[4] ;
  wire \mprj_pads.io_in[5] ;
  wire \mprj_pads.io_in[6] ;
  wire \mprj_pads.io_in[7] ;
  wire \mprj_pads.io_in[8] ;
  wire \mprj_pads.io_in[9] ;
  wire \mprj_pads.io_out[0] ;
  wire \mprj_pads.io_out[10] ;
  wire \mprj_pads.io_out[11] ;
  wire \mprj_pads.io_out[12] ;
  wire \mprj_pads.io_out[13] ;
  wire \mprj_pads.io_out[14] ;
  wire \mprj_pads.io_out[15] ;
  wire \mprj_pads.io_out[16] ;
  wire \mprj_pads.io_out[17] ;
  wire \mprj_pads.io_out[18] ;
  wire \mprj_pads.io_out[19] ;
  wire \mprj_pads.io_out[1] ;
  wire \mprj_pads.io_out[20] ;
  wire \mprj_pads.io_out[21] ;
  wire \mprj_pads.io_out[22] ;
  wire \mprj_pads.io_out[23] ;
  wire \mprj_pads.io_out[24] ;
  wire \mprj_pads.io_out[25] ;
  wire \mprj_pads.io_out[26] ;
  wire \mprj_pads.io_out[27] ;
  wire \mprj_pads.io_out[28] ;
  wire \mprj_pads.io_out[29] ;
  wire \mprj_pads.io_out[2] ;
  wire \mprj_pads.io_out[30] ;
  wire \mprj_pads.io_out[31] ;
  wire \mprj_pads.io_out[32] ;
  wire \mprj_pads.io_out[33] ;
  wire \mprj_pads.io_out[34] ;
  wire \mprj_pads.io_out[35] ;
  wire \mprj_pads.io_out[36] ;
  wire \mprj_pads.io_out[37] ;
  wire \mprj_pads.io_out[3] ;
  wire \mprj_pads.io_out[4] ;
  wire \mprj_pads.io_out[5] ;
  wire \mprj_pads.io_out[6] ;
  wire \mprj_pads.io_out[7] ;
  wire \mprj_pads.io_out[8] ;
  wire \mprj_pads.io_out[9] ;
  wire \mprj_pads.loop1_io[0] ;
  wire \mprj_pads.loop1_io[10] ;
  wire \mprj_pads.loop1_io[11] ;
  wire \mprj_pads.loop1_io[12] ;
  wire \mprj_pads.loop1_io[13] ;
  wire \mprj_pads.loop1_io[14] ;
  wire \mprj_pads.loop1_io[15] ;
  wire \mprj_pads.loop1_io[16] ;
  wire \mprj_pads.loop1_io[17] ;
  wire \mprj_pads.loop1_io[18] ;
  wire \mprj_pads.loop1_io[19] ;
  wire \mprj_pads.loop1_io[1] ;
  wire \mprj_pads.loop1_io[20] ;
  wire \mprj_pads.loop1_io[21] ;
  wire \mprj_pads.loop1_io[22] ;
  wire \mprj_pads.loop1_io[23] ;
  wire \mprj_pads.loop1_io[24] ;
  wire \mprj_pads.loop1_io[25] ;
  wire \mprj_pads.loop1_io[26] ;
  wire \mprj_pads.loop1_io[27] ;
  wire \mprj_pads.loop1_io[28] ;
  wire \mprj_pads.loop1_io[29] ;
  wire \mprj_pads.loop1_io[2] ;
  wire \mprj_pads.loop1_io[30] ;
  wire \mprj_pads.loop1_io[31] ;
  wire \mprj_pads.loop1_io[32] ;
  wire \mprj_pads.loop1_io[33] ;
  wire \mprj_pads.loop1_io[34] ;
  wire \mprj_pads.loop1_io[35] ;
  wire \mprj_pads.loop1_io[36] ;
  wire \mprj_pads.loop1_io[37] ;
  wire \mprj_pads.loop1_io[3] ;
  wire \mprj_pads.loop1_io[4] ;
  wire \mprj_pads.loop1_io[5] ;
  wire \mprj_pads.loop1_io[6] ;
  wire \mprj_pads.loop1_io[7] ;
  wire \mprj_pads.loop1_io[8] ;
  wire \mprj_pads.loop1_io[9] ;
  wire \mprj_pads.no_connect[0] ;
  wire \mprj_pads.no_connect[1] ;
  wire \mprj_pads.no_connect[2] ;
  wire \mprj_pads.no_connect[3] ;
  wire \mprj_pads.no_connect[4] ;
  wire \mprj_pads.no_connect[5] ;
  wire \mprj_pads.no_connect[6] ;
  wire \mprj_pads.oeb[0] ;
  wire \mprj_pads.oeb[10] ;
  wire \mprj_pads.oeb[11] ;
  wire \mprj_pads.oeb[12] ;
  wire \mprj_pads.oeb[13] ;
  wire \mprj_pads.oeb[14] ;
  wire \mprj_pads.oeb[15] ;
  wire \mprj_pads.oeb[16] ;
  wire \mprj_pads.oeb[17] ;
  wire \mprj_pads.oeb[18] ;
  wire \mprj_pads.oeb[19] ;
  wire \mprj_pads.oeb[1] ;
  wire \mprj_pads.oeb[20] ;
  wire \mprj_pads.oeb[21] ;
  wire \mprj_pads.oeb[22] ;
  wire \mprj_pads.oeb[23] ;
  wire \mprj_pads.oeb[24] ;
  wire \mprj_pads.oeb[25] ;
  wire \mprj_pads.oeb[26] ;
  wire \mprj_pads.oeb[27] ;
  wire \mprj_pads.oeb[28] ;
  wire \mprj_pads.oeb[29] ;
  wire \mprj_pads.oeb[2] ;
  wire \mprj_pads.oeb[30] ;
  wire \mprj_pads.oeb[31] ;
  wire \mprj_pads.oeb[32] ;
  wire \mprj_pads.oeb[33] ;
  wire \mprj_pads.oeb[34] ;
  wire \mprj_pads.oeb[35] ;
  wire \mprj_pads.oeb[36] ;
  wire \mprj_pads.oeb[37] ;
  wire \mprj_pads.oeb[3] ;
  wire \mprj_pads.oeb[4] ;
  wire \mprj_pads.oeb[5] ;
  wire \mprj_pads.oeb[6] ;
  wire \mprj_pads.oeb[7] ;
  wire \mprj_pads.oeb[8] ;
  wire \mprj_pads.oeb[9] ;
  wire \mprj_pads.porb_h ;
  wire \mprj_pads.slow_sel[0] ;
  wire \mprj_pads.slow_sel[10] ;
  wire \mprj_pads.slow_sel[11] ;
  wire \mprj_pads.slow_sel[12] ;
  wire \mprj_pads.slow_sel[13] ;
  wire \mprj_pads.slow_sel[14] ;
  wire \mprj_pads.slow_sel[15] ;
  wire \mprj_pads.slow_sel[16] ;
  wire \mprj_pads.slow_sel[17] ;
  wire \mprj_pads.slow_sel[18] ;
  wire \mprj_pads.slow_sel[19] ;
  wire \mprj_pads.slow_sel[1] ;
  wire \mprj_pads.slow_sel[20] ;
  wire \mprj_pads.slow_sel[21] ;
  wire \mprj_pads.slow_sel[22] ;
  wire \mprj_pads.slow_sel[23] ;
  wire \mprj_pads.slow_sel[24] ;
  wire \mprj_pads.slow_sel[25] ;
  wire \mprj_pads.slow_sel[26] ;
  wire \mprj_pads.slow_sel[27] ;
  wire \mprj_pads.slow_sel[28] ;
  wire \mprj_pads.slow_sel[29] ;
  wire \mprj_pads.slow_sel[2] ;
  wire \mprj_pads.slow_sel[30] ;
  wire \mprj_pads.slow_sel[31] ;
  wire \mprj_pads.slow_sel[32] ;
  wire \mprj_pads.slow_sel[33] ;
  wire \mprj_pads.slow_sel[34] ;
  wire \mprj_pads.slow_sel[35] ;
  wire \mprj_pads.slow_sel[36] ;
  wire \mprj_pads.slow_sel[37] ;
  wire \mprj_pads.slow_sel[3] ;
  wire \mprj_pads.slow_sel[4] ;
  wire \mprj_pads.slow_sel[5] ;
  wire \mprj_pads.slow_sel[6] ;
  wire \mprj_pads.slow_sel[7] ;
  wire \mprj_pads.slow_sel[8] ;
  wire \mprj_pads.slow_sel[9] ;
  wire \mprj_pads.vccd ;
  wire \mprj_pads.vccd1 ;
  wire \mprj_pads.vccd2 ;
  wire \mprj_pads.vdda ;
  wire \mprj_pads.vdda1 ;
  wire \mprj_pads.vdda2 ;
  wire \mprj_pads.vddio ;
  wire \mprj_pads.vddio_q ;
  wire \mprj_pads.vssa ;
  wire \mprj_pads.vssa1 ;
  wire \mprj_pads.vssa2 ;
  wire \mprj_pads.vssd ;
  wire \mprj_pads.vssd1 ;
  wire \mprj_pads.vssd2 ;
  wire \mprj_pads.vssio ;
  wire \mprj_pads.vssio_q ;
  wire \mprj_pads.vtrip_sel[0] ;
  wire \mprj_pads.vtrip_sel[10] ;
  wire \mprj_pads.vtrip_sel[11] ;
  wire \mprj_pads.vtrip_sel[12] ;
  wire \mprj_pads.vtrip_sel[13] ;
  wire \mprj_pads.vtrip_sel[14] ;
  wire \mprj_pads.vtrip_sel[15] ;
  wire \mprj_pads.vtrip_sel[16] ;
  wire \mprj_pads.vtrip_sel[17] ;
  wire \mprj_pads.vtrip_sel[18] ;
  wire \mprj_pads.vtrip_sel[19] ;
  wire \mprj_pads.vtrip_sel[1] ;
  wire \mprj_pads.vtrip_sel[20] ;
  wire \mprj_pads.vtrip_sel[21] ;
  wire \mprj_pads.vtrip_sel[22] ;
  wire \mprj_pads.vtrip_sel[23] ;
  wire \mprj_pads.vtrip_sel[24] ;
  wire \mprj_pads.vtrip_sel[25] ;
  wire \mprj_pads.vtrip_sel[26] ;
  wire \mprj_pads.vtrip_sel[27] ;
  wire \mprj_pads.vtrip_sel[28] ;
  wire \mprj_pads.vtrip_sel[29] ;
  wire \mprj_pads.vtrip_sel[2] ;
  wire \mprj_pads.vtrip_sel[30] ;
  wire \mprj_pads.vtrip_sel[31] ;
  wire \mprj_pads.vtrip_sel[32] ;
  wire \mprj_pads.vtrip_sel[33] ;
  wire \mprj_pads.vtrip_sel[34] ;
  wire \mprj_pads.vtrip_sel[35] ;
  wire \mprj_pads.vtrip_sel[36] ;
  wire \mprj_pads.vtrip_sel[37] ;
  wire \mprj_pads.vtrip_sel[3] ;
  wire \mprj_pads.vtrip_sel[4] ;
  wire \mprj_pads.vtrip_sel[5] ;
  wire \mprj_pads.vtrip_sel[6] ;
  wire \mprj_pads.vtrip_sel[7] ;
  wire \mprj_pads.vtrip_sel[8] ;
  wire \mprj_pads.vtrip_sel[9] ;




	// Instantiate power and ground pads for management domain
	// 12 pads:  vddio, vssio, vdda, vssa, vccd, vssd
	// One each HV and LV clamp.

	// HV clamps connect between one HV power rail and one ground
	// LV clamps have two clamps connecting between any two LV power
	// rails and grounds, and one back-to-back diode which connects
	// between the first LV clamp ground and any other ground.
	assign vddio = vddio_pad;
	assign vddio = vddio_pad2;
	assign vdda = vdda_pad;
	assign vccd = vccd_pad;
	assign vssio = vssio_pad;
	assign vssa = vssa_pad;
	assign vssd = vssd_pad;
	assign vdda1 = vdda1_pad;
	assign vccd1 = vccd1_pad;
	assign vdda2 = vdda2_pad;
	assign vccd2 = vccd2_pad;
	assign vssa2 = vssa2_pad;
	assign vssd2 = vssd2_pad; 
/*	
    	sky130_ef_io__vddio_hvc_clamped_pad \mgmt_vddio_hvclamp_pad[0]  (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDIO_PAD(vddio_pad)
`endif
    	);

	// lies in user area 2
    	sky130_ef_io__vddio_hvc_clamped_pad \mgmt_vddio_hvclamp_pad[1]  (
		`USER2_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDIO_PAD(vddio_pad2)
`endif
    	);

    	sky130_ef_io__vdda_hvc_clamped_pad mgmt_vdda_hvclamp_pad (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDA_PAD(vdda_pad)
`endif
    	);
*/
    /*	pvdi mgmt_vccd_lvclamp_pad (
		.VDD(vccd_pad)
    	);*/
 
  /*     sky130_ef_io__vccd_lvc_clamped_pad mgmt_vccd_lvclamp_pad (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VCCD_PAD(vccd_pad)
`endif
    	);

    	sky130_ef_io__vssio_hvc_clamped_pad \mgmt_vssio_hvclamp_pad[0]  (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSIO_PAD(vssio_pad)
`endif
    	);

    	sky130_ef_io__vssio_hvc_clamped_pad \mgmt_vssio_hvclamp_pad[1]  (
		`USER2_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSIO_PAD(vssio_pad2)
`endif
    	);

    	sky130_ef_io__vssa_hvc_clamped_pad mgmt_vssa_hvclamp_pad (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSA_PAD(vssa_pad)
`endif
    	);

    	sky130_ef_io__vssd_lvc_clamped_pad mgmt_vssd_lvclamp_pad (
		`MGMT_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSD_PAD(vssd_pad)
`endif
    	);

	// Instantiate power and ground pads for user 1 domain
	// 8 pads:  vdda, vssa, vccd, vssd;  One each HV and LV clamp.

    	sky130_ef_io__vdda_hvc_clamped_pad \user1_vdda_hvclamp_pad[0] (
		`USER1_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDA_PAD(vdda1_pad)
`endif
    	);

		sky130_ef_io__vdda_hvc_clamped_pad \user1_vdda_hvclamp_pad[1] (
		`USER1_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDA_PAD(vdda1_pad2)
`endif 
    	); 
*/
    	/*pvdi user1_vccd_lvclamp_pad (
		.VDD(vccd1_pad)
    	);*/
  /*         	sky130_ef_io__vccd_lvc_clamped3_pad user1_vccd_lvclamp_pad (
		`USER1_ABUTMENT_PINS
		.VCCD1(vccd1),
		.VSSD1(vssd1),
`ifndef TOP_ROUTING
		.VCCD_PAD(vccd1_pad)
`endif
    	);

    	sky130_ef_io__vssa_hvc_clamped_pad \user1_vssa_hvclamp_pad[0] (
		`USER1_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSA_PAD(vssa1_pad)
`endif
    	);


    	sky130_ef_io__vssa_hvc_clamped_pad \user1_vssa_hvclamp_pad[1] (
		`USER1_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSA_PAD(vssa1_pad2)
`endif
    	);

    	sky130_ef_io__vssd_lvc_clamped3_pad user1_vssd_lvclamp_pad (
		`USER1_ABUTMENT_PINS
		.VCCD1(vccd1),
		.VSSD1(vssd1),
`ifndef TOP_ROUTING
		.VSSD_PAD(vssd1_pad)
`endif
    	);

	// Instantiate power and ground pads for user 2 domain
	// 8 pads:  vdda, vssa, vccd, vssd;  One each HV and LV clamp.

    	sky130_ef_io__vdda_hvc_clamped_pad user2_vdda_hvclamp_pad (
		`USER2_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VDDA_PAD(vdda2_pad)
`endif
    	); 
*/
    	/* pvdi user2_vccd_lvclamp_pad (
		.VDD(vccd2_pad)
    	);*/
  /*     
    	sky130_ef_io__vccd_lvc_clamped3_pad user2_vccd_lvclamp_pad (
		`USER2_ABUTMENT_PINS
		.VCCD1(vccd2),
		.VSSD1(vssd2),
`ifndef TOP_ROUTING
		.VCCD_PAD(vccd2_pad)
`endif
    	);


    	sky130_ef_io__vssa_hvc_clamped_pad user2_vssa_hvclamp_pad (
		`USER2_ABUTMENT_PINS
`ifndef TOP_ROUTING
		.VSSA_PAD(vssa2_pad)
`endif
    	);

    	sky130_ef_io__vssd_lvc_clamped3_pad user2_vssd_lvclamp_pad (
		`USER2_ABUTMENT_PINS
		.VCCD1(vccd2),
		.VSSD1(vssd2),
`ifndef TOP_ROUTING
		.VSSD_PAD(vssd2_pad)
`endif
    	);
*/
	wire [2:0] dm_all =
    		{gpio_mode1_core, gpio_mode1_core, gpio_mode0_core};
	wire[2:0] flash_io0_mode =
		{flash_io0_ieb_core, flash_io0_ieb_core, flash_io0_oeb_core};
	wire[2:0] flash_io1_mode =
		{flash_io1_ieb_core, flash_io1_ieb_core, flash_io1_oeb_core};

    wire [6:0] vccd_const_one;	// Constant value for management pins
    wire [6:0] vssd_const_zero;	// Constant value for management pins

    constant_block constant_value_inst [6:0] (
	.vccd(vccd),
	.vssd(vssd),
	.one(vccd_const_one),
	.zero(vssd_const_zero)
    );

	// Management clock input pad
	//`INPUT_PAD(clock, clock_core, vccd_const_one[0], vssd_const_zero[0]);
	//`INPUT_PAD_SCL(clock, clock_core);
        pc3d01_wrapper clock_pad(.IN(clock_core), .PAD(clock) );

    // Management GPIO pad
	//`INOUT_PAD(gpio, gpio_in_core, vccd_const_one[1], vssd_const_zero[1], gpio_out_core, gpio_inenb_core, gpio_outenb_core, dm_all);
	//`INOUT_PAD_SCL(gpio, gpio_in_core, gpio_out_core, gpio_inenb_core, gpio_outenb_core);
	//INOUT_PAD_SCL
	//wire dummy;
        //nand signal_gating (dummy, gpio_inenb_core, gpio_out_core)
       
         
         pc3b03ed_wrapper gpio_pad( .IN(gpio_in_core), .OUT(gpio_out_core), .PAD(gpio), .INPUT_DIS(gpio_inenb_core), .OUT_EN_N(gpio_outenb_core), .dm(dm_all));

	// Management Flash SPI pads
	//`INOUT_PAD(flash_io0, flash_io0_di_core, vccd_const_one[2], vssd_const_zero[2], flash_io0_do_core, flash_io0_ieb_core, flash_io0_oeb_core, flash_io0_mode);

        pc3b03ed_wrapper flash_io0_pad( .OUT(flash_io0_do_core), .PAD(flash_io0), .IN(flash_io0_di_core), .INPUT_DIS(flash_io0_ieb_core), .OUT_EN_N(flash_io0_oeb_core),.dm(flash_io0_mode));
		
	//`INOUT_PAD(flash_io1, flash_io1_di_core, vccd_const_one[3], vssd_const_zero[3], flash_io1_do_core, flash_io1_ieb_core, flash_io1_oeb_core, flash_io1_mode);

        pc3b03ed_wrapper flash_io1_pad( .OUT(flash_io1_do_core), .PAD(flash_io1), .IN(flash_io1_di_core), .INPUT_DIS(flash_io1_ieb_core), .OUT_EN_N(flash_io1_oeb_core),.dm(flash_io1_mode));

        /*`INOUT_PAD_SCL(flash_io0_do_core, flash_io0, flash_io0_di_core, flash_io0_ieb_core, flash_io0_oeb_core, flash_io0_mode);
        `INOUT_PAD_SCL(flash_io1_do_core ,flash_io1, flash_io1_di_core, flash_io1_ieb_core, flash_io1_oeb_core, flash_io1_mode);
        `INOUT_PAD_SCL(gpio_out_core, gpio, gpio_in_core, gpio_inenb_core, gpio_outenb_core, dm_all); */
 
	//`OUTPUT_NO_INP_DIS_PAD(flash_csb, flash_csb_core, vccd_const_one[4], vssd_const_zero[4], flash_csb_oeb_core);
	//`OUTPUT_NO_INP_DIS_PAD(flash_clk, flash_clk_core, vccd_const_one[5], vssd_const_zero[5], flash_clk_oeb_core);

	//`OUTPUT_NO_INP_DIS_SCL(flash_csb, flash_csb_core, flash_csb_oeb_core);
         pt3b02_wrapper flash_csb_pad(.PAD(flash_csb), .IN(flash_csb_core), .OE_N(flash_csb_oeb_core));	
         pt3b02_wrapper flash_clk_pad(.PAD(flash_clk), .IN(flash_clk_core), .OE_N(flash_clk_oeb_core));	
        //`OUTPUT_NO_INP_DIS_SCL(flash_clk, flash_clk_core, flash_clk_oeb_core);

	// NOTE:  The analog_out pad from the raven chip has been replaced by
    	// the digital reset input resetb on caravel due to the lack of an on-board
    	// power-on-reset circuit.  The XRES pad is used for providing a glitch-
    	// free reset.

	/*wire xresloop;
	wire xres_vss_loop;
	sky130_fd_io__top_xres4v2 resetb_pad (
		`MGMT_ABUTMENT_PINS
		`ifndef	TOP_ROUTING
		    .PAD(resetb),
		`endif
		.TIE_WEAK_HI_H(xresloop),   // Loop-back connection to pad through pad_a_esd_h
		.TIE_HI_ESD(),
		.TIE_LO_ESD(xres_vss_loop),
		.PAD_A_ESD_H(xresloop),
		.XRES_H_N(resetb_core_h),
		.DISABLE_PULLUP_H(xres_vss_loop), // 0 = enable pull-up on reset pad
		.ENABLE_H(porb_h),	 	  // Power-on-reset
   		.EN_VDDIO_SIG_H(xres_vss_loop),	  // No idea.
   		.INP_SEL_H(xres_vss_loop),	  // 1 = use filt_in_h else filter the pad input
   		.FILT_IN_H(xres_vss_loop),	  // Alternate input for glitch filter
   		.PULLUP_H(xres_vss_loop),	  // Pullup connection for alternate filter input
		.ENABLE_VDDIO(vccd_const_one[6])
    	);
	*/
	pc3d21 resetb_pad (
	       .PAD(resetb),
	       .CIN(resetb_core_h)
	       );
	// Corner cells (These are overlay cells;  it is not clear what is normally
    	// supposed to go under them.)

	/*    sky130_ef_io__corner_pad mgmt_corner [1:0] (
`ifndef TOP_ROUTING
		.VSSIO(vssio),
		.VDDIO(vddio),
		.VDDIO_Q(vddio_q),
		.VSSIO_Q(vssio_q),
		.AMUXBUS_A(analog_a),
		.AMUXBUS_B(analog_b),
		.VSSD(vssd),
		.VSSA(vssa),
		.VSWITCH(vddio),
		.VDDA(vdda),
		.VCCD(vccd),
		.VCCHIB(vccd)
`endif
    	    );
	    sky130_ef_io__corner_pad user1_corner (
`ifndef TOP_ROUTING
		.VSSIO(vssio),
		.VDDIO(vddio),
		.VDDIO_Q(vddio_q),
		.VSSIO_Q(vssio_q),
		.AMUXBUS_A(analog_a),
		.AMUXBUS_B(analog_b),
		.VSSD(vssd),
		.VSSA(vssa1),
		.VSWITCH(vddio),
		.VDDA(vdda1),
		.VCCD(vccd),
		.VCCHIB(vccd)
`endif
    	    );
	    sky130_ef_io__corner_pad user2_corner (
`ifndef TOP_ROUTING
		.VSSIO(vssio),
		.VDDIO(vddio),
		.VDDIO_Q(vddio_q),
		.VSSIO_Q(vssio_q),
		.AMUXBUS_A(analog_a),
		.AMUXBUS_B(analog_b),
		.VSSD(vssd),
		.VSSA(vssa2),
		.VSWITCH(vddio),
		.VDDA(vdda2),
		.VCCD(vccd),
		.VCCHIB(vccd)
`endif
    	    );
*/
	mprj_io mprj_pads(
		.vddio(vddio),
		.vssio(vssio),
		.vccd(vccd),
		.vssd(vssd),
		.vdda1(vdda1),
		.vdda2(vdda2),
		.vssa1(vssa1),
		.vssa2(vssa2),
		.vddio_q(vddio_q),
		.vssio_q(vssio_q),
		.analog_a(analog_a),
		.analog_b(analog_b),
		.porb_h(porb_h),
		.vccd_conb(mprj_io_one),
		.io(mprj_io),
		.io_out(mprj_io_out),
		.oeb(mprj_io_oeb),
		.enh(mprj_io_enh),
		.inp_dis(mprj_io_inp_dis),
		.ib_mode_sel(mprj_io_ib_mode_sel),
		.vtrip_sel(mprj_io_vtrip_sel),
		.holdover(mprj_io_holdover),
		.slow_sel(mprj_io_slow_sel),
		.analog_en(mprj_io_analog_en),
		.analog_sel(mprj_io_analog_sel),
		.analog_pol(mprj_io_analog_pol),
		.dm(mprj_io_dm),
		.io_in(mprj_io_in),
		.analog_io(mprj_analog_io)
	);

	// assign mprj_io_in = dummy_mprj_io_in &  ~mprj_io_inp_dis;
/*
 assign \mprj_pads.analog_io[30]  = mprj_analog_io[30];
  assign \mprj_pads.analog_io[29]  = mprj_analog_io[29];
  assign \mprj_pads.analog_io[28]  = mprj_analog_io[28];
  assign \mprj_pads.analog_io[27]  = mprj_analog_io[27];
  assign \mprj_pads.analog_io[26]  = mprj_analog_io[26];
  assign \mprj_pads.analog_io[25]  = mprj_analog_io[25];
  assign \mprj_pads.analog_io[24]  = mprj_analog_io[24];
  assign \mprj_pads.analog_io[23]  = mprj_analog_io[23];
  assign \mprj_pads.analog_io[22]  = mprj_analog_io[22];
  assign \mprj_pads.analog_io[21]  = mprj_analog_io[21];
  assign \mprj_pads.analog_io[20]  = mprj_analog_io[20];
  assign \mprj_pads.analog_io[19]  = mprj_analog_io[19];
  assign \mprj_pads.analog_io[18]  = mprj_analog_io[18];
  assign \mprj_pads.analog_io[17]  = mprj_analog_io[17];
  assign \mprj_pads.analog_io[16]  = mprj_analog_io[16];
  assign \mprj_pads.analog_io[15]  = mprj_analog_io[15];
  assign \mprj_pads.analog_io[14]  = mprj_analog_io[14];
  assign \mprj_pads.analog_io[13]  = mprj_analog_io[13];
  assign \mprj_pads.analog_io[12]  = mprj_analog_io[12];
  assign \mprj_pads.analog_io[11]  = mprj_analog_io[11];
  assign \mprj_pads.analog_io[10]  = mprj_analog_io[10];
  assign \mprj_pads.analog_io[9]  = mprj_analog_io[9];
  assign \mprj_pads.analog_io[8]  = mprj_analog_io[8];
  assign \mprj_pads.analog_io[7]  = mprj_analog_io[7];
  assign \mprj_pads.analog_io[6]  = mprj_analog_io[6];
  assign \mprj_pads.analog_io[5]  = mprj_analog_io[5];
  assign \mprj_pads.analog_io[4]  = mprj_analog_io[4];
  assign \mprj_pads.analog_io[3]  = mprj_analog_io[3];
  assign \mprj_pads.analog_io[2]  = mprj_analog_io[2];
  assign \mprj_pads.analog_io[1]  = mprj_analog_io[1];
  assign \mprj_pads.analog_io[0]  = mprj_analog_io[0];
  assign \mprj_pads.analog_sel[37]  = mprj_io_analog_sel[37];
  assign \mprj_pads.analog_sel[36]  = mprj_io_analog_sel[36];
  assign \mprj_pads.analog_sel[35]  = mprj_io_analog_sel[35];
  assign \mprj_pads.analog_sel[34]  = mprj_io_analog_sel[34];
  assign \mprj_pads.analog_sel[33]  = mprj_io_analog_sel[33];
  assign \mprj_pads.analog_sel[32]  = mprj_io_analog_sel[32];
  assign \mprj_pads.analog_sel[31]  = mprj_io_analog_sel[31];
  assign \mprj_pads.analog_sel[30]  = mprj_io_analog_sel[30];
  assign \mprj_pads.analog_sel[29]  = mprj_io_analog_sel[29];
  assign \mprj_pads.analog_sel[28]  = mprj_io_analog_sel[28];
  assign \mprj_pads.analog_sel[27]  = mprj_io_analog_sel[27];
  assign \mprj_pads.analog_sel[26]  = mprj_io_analog_sel[26];
  assign \mprj_pads.analog_sel[25]  = mprj_io_analog_sel[25];
  assign \mprj_pads.analog_sel[24]  = mprj_io_analog_sel[24];
  assign \mprj_pads.analog_sel[23]  = mprj_io_analog_sel[23];
  assign \mprj_pads.analog_sel[22]  = mprj_io_analog_sel[22];
  assign \mprj_pads.analog_sel[21]  = mprj_io_analog_sel[21];
  assign \mprj_pads.analog_sel[20]  = mprj_io_analog_sel[20];
  assign \mprj_pads.analog_sel[19]  = mprj_io_analog_sel[19];
  assign \mprj_pads.analog_sel[18]  = mprj_io_analog_sel[18];
  assign \mprj_pads.analog_sel[17]  = mprj_io_analog_sel[17];
  assign \mprj_pads.analog_sel[16]  = mprj_io_analog_sel[16];
  assign \mprj_pads.analog_sel[15]  = mprj_io_analog_sel[15];
  assign \mprj_pads.analog_sel[14]  = mprj_io_analog_sel[14];
  assign \mprj_pads.analog_sel[13]  = mprj_io_analog_sel[13];
  assign \mprj_pads.analog_sel[12]  = mprj_io_analog_sel[12];
  assign \mprj_pads.analog_sel[11]  = mprj_io_analog_sel[11];
  assign \mprj_pads.analog_sel[10]  = mprj_io_analog_sel[10];
  assign \mprj_pads.analog_sel[9]  = mprj_io_analog_sel[9];
  assign \mprj_pads.analog_sel[8]  = mprj_io_analog_sel[8];
  assign \mprj_pads.analog_sel[7]  = mprj_io_analog_sel[7];
  assign \mprj_pads.analog_sel[6]  = mprj_io_analog_sel[6];
  assign \mprj_pads.analog_sel[5]  = mprj_io_analog_sel[5];
  assign \mprj_pads.analog_sel[4]  = mprj_io_analog_sel[4];
  assign \mprj_pads.analog_sel[3]  = mprj_io_analog_sel[3];
  assign \mprj_pads.analog_sel[2]  = mprj_io_analog_sel[2];
  assign \mprj_pads.analog_sel[1]  = mprj_io_analog_sel[1];
  assign \mprj_pads.analog_sel[0]  = mprj_io_analog_sel[0];
  assign \mprj_pads.ib_mode_sel[37]  = mprj_io_ib_mode_sel[37];
  assign \mprj_pads.ib_mode_sel[36]  = mprj_io_ib_mode_sel[36];
  assign \mprj_pads.ib_mode_sel[35]  = mprj_io_ib_mode_sel[35];
  assign \mprj_pads.ib_mode_sel[34]  = mprj_io_ib_mode_sel[34];
  assign \mprj_pads.ib_mode_sel[33]  = mprj_io_ib_mode_sel[33];
  assign \mprj_pads.ib_mode_sel[32]  = mprj_io_ib_mode_sel[32];
  assign \mprj_pads.ib_mode_sel[31]  = mprj_io_ib_mode_sel[31];
  assign \mprj_pads.ib_mode_sel[30]  = mprj_io_ib_mode_sel[30];
  assign \mprj_pads.ib_mode_sel[29]  = mprj_io_ib_mode_sel[29];
  assign \mprj_pads.ib_mode_sel[28]  = mprj_io_ib_mode_sel[28];
  assign \mprj_pads.ib_mode_sel[27]  = mprj_io_ib_mode_sel[27];
  assign \mprj_pads.ib_mode_sel[26]  = mprj_io_ib_mode_sel[26];
  assign \mprj_pads.ib_mode_sel[25]  = mprj_io_ib_mode_sel[25];
  assign \mprj_pads.ib_mode_sel[24]  = mprj_io_ib_mode_sel[24];
  assign \mprj_pads.ib_mode_sel[23]  = mprj_io_ib_mode_sel[23];
  assign \mprj_pads.ib_mode_sel[22]  = mprj_io_ib_mode_sel[22];
  assign \mprj_pads.ib_mode_sel[21]  = mprj_io_ib_mode_sel[21];
  assign \mprj_pads.ib_mode_sel[20]  = mprj_io_ib_mode_sel[20];
  assign \mprj_pads.ib_mode_sel[19]  = mprj_io_ib_mode_sel[19];
  assign \mprj_pads.ib_mode_sel[18]  = mprj_io_ib_mode_sel[18];
  assign \mprj_pads.ib_mode_sel[17]  = mprj_io_ib_mode_sel[17];
  assign \mprj_pads.ib_mode_sel[16]  = mprj_io_ib_mode_sel[16];
  assign \mprj_pads.ib_mode_sel[15]  = mprj_io_ib_mode_sel[15];
  assign \mprj_pads.ib_mode_sel[14]  = mprj_io_ib_mode_sel[14];
  assign \mprj_pads.ib_mode_sel[13]  = mprj_io_ib_mode_sel[13];
  assign \mprj_pads.ib_mode_sel[12]  = mprj_io_ib_mode_sel[12];
  assign \mprj_pads.ib_mode_sel[11]  = mprj_io_ib_mode_sel[11];
  assign \mprj_pads.ib_mode_sel[10]  = mprj_io_ib_mode_sel[10];
  assign \mprj_pads.ib_mode_sel[9]  = mprj_io_ib_mode_sel[9];
  assign \mprj_pads.ib_mode_sel[8]  = mprj_io_ib_mode_sel[8];
  assign \mprj_pads.ib_mode_sel[7]  = mprj_io_ib_mode_sel[7];
  assign \mprj_pads.ib_mode_sel[6]  = mprj_io_ib_mode_sel[6];
  assign \mprj_pads.ib_mode_sel[5]  = mprj_io_ib_mode_sel[5];
  assign \mprj_pads.ib_mode_sel[4]  = mprj_io_ib_mode_sel[4];
  assign \mprj_pads.ib_mode_sel[3]  = mprj_io_ib_mode_sel[3];
  assign \mprj_pads.ib_mode_sel[2]  = mprj_io_ib_mode_sel[2];
  assign \mprj_pads.ib_mode_sel[1]  = mprj_io_ib_mode_sel[1];
  assign \mprj_pads.ib_mode_sel[0]  = mprj_io_ib_mode_sel[0];
  assign \mprj_pads.vtrip_sel[37]  = mprj_io_vtrip_sel[37];
  assign \mprj_pads.vtrip_sel[36]  = mprj_io_vtrip_sel[36];
  assign \mprj_pads.vtrip_sel[35]  = mprj_io_vtrip_sel[35];
  assign \mprj_pads.vtrip_sel[34]  = mprj_io_vtrip_sel[34];
  assign \mprj_pads.vtrip_sel[33]  = mprj_io_vtrip_sel[33];
  assign \mprj_pads.vtrip_sel[32]  = mprj_io_vtrip_sel[32];
  assign \mprj_pads.vtrip_sel[31]  = mprj_io_vtrip_sel[31];
  assign \mprj_pads.vtrip_sel[30]  = mprj_io_vtrip_sel[30];
  assign \mprj_pads.vtrip_sel[29]  = mprj_io_vtrip_sel[29];
  assign \mprj_pads.vtrip_sel[28]  = mprj_io_vtrip_sel[28];
  assign \mprj_pads.vtrip_sel[27]  = mprj_io_vtrip_sel[27];
  assign \mprj_pads.vtrip_sel[26]  = mprj_io_vtrip_sel[26];
  assign \mprj_pads.vtrip_sel[25]  = mprj_io_vtrip_sel[25];
  assign \mprj_pads.vtrip_sel[24]  = mprj_io_vtrip_sel[24];
  assign \mprj_pads.vtrip_sel[23]  = mprj_io_vtrip_sel[23];
  assign \mprj_pads.vtrip_sel[22]  = mprj_io_vtrip_sel[22];
  assign \mprj_pads.vtrip_sel[21]  = mprj_io_vtrip_sel[21];
  assign \mprj_pads.vtrip_sel[20]  = mprj_io_vtrip_sel[20];
  assign \mprj_pads.vtrip_sel[19]  = mprj_io_vtrip_sel[19];
  assign \mprj_pads.vtrip_sel[18]  = mprj_io_vtrip_sel[18];
  assign \mprj_pads.vtrip_sel[17]  = mprj_io_vtrip_sel[17];
  assign \mprj_pads.vtrip_sel[16]  = mprj_io_vtrip_sel[16];
  assign \mprj_pads.vtrip_sel[15]  = mprj_io_vtrip_sel[15];
  assign \mprj_pads.vtrip_sel[14]  = mprj_io_vtrip_sel[14];
  assign \mprj_pads.vtrip_sel[13]  = mprj_io_vtrip_sel[13];
  assign \mprj_pads.vtrip_sel[12]  = mprj_io_vtrip_sel[12];
  assign \mprj_pads.vtrip_sel[11]  = mprj_io_vtrip_sel[11];
  assign \mprj_pads.vtrip_sel[10]  = mprj_io_vtrip_sel[10];
  assign \mprj_pads.vtrip_sel[9]  = mprj_io_vtrip_sel[9];
  assign \mprj_pads.vtrip_sel[8]  = mprj_io_vtrip_sel[8];
  assign \mprj_pads.vtrip_sel[7]  = mprj_io_vtrip_sel[7];
  assign \mprj_pads.vtrip_sel[6]  = mprj_io_vtrip_sel[6];
  assign \mprj_pads.vtrip_sel[5]  = mprj_io_vtrip_sel[5];
  assign \mprj_pads.vtrip_sel[4]  = mprj_io_vtrip_sel[4];
  assign \mprj_pads.vtrip_sel[3]  = mprj_io_vtrip_sel[3];
  assign \mprj_pads.vtrip_sel[2]  = mprj_io_vtrip_sel[2];
  assign \mprj_pads.vtrip_sel[1]  = mprj_io_vtrip_sel[1];
  assign \mprj_pads.vtrip_sel[0]  = mprj_io_vtrip_sel[0];
  assign \mprj_pads.inp_dis[37]  = mprj_io_inp_dis[37];
  assign \mprj_pads.inp_dis[36]  = mprj_io_inp_dis[36];
  assign \mprj_pads.inp_dis[35]  = mprj_io_inp_dis[35];
  assign \mprj_pads.inp_dis[34]  = mprj_io_inp_dis[34];
  assign \mprj_pads.inp_dis[33]  = mprj_io_inp_dis[33];
  assign \mprj_pads.inp_dis[32]  = mprj_io_inp_dis[32];
  assign \mprj_pads.inp_dis[31]  = mprj_io_inp_dis[31];
  assign \mprj_pads.inp_dis[30]  = mprj_io_inp_dis[30];
  assign \mprj_pads.inp_dis[29]  = mprj_io_inp_dis[29];
  assign \mprj_pads.inp_dis[28]  = mprj_io_inp_dis[28];
  assign \mprj_pads.inp_dis[27]  = mprj_io_inp_dis[27];
  assign \mprj_pads.inp_dis[26]  = mprj_io_inp_dis[26];
  assign \mprj_pads.inp_dis[25]  = mprj_io_inp_dis[25];
  assign \mprj_pads.inp_dis[24]  = mprj_io_inp_dis[24];
  assign \mprj_pads.inp_dis[23]  = mprj_io_inp_dis[23];
  assign \mprj_pads.inp_dis[22]  = mprj_io_inp_dis[22];
  assign \mprj_pads.inp_dis[21]  = mprj_io_inp_dis[21];
  assign \mprj_pads.inp_dis[20]  = mprj_io_inp_dis[20];
  assign \mprj_pads.inp_dis[19]  = mprj_io_inp_dis[19];
  assign \mprj_pads.inp_dis[18]  = mprj_io_inp_dis[18];
  assign \mprj_pads.inp_dis[17]  = mprj_io_inp_dis[17];
  assign \mprj_pads.inp_dis[16]  = mprj_io_inp_dis[16];
  assign \mprj_pads.inp_dis[15]  = mprj_io_inp_dis[15];
  assign \mprj_pads.inp_dis[14]  = mprj_io_inp_dis[14];
  assign \mprj_pads.inp_dis[13]  = mprj_io_inp_dis[13];
  assign \mprj_pads.inp_dis[12]  = mprj_io_inp_dis[12];
  assign \mprj_pads.inp_dis[11]  = mprj_io_inp_dis[11];
  assign \mprj_pads.inp_dis[10]  = mprj_io_inp_dis[10];
  assign \mprj_pads.inp_dis[9]  = mprj_io_inp_dis[9];
  assign \mprj_pads.inp_dis[8]  = mprj_io_inp_dis[8];
  assign \mprj_pads.inp_dis[7]  = mprj_io_inp_dis[7];
  assign \mprj_pads.inp_dis[6]  = mprj_io_inp_dis[6];
  assign \mprj_pads.inp_dis[5]  = mprj_io_inp_dis[5];
  assign \mprj_pads.inp_dis[4]  = mprj_io_inp_dis[4];
  assign \mprj_pads.inp_dis[3]  = mprj_io_inp_dis[3];
  assign \mprj_pads.inp_dis[2]  = mprj_io_inp_dis[2];
  assign \mprj_pads.inp_dis[1]  = mprj_io_inp_dis[1];
  assign \mprj_pads.inp_dis[0]  = mprj_io_inp_dis[0];
  assign \mprj_pads.enh[37]  = mprj_io_enh[37];
  assign \mprj_pads.enh[36]  = mprj_io_enh[36];
  assign \mprj_pads.enh[35]  = mprj_io_enh[35];
  assign \mprj_pads.enh[34]  = mprj_io_enh[34];
  assign \mprj_pads.enh[33]  = mprj_io_enh[33];
  assign \mprj_pads.enh[32]  = mprj_io_enh[32];
  assign \mprj_pads.enh[31]  = mprj_io_enh[31];
  assign \mprj_pads.enh[30]  = mprj_io_enh[30];
  assign \mprj_pads.enh[29]  = mprj_io_enh[29];
  assign \mprj_pads.enh[28]  = mprj_io_enh[28];
  assign \mprj_pads.enh[27]  = mprj_io_enh[27];
  assign \mprj_pads.enh[26]  = mprj_io_enh[26];
  assign \mprj_pads.enh[25]  = mprj_io_enh[25];
  assign \mprj_pads.enh[24]  = mprj_io_enh[24];
  assign \mprj_pads.enh[23]  = mprj_io_enh[23];
  assign \mprj_pads.enh[22]  = mprj_io_enh[22];
  assign \mprj_pads.enh[21]  = mprj_io_enh[21];
  assign \mprj_pads.enh[20]  = mprj_io_enh[20];
  assign \mprj_pads.enh[19]  = mprj_io_enh[19];
  assign \mprj_pads.enh[18]  = mprj_io_enh[18];
  assign \mprj_pads.enh[17]  = mprj_io_enh[17];
  assign \mprj_pads.enh[16]  = mprj_io_enh[16];
  assign \mprj_pads.enh[15]  = mprj_io_enh[15];
  assign \mprj_pads.enh[14]  = mprj_io_enh[14];
  assign \mprj_pads.enh[13]  = mprj_io_enh[13];
  assign \mprj_pads.enh[12]  = mprj_io_enh[12];
  assign \mprj_pads.enh[11]  = mprj_io_enh[11];
  assign \mprj_pads.enh[10]  = mprj_io_enh[10];
  assign \mprj_pads.enh[9]  = mprj_io_enh[9];
  assign \mprj_pads.enh[8]  = mprj_io_enh[8];
  assign \mprj_pads.enh[7]  = mprj_io_enh[7];
  assign \mprj_pads.enh[6]  = mprj_io_enh[6];
  assign \mprj_pads.enh[5]  = mprj_io_enh[5];
  assign \mprj_pads.enh[4]  = mprj_io_enh[4];
  assign \mprj_pads.enh[3]  = mprj_io_enh[3];
  assign \mprj_pads.enh[2]  = mprj_io_enh[2];
  assign \mprj_pads.enh[1]  = mprj_io_enh[1];
  assign \mprj_pads.enh[0]  = mprj_io_enh[0];
 /* assign \mprj_pads.hldh_n[37]  = mprj_io_hldh_n[37];
  assign \mprj_pads.hldh_n[36]  = mprj_io_hldh_n[36];
  assign \mprj_pads.hldh_n[35]  = mprj_io_hldh_n[35];
  assign \mprj_pads.hldh_n[34]  = mprj_io_hldh_n[34];
  assign \mprj_pads.hldh_n[33]  = mprj_io_hldh_n[33];
  assign \mprj_pads.hldh_n[32]  = mprj_io_hldh_n[32];
  assign \mprj_pads.hldh_n[31]  = mprj_io_hldh_n[31];
  assign \mprj_pads.hldh_n[30]  = mprj_io_hldh_n[30];
  assign \mprj_pads.hldh_n[29]  = mprj_io_hldh_n[29];
  assign \mprj_pads.hldh_n[28]  = mprj_io_hldh_n[28];
  assign \mprj_pads.hldh_n[27]  = mprj_io_hldh_n[27];
  assign \mprj_pads.hldh_n[26]  = mprj_io_hldh_n[26];
  assign \mprj_pads.hldh_n[25]  = mprj_io_hldh_n[25];
  assign \mprj_pads.hldh_n[24]  = mprj_io_hldh_n[24];
  assign \mprj_pads.hldh_n[23]  = mprj_io_hldh_n[23];
  assign \mprj_pads.hldh_n[22]  = mprj_io_hldh_n[22];
  assign \mprj_pads.hldh_n[21]  = mprj_io_hldh_n[21];
  assign \mprj_pads.hldh_n[20]  = mprj_io_hldh_n[20];
  assign \mprj_pads.hldh_n[19]  = mprj_io_hldh_n[19];
  assign \mprj_pads.hldh_n[18]  = mprj_io_hldh_n[18];
  assign \mprj_pads.hldh_n[17]  = mprj_io_hldh_n[17];
  assign \mprj_pads.hldh_n[16]  = mprj_io_hldh_n[16];
  assign \mprj_pads.hldh_n[15]  = mprj_io_hldh_n[15];
  assign \mprj_pads.hldh_n[14]  = mprj_io_hldh_n[14];
  assign \mprj_pads.hldh_n[13]  = mprj_io_hldh_n[13];
  assign \mprj_pads.hldh_n[12]  = mprj_io_hldh_n[12];
  assign \mprj_pads.hldh_n[11]  = mprj_io_hldh_n[11];
  assign \mprj_pads.hldh_n[10]  = mprj_io_hldh_n[10];
  assign \mprj_pads.hldh_n[9]  = mprj_io_hldh_n[9];
  assign \mprj_pads.hldh_n[8]  = mprj_io_hldh_n[8];
  assign \mprj_pads.hldh_n[7]  = mprj_io_hldh_n[7];
  assign \mprj_pads.hldh_n[6]  = mprj_io_hldh_n[6];
  assign \mprj_pads.hldh_n[5]  = mprj_io_hldh_n[5];
  assign \mprj_pads.hldh_n[4]  = mprj_io_hldh_n[4];
  assign \mprj_pads.hldh_n[3]  = mprj_io_hldh_n[3];
  assign \mprj_pads.hldh_n[2]  = mprj_io_hldh_n[2];
  assign \mprj_pads.hldh_n[1]  = mprj_io_hldh_n[1];
  assign \mprj_pads.hldh_n[0]  = mprj_io_hldh_n[0];

  assign \mprj_pads.slow_sel[37]  = mprj_io_slow_sel[37];
  assign \mprj_pads.slow_sel[36]  = mprj_io_slow_sel[36];
  assign \mprj_pads.slow_sel[35]  = mprj_io_slow_sel[35];
  assign \mprj_pads.slow_sel[34]  = mprj_io_slow_sel[34];
  assign \mprj_pads.slow_sel[33]  = mprj_io_slow_sel[33];
  assign \mprj_pads.slow_sel[32]  = mprj_io_slow_sel[32];
  assign \mprj_pads.slow_sel[31]  = mprj_io_slow_sel[31];
  assign \mprj_pads.slow_sel[30]  = mprj_io_slow_sel[30];
  assign \mprj_pads.slow_sel[29]  = mprj_io_slow_sel[29];
  assign \mprj_pads.slow_sel[28]  = mprj_io_slow_sel[28];
  assign \mprj_pads.slow_sel[27]  = mprj_io_slow_sel[27];
  assign \mprj_pads.slow_sel[26]  = mprj_io_slow_sel[26];
  assign \mprj_pads.slow_sel[25]  = mprj_io_slow_sel[25];
  assign \mprj_pads.slow_sel[24]  = mprj_io_slow_sel[24];
  assign \mprj_pads.slow_sel[23]  = mprj_io_slow_sel[23];
  assign \mprj_pads.slow_sel[22]  = mprj_io_slow_sel[22];
  assign \mprj_pads.slow_sel[21]  = mprj_io_slow_sel[21];
  assign \mprj_pads.slow_sel[20]  = mprj_io_slow_sel[20];
  assign \mprj_pads.slow_sel[19]  = mprj_io_slow_sel[19];
  assign \mprj_pads.slow_sel[18]  = mprj_io_slow_sel[18];
  assign \mprj_pads.slow_sel[17]  = mprj_io_slow_sel[17];
  assign \mprj_pads.slow_sel[16]  = mprj_io_slow_sel[16];
  assign \mprj_pads.slow_sel[15]  = mprj_io_slow_sel[15];
  assign \mprj_pads.slow_sel[14]  = mprj_io_slow_sel[14];
  assign \mprj_pads.slow_sel[13]  = mprj_io_slow_sel[13];
  assign \mprj_pads.slow_sel[12]  = mprj_io_slow_sel[12];
  assign \mprj_pads.slow_sel[11]  = mprj_io_slow_sel[11];
  assign \mprj_pads.slow_sel[10]  = mprj_io_slow_sel[10];
  assign \mprj_pads.slow_sel[9]  = mprj_io_slow_sel[9];
  assign \mprj_pads.slow_sel[8]  = mprj_io_slow_sel[8];
  assign \mprj_pads.slow_sel[7]  = mprj_io_slow_sel[7];
  assign \mprj_pads.slow_sel[6]  = mprj_io_slow_sel[6];
  assign \mprj_pads.slow_sel[5]  = mprj_io_slow_sel[5];
  assign \mprj_pads.slow_sel[4]  = mprj_io_slow_sel[4];
  assign \mprj_pads.slow_sel[3]  = mprj_io_slow_sel[3];
  assign \mprj_pads.slow_sel[2]  = mprj_io_slow_sel[2];
  assign \mprj_pads.slow_sel[1]  = mprj_io_slow_sel[1];
  assign \mprj_pads.slow_sel[0]  = mprj_io_slow_sel[0];
  assign \mprj_pads.holdover[37]  = mprj_io_holdover[37];
  assign \mprj_pads.holdover[36]  = mprj_io_holdover[36];
  assign \mprj_pads.holdover[35]  = mprj_io_holdover[35];
  assign \mprj_pads.holdover[34]  = mprj_io_holdover[34];
  assign \mprj_pads.holdover[33]  = mprj_io_holdover[33];
  assign \mprj_pads.holdover[32]  = mprj_io_holdover[32];
  assign \mprj_pads.holdover[31]  = mprj_io_holdover[31];
  assign \mprj_pads.holdover[30]  = mprj_io_holdover[30];
  assign \mprj_pads.holdover[29]  = mprj_io_holdover[29];
  assign \mprj_pads.holdover[28]  = mprj_io_holdover[28];
  assign \mprj_pads.holdover[27]  = mprj_io_holdover[27];
  assign \mprj_pads.holdover[26]  = mprj_io_holdover[26];
  assign \mprj_pads.holdover[25]  = mprj_io_holdover[25];
  assign \mprj_pads.holdover[24]  = mprj_io_holdover[24];
  assign \mprj_pads.holdover[23]  = mprj_io_holdover[23];
  assign \mprj_pads.holdover[22]  = mprj_io_holdover[22];
  assign \mprj_pads.holdover[21]  = mprj_io_holdover[21];
  assign \mprj_pads.holdover[20]  = mprj_io_holdover[20];
  assign \mprj_pads.holdover[19]  = mprj_io_holdover[19];
  assign \mprj_pads.holdover[18]  = mprj_io_holdover[18];
  assign \mprj_pads.holdover[17]  = mprj_io_holdover[17];
  assign \mprj_pads.holdover[16]  = mprj_io_holdover[16];
  assign \mprj_pads.holdover[15]  = mprj_io_holdover[15];
  assign \mprj_pads.holdover[14]  = mprj_io_holdover[14];
  assign \mprj_pads.holdover[13]  = mprj_io_holdover[13];
  assign \mprj_pads.holdover[12]  = mprj_io_holdover[12];
  assign \mprj_pads.holdover[11]  = mprj_io_holdover[11];
  assign \mprj_pads.holdover[10]  = mprj_io_holdover[10];
  assign \mprj_pads.holdover[9]  = mprj_io_holdover[9];
  assign \mprj_pads.holdover[8]  = mprj_io_holdover[8];
  assign \mprj_pads.holdover[7]  = mprj_io_holdover[7];
  assign \mprj_pads.holdover[6]  = mprj_io_holdover[6];
  assign \mprj_pads.holdover[5]  = mprj_io_holdover[5];
  assign \mprj_pads.holdover[4]  = mprj_io_holdover[4];
  assign \mprj_pads.holdover[3]  = mprj_io_holdover[3];
  assign \mprj_pads.holdover[2]  = mprj_io_holdover[2];
  assign \mprj_pads.holdover[1]  = mprj_io_holdover[1];
  assign \mprj_pads.holdover[0]  = mprj_io_holdover[0];
  assign \mprj_pads.io_out[37]  = mprj_io_out[37];
  assign \mprj_pads.io_out[36]  = mprj_io_out[36];
  assign \mprj_pads.io_out[35]  = mprj_io_out[35];
  assign \mprj_pads.io_out[34]  = mprj_io_out[34];
  assign \mprj_pads.io_out[33]  = mprj_io_out[33];
  assign \mprj_pads.io_out[32]  = mprj_io_out[32];
  assign \mprj_pads.io_out[31]  = mprj_io_out[31];
  assign \mprj_pads.io_out[30]  = mprj_io_out[30];
  assign \mprj_pads.io_out[29]  = mprj_io_out[29];
  assign \mprj_pads.io_out[28]  = mprj_io_out[28];
  assign \mprj_pads.io_out[27]  = mprj_io_out[27];
  assign \mprj_pads.io_out[26]  = mprj_io_out[26];
  assign \mprj_pads.io_out[25]  = mprj_io_out[25];
  assign \mprj_pads.io_out[24]  = mprj_io_out[24];
  assign \mprj_pads.io_out[23]  = mprj_io_out[23];
  assign \mprj_pads.io_out[22]  = mprj_io_out[22];
  assign \mprj_pads.io_out[21]  = mprj_io_out[21];
  assign \mprj_pads.io_out[20]  = mprj_io_out[20];
  assign \mprj_pads.io_out[19]  = mprj_io_out[19];
  assign \mprj_pads.io_out[18]  = mprj_io_out[18];
  assign \mprj_pads.io_out[17]  = mprj_io_out[17];
  assign \mprj_pads.io_out[16]  = mprj_io_out[16];
  assign \mprj_pads.io_out[15]  = mprj_io_out[15];
  assign \mprj_pads.io_out[14]  = mprj_io_out[14];
  assign \mprj_pads.io_out[13]  = mprj_io_out[13];
  assign \mprj_pads.io_out[12]  = mprj_io_out[12];
  assign \mprj_pads.io_out[11]  = mprj_io_out[11];
  assign \mprj_pads.io_out[10]  = mprj_io_out[10];
  assign \mprj_pads.io_out[9]  = mprj_io_out[9];
  assign \mprj_pads.io_out[8]  = mprj_io_out[8];
  assign \mprj_pads.io_out[7]  = mprj_io_out[7];
  assign \mprj_pads.io_out[6]  = mprj_io_out[6];
  assign \mprj_pads.io_out[5]  = mprj_io_out[5];
  assign \mprj_pads.io_out[4]  = mprj_io_out[4];
  assign \mprj_pads.io_out[3]  = mprj_io_out[3];
  assign \mprj_pads.io_out[2]  = mprj_io_out[2];
  assign \mprj_pads.io_out[1]  = mprj_io_out[1];
  assign \mprj_pads.io_out[0]  = mprj_io_out[0];
  assign \mprj_pads.dm[113]  = mprj_io_dm[113];
  assign \mprj_pads.dm[112]  = mprj_io_dm[112];
  assign \mprj_pads.dm[111]  = mprj_io_dm[111];
  assign \mprj_pads.dm[110]  = mprj_io_dm[110];
  assign \mprj_pads.dm[109]  = mprj_io_dm[109];
  assign \mprj_pads.dm[108]  = mprj_io_dm[108];
  assign \mprj_pads.dm[107]  = mprj_io_dm[107];
  assign \mprj_pads.dm[106]  = mprj_io_dm[106];
  assign \mprj_pads.dm[105]  = mprj_io_dm[105];
  assign \mprj_pads.dm[104]  = mprj_io_dm[104];
  assign \mprj_pads.dm[103]  = mprj_io_dm[103];
  assign \mprj_pads.dm[102]  = mprj_io_dm[102];
  assign \mprj_pads.dm[101]  = mprj_io_dm[101];
  assign \mprj_pads.dm[100]  = mprj_io_dm[100];
  assign \mprj_pads.dm[99]  = mprj_io_dm[99];
  assign \mprj_pads.dm[98]  = mprj_io_dm[98];
  assign \mprj_pads.dm[97]  = mprj_io_dm[97];
  assign \mprj_pads.dm[96]  = mprj_io_dm[96];
  assign \mprj_pads.dm[95]  = mprj_io_dm[95];
  assign \mprj_pads.dm[94]  = mprj_io_dm[94];
  assign \mprj_pads.dm[93]  = mprj_io_dm[93];
  assign \mprj_pads.dm[92]  = mprj_io_dm[92];
  assign \mprj_pads.dm[91]  = mprj_io_dm[91];
  assign \mprj_pads.dm[90]  = mprj_io_dm[90];
  assign \mprj_pads.dm[89]  = mprj_io_dm[89];
  assign \mprj_pads.dm[88]  = mprj_io_dm[88];
  assign \mprj_pads.dm[87]  = mprj_io_dm[87];
  assign \mprj_pads.dm[86]  = mprj_io_dm[86];
  assign \mprj_pads.dm[85]  = mprj_io_dm[85];
  assign \mprj_pads.dm[84]  = mprj_io_dm[84];
  assign \mprj_pads.dm[83]  = mprj_io_dm[83];
  assign \mprj_pads.dm[82]  = mprj_io_dm[82];
  assign \mprj_pads.dm[81]  = mprj_io_dm[81];
  assign \mprj_pads.dm[80]  = mprj_io_dm[80];
  assign \mprj_pads.dm[79]  = mprj_io_dm[79];
  assign \mprj_pads.dm[78]  = mprj_io_dm[78];
  assign \mprj_pads.dm[77]  = mprj_io_dm[77];
  assign \mprj_pads.dm[76]  = mprj_io_dm[76];
  assign \mprj_pads.dm[75]  = mprj_io_dm[75];
  assign \mprj_pads.dm[74]  = mprj_io_dm[74];
  assign \mprj_pads.dm[73]  = mprj_io_dm[73];
  assign \mprj_pads.dm[72]  = mprj_io_dm[72];
  assign \mprj_pads.dm[71]  = mprj_io_dm[71];
  assign \mprj_pads.dm[70]  = mprj_io_dm[70];
  assign \mprj_pads.dm[69]  = mprj_io_dm[69];
  assign \mprj_pads.dm[68]  = mprj_io_dm[68];
  assign \mprj_pads.dm[67]  = mprj_io_dm[67];
  assign \mprj_pads.dm[66]  = mprj_io_dm[66];
  assign \mprj_pads.dm[65]  = mprj_io_dm[65];
  assign \mprj_pads.dm[64]  = mprj_io_dm[64];
  assign \mprj_pads.dm[63]  = mprj_io_dm[63];
  assign \mprj_pads.dm[62]  = mprj_io_dm[62];
  assign \mprj_pads.dm[61]  = mprj_io_dm[61];
  assign \mprj_pads.dm[60]  = mprj_io_dm[60];
  assign \mprj_pads.dm[59]  = mprj_io_dm[59];
  assign \mprj_pads.dm[58]  = mprj_io_dm[58];
  assign \mprj_pads.dm[57]  = mprj_io_dm[57];
  assign \mprj_pads.dm[56]  = mprj_io_dm[56];
  assign \mprj_pads.dm[55]  = mprj_io_dm[55];
  assign \mprj_pads.dm[54]  = mprj_io_dm[54];
  assign \mprj_pads.dm[53]  = mprj_io_dm[53];
  assign \mprj_pads.dm[52]  = mprj_io_dm[52];
  assign \mprj_pads.dm[51]  = mprj_io_dm[51];
  assign \mprj_pads.dm[50]  = mprj_io_dm[50];
  assign \mprj_pads.dm[49]  = mprj_io_dm[49];
  assign \mprj_pads.dm[48]  = mprj_io_dm[48];
  assign \mprj_pads.dm[47]  = mprj_io_dm[47];
  assign \mprj_pads.dm[46]  = mprj_io_dm[46];
  assign \mprj_pads.dm[45]  = mprj_io_dm[45];
  assign \mprj_pads.dm[44]  = mprj_io_dm[44];
  assign \mprj_pads.dm[43]  = mprj_io_dm[43];
  assign \mprj_pads.dm[42]  = mprj_io_dm[42];
  assign \mprj_pads.dm[41]  = mprj_io_dm[41];
  assign \mprj_pads.dm[40]  = mprj_io_dm[40];
  assign \mprj_pads.dm[39]  = mprj_io_dm[39];
  assign \mprj_pads.dm[38]  = mprj_io_dm[38];
  assign \mprj_pads.dm[37]  = mprj_io_dm[37];
  assign \mprj_pads.dm[36]  = mprj_io_dm[36];
  assign \mprj_pads.dm[35]  = mprj_io_dm[35];
  assign \mprj_pads.dm[34]  = mprj_io_dm[34];
  assign \mprj_pads.dm[33]  = mprj_io_dm[33];
  assign \mprj_pads.dm[32]  = mprj_io_dm[32];
  assign \mprj_pads.dm[31]  = mprj_io_dm[31];
  assign \mprj_pads.dm[30]  = mprj_io_dm[30];
  assign \mprj_pads.dm[29]  = mprj_io_dm[29];
  assign \mprj_pads.dm[28]  = mprj_io_dm[28];
  assign \mprj_pads.dm[27]  = mprj_io_dm[27];
  assign \mprj_pads.dm[26]  = mprj_io_dm[26];
  assign \mprj_pads.dm[25]  = mprj_io_dm[25];
  assign \mprj_pads.dm[24]  = mprj_io_dm[24];
  assign \mprj_pads.dm[23]  = mprj_io_dm[23];
  assign \mprj_pads.dm[22]  = mprj_io_dm[22];
  assign \mprj_pads.dm[21]  = mprj_io_dm[21];
  assign \mprj_pads.dm[20]  = mprj_io_dm[20];
  assign \mprj_pads.dm[19]  = mprj_io_dm[19];
  assign \mprj_pads.dm[18]  = mprj_io_dm[18];
  assign \mprj_pads.dm[17]  = mprj_io_dm[17];
  assign \mprj_pads.dm[16]  = mprj_io_dm[16];
  assign \mprj_pads.dm[15]  = mprj_io_dm[15];
  assign \mprj_pads.dm[14]  = mprj_io_dm[14];
  assign \mprj_pads.dm[13]  = mprj_io_dm[13];
  assign \mprj_pads.dm[12]  = mprj_io_dm[12];
  assign \mprj_pads.dm[11]  = mprj_io_dm[11];
  assign \mprj_pads.dm[10]  = mprj_io_dm[10];
  assign \mprj_pads.dm[9]  = mprj_io_dm[9];
  assign \mprj_pads.dm[8]  = mprj_io_dm[8];
  assign \mprj_pads.dm[7]  = mprj_io_dm[7];
  assign \mprj_pads.dm[6]  = mprj_io_dm[6];
  assign \mprj_pads.dm[5]  = mprj_io_dm[5];
  assign \mprj_pads.dm[4]  = mprj_io_dm[4];
  assign \mprj_pads.dm[3]  = mprj_io_dm[3];
  assign \mprj_pads.dm[2]  = mprj_io_dm[2];
  assign \mprj_pads.dm[1]  = mprj_io_dm[1];
  assign \mprj_pads.dm[0]  = mprj_io_dm[0];
  assign \mprj_pads.analog_pol[37]  = mprj_io_analog_pol[37];
  assign \mprj_pads.analog_pol[36]  = mprj_io_analog_pol[36];
  assign \mprj_pads.analog_pol[35]  = mprj_io_analog_pol[35];
  assign \mprj_pads.analog_pol[34]  = mprj_io_analog_pol[34];
  assign \mprj_pads.analog_pol[33]  = mprj_io_analog_pol[33];
  assign \mprj_pads.analog_pol[32]  = mprj_io_analog_pol[32];
  assign \mprj_pads.analog_pol[31]  = mprj_io_analog_pol[31];
  assign \mprj_pads.analog_pol[30]  = mprj_io_analog_pol[30];
  assign \mprj_pads.analog_pol[29]  = mprj_io_analog_pol[29];
  assign \mprj_pads.analog_pol[28]  = mprj_io_analog_pol[28];
  assign \mprj_pads.analog_pol[27]  = mprj_io_analog_pol[27];
  assign \mprj_pads.analog_pol[26]  = mprj_io_analog_pol[26];
  assign \mprj_pads.analog_pol[25]  = mprj_io_analog_pol[25];
  assign \mprj_pads.analog_pol[24]  = mprj_io_analog_pol[24];
  assign \mprj_pads.analog_pol[23]  = mprj_io_analog_pol[23];
  assign \mprj_pads.analog_pol[22]  = mprj_io_analog_pol[22];
  assign \mprj_pads.analog_pol[21]  = mprj_io_analog_pol[21];
  assign \mprj_pads.analog_pol[20]  = mprj_io_analog_pol[20];
  assign \mprj_pads.analog_pol[19]  = mprj_io_analog_pol[19];
  assign \mprj_pads.analog_pol[18]  = mprj_io_analog_pol[18];
  assign \mprj_pads.analog_pol[17]  = mprj_io_analog_pol[17];
  assign \mprj_pads.analog_pol[16]  = mprj_io_analog_pol[16];
  assign \mprj_pads.analog_pol[15]  = mprj_io_analog_pol[15];
  assign \mprj_pads.analog_pol[14]  = mprj_io_analog_pol[14];
  assign \mprj_pads.analog_pol[13]  = mprj_io_analog_pol[13];
  assign \mprj_pads.analog_pol[12]  = mprj_io_analog_pol[12];
  assign \mprj_pads.analog_pol[11]  = mprj_io_analog_pol[11];
  assign \mprj_pads.analog_pol[10]  = mprj_io_analog_pol[10];
  assign \mprj_pads.analog_pol[9]  = mprj_io_analog_pol[9];
  assign \mprj_pads.analog_pol[8]  = mprj_io_analog_pol[8];
  assign \mprj_pads.analog_pol[7]  = mprj_io_analog_pol[7];
  assign \mprj_pads.analog_pol[6]  = mprj_io_analog_pol[6];
  assign \mprj_pads.analog_pol[5]  = mprj_io_analog_pol[5];
  assign \mprj_pads.analog_pol[4]  = mprj_io_analog_pol[4];
  assign \mprj_pads.analog_pol[3]  = mprj_io_analog_pol[3];
  assign \mprj_pads.analog_pol[2]  = mprj_io_analog_pol[2];
  assign \mprj_pads.analog_pol[1]  = mprj_io_analog_pol[1];
  assign \mprj_pads.analog_pol[0]  = mprj_io_analog_pol[0];
  assign \mprj_pads.io[37]  = mprj_io[37];
  assign \mprj_pads.io[36]  = mprj_io[36];
  assign \mprj_pads.io[35]  = mprj_io[35];
  assign \mprj_pads.io[34]  = mprj_io[34];
  assign \mprj_pads.io[33]  = mprj_io[33];
  assign \mprj_pads.io[32]  = mprj_io[32];
  assign \mprj_pads.io[31]  = mprj_io[31];
  assign \mprj_pads.io[30]  = mprj_io[30];
  assign \mprj_pads.io[29]  = mprj_io[29];
  assign \mprj_pads.io[28]  = mprj_io[28];
  assign \mprj_pads.io[27]  = mprj_io[27];
  assign \mprj_pads.io[26]  = mprj_io[26];
  assign \mprj_pads.io[25]  = mprj_io[25];
  assign \mprj_pads.io[24]  = mprj_io[24];
  assign \mprj_pads.io[23]  = mprj_io[23];
  assign \mprj_pads.io[22]  = mprj_io[22];
  assign \mprj_pads.io[21]  = mprj_io[21];
  assign \mprj_pads.io[20]  = mprj_io[20];
  assign \mprj_pads.io[19]  = mprj_io[19];
  assign \mprj_pads.io[18]  = mprj_io[18];
  assign \mprj_pads.io[17]  = mprj_io[17];
  assign \mprj_pads.io[16]  = mprj_io[16];
  assign \mprj_pads.io[15]  = mprj_io[15];
  assign \mprj_pads.io[14]  = mprj_io[14];
  assign \mprj_pads.io[13]  = mprj_io[13];
  assign \mprj_pads.io[12]  = mprj_io[12];
  assign \mprj_pads.io[11]  = mprj_io[11];
  assign \mprj_pads.io[10]  = mprj_io[10];
  assign \mprj_pads.io[9]  = mprj_io[9];
  assign \mprj_pads.io[8]  = mprj_io[8];
  assign \mprj_pads.io[7]  = mprj_io[7];
  assign \mprj_pads.io[6]  = mprj_io[6];
  assign \mprj_pads.io[5]  = mprj_io[5];
  assign \mprj_pads.io[4]  = mprj_io[4];
  assign \mprj_pads.io[3]  = mprj_io[3];
  assign \mprj_pads.io[2]  = mprj_io[2];
  assign \mprj_pads.io[1]  = mprj_io[1];
  assign \mprj_pads.io[0]  = mprj_io[0];
  assign \mprj_pads.analog_en[37]  = mprj_io_analog_en[37];
  assign \mprj_pads.analog_en[36]  = mprj_io_analog_en[36];
  assign \mprj_pads.analog_en[35]  = mprj_io_analog_en[35];
  assign \mprj_pads.analog_en[34]  = mprj_io_analog_en[34];
  assign \mprj_pads.analog_en[33]  = mprj_io_analog_en[33];
  assign \mprj_pads.analog_en[32]  = mprj_io_analog_en[32];
  assign \mprj_pads.analog_en[31]  = mprj_io_analog_en[31];
  assign \mprj_pads.analog_en[30]  = mprj_io_analog_en[30];
  assign \mprj_pads.analog_en[29]  = mprj_io_analog_en[29];
  assign \mprj_pads.analog_en[28]  = mprj_io_analog_en[28];
  assign \mprj_pads.analog_en[27]  = mprj_io_analog_en[27];
  assign \mprj_pads.analog_en[26]  = mprj_io_analog_en[26];
  assign \mprj_pads.analog_en[25]  = mprj_io_analog_en[25];
  assign \mprj_pads.analog_en[24]  = mprj_io_analog_en[24];
  assign \mprj_pads.analog_en[23]  = mprj_io_analog_en[23];
  assign \mprj_pads.analog_en[22]  = mprj_io_analog_en[22];
  assign \mprj_pads.analog_en[21]  = mprj_io_analog_en[21];
  assign \mprj_pads.analog_en[20]  = mprj_io_analog_en[20];
  assign \mprj_pads.analog_en[19]  = mprj_io_analog_en[19];
  assign \mprj_pads.analog_en[18]  = mprj_io_analog_en[18];
  assign \mprj_pads.analog_en[17]  = mprj_io_analog_en[17];
  assign \mprj_pads.analog_en[16]  = mprj_io_analog_en[16];
  assign \mprj_pads.analog_en[15]  = mprj_io_analog_en[15];
  assign \mprj_pads.analog_en[14]  = mprj_io_analog_en[14];
  assign \mprj_pads.analog_en[13]  = mprj_io_analog_en[13];
  assign \mprj_pads.analog_en[12]  = mprj_io_analog_en[12];
  assign \mprj_pads.analog_en[11]  = mprj_io_analog_en[11];
  assign \mprj_pads.analog_en[10]  = mprj_io_analog_en[10];
  assign \mprj_pads.analog_en[9]  = mprj_io_analog_en[9];
  assign \mprj_pads.analog_en[8]  = mprj_io_analog_en[8];
  assign \mprj_pads.analog_en[7]  = mprj_io_analog_en[7];
  assign \mprj_pads.analog_en[6]  = mprj_io_analog_en[6];
  assign \mprj_pads.analog_en[5]  = mprj_io_analog_en[5];
  assign \mprj_pads.analog_en[4]  = mprj_io_analog_en[4];
  assign \mprj_pads.analog_en[3]  = mprj_io_analog_en[3];
  assign \mprj_pads.analog_en[2]  = mprj_io_analog_en[2];
  assign \mprj_pads.analog_en[1]  = mprj_io_analog_en[1];
  assign \mprj_pads.analog_en[0]  = mprj_io_analog_en[0];
  assign \mprj_pads.oeb[37]  = mprj_io_oeb[37];
  assign \mprj_pads.oeb[36]  = mprj_io_oeb[36];
  assign \mprj_pads.oeb[35]  = mprj_io_oeb[35];
  assign \mprj_pads.oeb[34]  = mprj_io_oeb[34];
  assign \mprj_pads.oeb[33]  = mprj_io_oeb[33];
  assign \mprj_pads.oeb[32]  = mprj_io_oeb[32];
  assign \mprj_pads.oeb[31]  = mprj_io_oeb[31];
  assign \mprj_pads.oeb[30]  = mprj_io_oeb[30];
  assign \mprj_pads.oeb[29]  = mprj_io_oeb[29];
  assign \mprj_pads.oeb[28]  = mprj_io_oeb[28];
  assign \mprj_pads.oeb[27]  = mprj_io_oeb[27];
  assign \mprj_pads.oeb[26]  = mprj_io_oeb[26];
  assign \mprj_pads.oeb[25]  = mprj_io_oeb[25];
  assign \mprj_pads.oeb[24]  = mprj_io_oeb[24];
  assign \mprj_pads.oeb[23]  = mprj_io_oeb[23];
  assign \mprj_pads.oeb[22]  = mprj_io_oeb[22];
  assign \mprj_pads.oeb[21]  = mprj_io_oeb[21];
  assign \mprj_pads.oeb[20]  = mprj_io_oeb[20];
  assign \mprj_pads.oeb[19]  = mprj_io_oeb[19];
  assign \mprj_pads.oeb[18]  = mprj_io_oeb[18];
  assign \mprj_pads.oeb[17]  = mprj_io_oeb[17];
  assign \mprj_pads.oeb[16]  = mprj_io_oeb[16];
  assign \mprj_pads.oeb[15]  = mprj_io_oeb[15];
  assign \mprj_pads.oeb[14]  = mprj_io_oeb[14];
  assign \mprj_pads.oeb[13]  = mprj_io_oeb[13];
  assign \mprj_pads.oeb[12]  = mprj_io_oeb[12];
  assign \mprj_pads.oeb[11]  = mprj_io_oeb[11];
  assign \mprj_pads.oeb[10]  = mprj_io_oeb[10];
  assign \mprj_pads.oeb[9]  = mprj_io_oeb[9];
  assign \mprj_pads.oeb[8]  = mprj_io_oeb[8];
  assign \mprj_pads.oeb[7]  = mprj_io_oeb[7];
  assign \mprj_pads.oeb[6]  = mprj_io_oeb[6];
  assign \mprj_pads.oeb[5]  = mprj_io_oeb[5];
  assign \mprj_pads.oeb[4]  = mprj_io_oeb[4];
  assign \mprj_pads.oeb[3]  = mprj_io_oeb[3];
  assign \mprj_pads.oeb[2]  = mprj_io_oeb[2];
  assign \mprj_pads.oeb[1]  = mprj_io_oeb[1];
  assign \mprj_pads.oeb[0]  = mprj_io_oeb[0];
  assign \mprj_pads.vddio  = vddio;
  assign \mprj_pads.vssio  = vssio;
  assign \mprj_pads.vccd  = vccd;
  assign \mprj_pads.vssd  = vssd;
  assign \mprj_pads.vdda1  = vdda1;
  assign \mprj_pads.vdda2  = vdda2;
  assign \mprj_pads.vssa1  = vssa1;
  assign \mprj_pads.vssa2  = vssa2;
  assign \mprj_pads.vccd1  = vccd1;
  assign \mprj_pads.vccd2  = vccd2;
  assign \mprj_pads.vssd1  = vssd1;
  assign \mprj_pads.vssd2  = vssd2;
  assign \mprj_pads.porb_h  = porb_h;
  assign \flash_io0_mode[0]  = flash_io0_oeb_core;
  assign \flash_io0_mode[2]  = flash_io0_ieb_core;
  assign \flash_io0_mode[1]  = flash_io0_ieb_core;
  assign \flash_io1_mode[0]  = flash_io1_oeb_core;
  assign \flash_io1_mode[1]  = flash_io1_ieb_core;
  assign \flash_io1_mode[2]  = flash_io1_ieb_core;
  assign \dm_all[1]  = gpio_mode1_core;
  assign \dm_all[0]  = gpio_mode0_core;
  assign \dm_all[2]  = gpio_mode1_core;
  assign vssio_q = \mprj_pads.vssio_q ;
  assign vddio_q = \mprj_pads.vddio_q ;
  assign analog_b = \mprj_pads.analog_b ;
  assign analog_a = \mprj_pads.analog_a ;
  assign mprj_io_in = { \mprj_pads.io_in[37] , \mprj_pads.io_in[36] , \mprj_pads.io_in[35] , \mprj_pads.io_in[34] , \mprj_pads.io_in[33] , \mprj_pads.io_in[32] , \mprj_pads.io_in[31] , \mprj_pads.io_in[30] , \mprj_pads.io_in[29] , \mprj_pads.io_in[28] , \mprj_pads.io_in[27] , \mprj_pads.io_in[26] , \mprj_pads.io_in[25] , \mprj_pads.io_in[24] , \mprj_pads.io_in[23] , \mprj_pads.io_in[22] , \mprj_pads.io_in[21] , \mprj_pads.io_in[20] , \mprj_pads.io_in[19] , \mprj_pads.io_in[18] , \mprj_pads.io_in[17] , \mprj_pads.io_in[16] , \mprj_pads.io_in[15] , \mprj_pads.io_in[14] , \mprj_pads.io_in[13] , \mprj_pads.io_in[12] , \mprj_pads.io_in[11] , \mprj_pads.io_in[10] , \mprj_pads.io_in[9] , \mprj_pads.io_in[8] , \mprj_pads.io_in[7] , \mprj_pads.io_in[6] , \mprj_pads.io_in[5] , \mprj_pads.io_in[4] , \mprj_pads.io_in[3] , \mprj_pads.io_in[2] , \mprj_pads.io_in[1] , \mprj_pads.io_in[0]  };
*/
endmodule
// `default_nettype wire
