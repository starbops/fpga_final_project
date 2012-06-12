`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:10:29 06/12/2012 
// Design Name: 
// Module Name:    show 
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
module show(
    clk,reset,swh,lclk,kdata,
	hsync,vsync,R,G,B
);
    
	input clk,reset,lclk;
	input [1:0] swh;
	input [7:0] kdata;
	output hsync,vsync,R,G,B;
	
	wire visible;
	wire [9:0] row;
	wire [10:0] col;
	
	reg row_inc;
	reg [2:0] RGB_buff;
	reg [9:0] pixel_row;
	reg [10:0] pixel_col;
	
	reg [9:0] center_x;
	reg [10:0] center_y;
	reg [5:0] radius;
	wire [11:0] area;
	
	assign area=radius*radius;
		
	always@(posedge lclk)
	begin
	    if(reset)
		    center_x<=500;
		else
		begin
		    case()
			1'b1:
			    if()
				    center_x <= center_x +1;
				else if()
				    center_x <= center_x -1;
				else
				    center_x <= center_x;
			default:
			    center_x<=center_x;
			endcase
		end
	end
	
	always@(posedge lclk)
	begin
	    if(reset)
		    center_y<=323;
		else
		begin
		    case()
			1'b1:
			    if()
				    center_y<=center_y+1;
				else if()
				    center_y<=center_y-1;
				else
				    center_y<=center_y;
			default:
			    center_y<=center_y;
			endcase
		end
	end
	
	always@(posedge clk)
	begin
	    if(reset)
		    radius<=35;
		else
		    radius<=radius;
	end
	
	always@(posedge clk)
	begin
	    if(reset)
		    RGB_buff<={ 1'b0,1'b0,1'b0 };
		else if( (pixel_col-center_x)*(pixel_col-center_x)+(pixel_row-center_y)*(pixel_row-center_y) < area)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		end
		else
		    RGB_buff<={ 1'b1,1'b1,1'b1 };
	end
	
	assign R = ( visible )? RGB_buff[2] : 0;
	assign G = ( visible )? RGB_buff[1] : 0;
	assign B = ( visible )? RGB_buff[0] : 0;

//===============================================
	
	//---------------//
	//     SCAN      //
	//---------------//
	 
	always@( posedge clk ) begin
		if( reset ) pixel_col <=0;
		else if( pixel_col == 1039 ) pixel_col <= 0;
		else pixel_col <= pixel_col + 1;
	end
	 
	always@( posedge clk ) begin
		if( reset ) row_inc <= 0;
		else if( pixel_col == 1039 ) row_inc <= 1;
		else row_inc <= 0;
	end
	 
	always@( posedge clk )begin
		if( reset ) pixel_row <= 0;
		else if ( pixel_row == 665 ) pixel_row <= 0;
		else if ( row_inc ) pixel_row <= pixel_row + 1;
		else pixel_row <= pixel_row;
    end
	 
	assign hsync = ~( (pixel_col >= 919) & (pixel_col < 1039) );
	assign vsync = ~( (pixel_row >= 659) & (pixel_row < 665) ) ;
	assign visible = ( (pixel_col > 104) & (pixel_col < 904 ) & (pixel_row > 23) & (pixel_row < 623) );

endmodule
