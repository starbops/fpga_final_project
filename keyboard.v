`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:13:00 06/12/2012 
// Design Name: 
// Module Name:    keyboard 
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
module keyboard( clk, reset, KCLK, KDAT, DATA);

input clk,reset;
input KCLK,KDAT;
output [7:0] DATA;

reg [21:0] R;    //receive
reg [3:0] counter;
reg [7:0] DATA;
reg c_state,n_state;


always@(posedge clk or posedge reset)begin
    if(reset)begin
	     c_state <= 1'b0;
		  n_state <= 1'b0;
	 end
	 else begin
	     c_state <= n_state;
		  n_state <= KCLK;
    end
end

always@(posedge clk or posedge reset)begin
    if(reset)
	     R <= 22'b11_00000000_0_11_00000000_0;
	 else begin
	     case({c_state,n_state})
		      2'b10:R <= {KDAT,R[21:1]};
				default:R <= R;
		  endcase
    end
end

always@(posedge clk or posedge reset)begin
    if(reset)
	     counter <= 4'd0;
	 else begin
	     case({c_state,n_state})
		      2'b10:begin
				          if(counter==4'd10)
							     counter <= 4'd0;
							 else
							     counter <= counter + 4'd1;
						end
				default:counter <= counter;
		  endcase
    end
end

wire check=R[1]^R[2]^R[3]^R[4]^R[5]^R[6]^R[7]^R[8]^R[9];

always@(posedge clk or posedge reset)begin
    if(reset)
	     DATA <= 8'd0;
    else if(counter==4'd0&&check==1'b1)begin
	     if(R[8:1]==8'hf0)
		      DATA <= 8'd0;
		  else
		      DATA <= R[19:12];
	 end
	 else
	     DATA <= DATA;
end
endmodule
