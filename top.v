`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:48 06/12/2012 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
    CLK,RESET,KCLK,KDAT,
    LED,hsync,vsync,R,G,B
);
   input CLK,RESET;
	input KCLK,KDAT;
	output [7:0] LED;
	output hsync;
	output vsync;
	output R;
	output G;
	output B;

	wire [7:0] KDATA;
	wire lclk;
	wire [31:0] period;
	
	keyboard i_keyboard( .clk(CLK), .reset(RESET), .KCLK(KCLK), .KDAT(KDAT),
	                     .DATA(KDATA));
	lowclk   i_lclk( .clk(CLK), .reset(RESET), .period(period),
	                 .o_lclk(lclk) );
	show     i_show( .clk(CLK), .reset(RESET), .swh(SWH), .lclk(lclk), .kdata(KDATA),
	                 .hsync(hsync), .vsync(vsync), .R(R), .G(G), .B(B) );
	assign LED=0;
	assign period=32'h0000_ffff;
	
endmodule
