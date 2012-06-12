`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:11:03 06/12/2012 
// Design Name: 
// Module Name:    lowclk 
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
module lowclk( 
	output reg o_lclk,
	input clk,
	input [31:0] period,
	input reset
	);

reg [31:0] counter;

always@( posedge clk ) begin
	if( reset ) counter <= 0;
	else if( counter == period ) counter <= 0;
	else counter <= counter + 1;
end

always@( posedge clk ) begin
	if( reset ) o_lclk <= 0;
	else if( counter == period  ) o_lclk <= ~o_lclk;
	else o_lclk <= o_lclk;
end
endmodule
