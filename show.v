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
    clk,reset,lclk,kdata,
	hsync,vsync,R,G,B
);
    
	input clk,reset,lclk;
	input [7:0] kdata;
	output hsync,vsync,R,G,B;
	
	wire visible;
	wire [9:0] row;
	wire [10:0] col;
	
	reg row_inc;
	reg [2:0] RGB_buff;
	reg [9:0] pixel_row;
	reg [10:0] pixel_col;
	
	reg [9:0] center_xb;
	reg [10:0] center_yb;
	
	reg [9:0] center_xe;
	reg [10:0] center_ye;

	reg [9:0] center_x1;
	reg [10:0] center_y1;

	reg [9:0] center_x2;
	reg [10:0] center_y2;

	reg [9:0] center_x3;
	reg [10:0] center_y3;

	reg [9:0] center_x4;
	reg [10:0] center_y4;

	reg [9:0] center_x5;
	reg [10:0] center_y5;

	reg [9:0] center_x6;
	reg [10:0] center_y6;

	reg [9:0] center_x7;
	reg [10:0] center_y7;

	reg [9:0] center_x8;
	reg [10:0] center_y8;

	reg [9:0] center_x9;
	reg [10:0] center_y9;

	reg [9:0] center_x10;
	reg [10:0] center_y10;

	reg [9:0] center_x11;
	reg [10:0] center_y11;

	reg [9:0] center_x12;
	reg [10:0] center_y12;

	reg [9:0] center_x13;
	reg [10:0] center_y13;

	reg [9:0] center_x14;
	reg [10:0] center_y14;

	reg [9:0] center_x15;
	reg [10:0] center_y15;

	reg [9:0] center_x16;
	reg [10:0] center_y16;

	reg [9:0] center_x17;
	reg [10:0] center_y17;

	reg [9:0] center_x18;
	reg [10:0] center_y18;

	reg [9:0] center_x19;
	reg [10:0] center_y19;

	reg [9:0] center_x20;
	reg [10:0] center_y20;

	reg c1_state,c2_state,c3_state,c4_state,c5_state,c6_state,c7_state,c8_state,c9_state,c10_state,
		c11_state,c12_state,c13_state,c14_state,c15_state,c16_state,c17_state,c18_state,c19_state,c20_state;

	reg b_state;
	reg [1:0] bdx_state;
	reg [1:0] bdy_state;
	reg [2:0] ed_state;

	wire [5:0] b_radius;
	wire [5:0] c_radius;
	wire [11:0] b_area;
	wire [11:0] c_area;
	wire [6:0] distance;
	
	assign b_radius=10;	// Bullet's radius
	assign b_area=b_radius*b_radius;
	assign c_radius=20;	// Emitter & Flyer's radius
	assign c_area=c_radius*c_radius;
	assign distance=b_radius+c_radius;

	always@(posedge lclk) begin
		if(reset) begin
			center_xe<=500;
			center_ye<=500;
		end
		else begin
			center_xe<=500;
			center_ye<=500;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x1<=150;
			center_y1<=150;
		end
		else begin
			center_x1<=150;
			center_y1<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x2<=200;
			center_y2<=150;
		end
		else begin
			center_x2<=200;
			center_y2<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x3<=250;
			center_y3<=150;
		end
		else begin
			center_x3<=250;
			center_y3<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x4<=300;
			center_y4<=150;
		end
		else begin
			center_x4<=300;
			center_y4<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x5<=350;
			center_y5<=150;
		end
		else begin
			center_x5<=350;
			center_y5<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x6<=400;
			center_y6<=150;
		end
		else begin
			center_x6<=400;
			center_y6<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x7<=450;
			center_y7<=150;
		end
		else begin
			center_x7<=450;
			center_y7<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x8<=500;
			center_y8<=150;
		end
		else begin
			center_x8<=500;
			center_y8<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x9<=550;
			center_y9<=150;
		end
		else begin
			center_x9<=550;
			center_y9<=150;
		end
	end
		
	always@(posedge lclk) begin
		if(reset) begin
			center_x10<=600;
			center_y10<=150;
		end
		else begin
			center_x10<=600;
			center_y10<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x11<=650;
			center_y11<=150;
		end
		else begin
			center_x11<=650;
			center_y11<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x12<=700;
			center_y12<=150;
		end
		else begin
			center_x12<=700;
			center_y12<=150;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x13<=150;
			center_y13<=350;
		end
		else begin
			center_x13<=150;
			center_y13<=350;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x14<=200;
			center_y14<=350;
		end
		else begin
			center_x14<=200;
			center_y14<=350;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x15<=250;
			center_y15<=350;
		end
		else begin
			center_x15<=250;
			center_y15<=350;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x16<=300;
			center_y16<=350;
		end
		else begin
			center_x16<=300;
			center_y16<=350;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x17<=350;
			center_y17<=350;
		end
		else begin
			center_x17<=350;
			center_y17<=350;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x18<=400;
			center_y18<=350;
		end
		else begin
			center_x18<=400;
			center_y18<=350;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x19<=450;
			center_y19<=350;
		end
		else begin
			center_x19<=450;
			center_y19<=350;
		end
	end
		
	always@(posedge lclk) begin
		if(reset) begin
			center_x20<=600;
			center_y20<=350;
		end
		else begin
			center_x20<=600;
			center_y20<=350;
		end
	end

	always@(posedge clk) begin
		if(reset) c1_state<=1;
		else if((center_xb-center_x1)*(center_xb-center_x1)+(center_yb-center_y1)*(center_yb-center_y1)==distance)
			c1_state<=0;
		else c1_state<=c1_state;
	end

	always@(posedge clk) begin
		if(reset) c2_state<=1;
		else if((center_xb-center_x2)*(center_xb-center_x2)+(center_yb-center_y2)*(center_yb-center_y2)==distance)
			c2_state<=0;
		else c2_state<=c2_state;
	end

	always@(posedge clk) begin
		if(reset) c3_state<=1;
		else if((center_xb-center_x3)*(center_xb-center_x3)+(center_yb-center_y3)*(center_yb-center_y3)==distance)
			c3_state<=0;
		else c3_state<=c3_state;
	end

	always@(posedge clk) begin
		if(reset) c4_state<=1;
		else if((center_xb-center_x4)*(center_xb-center_x4)+(center_yb-center_y4)*(center_yb-center_y4)==distance)
			c4_state<=0;
		else c4_state<=c4_state;
	end

	always@(posedge clk) begin
		if(reset) c5_state<=1;
		else if((center_xb-center_x5)*(center_xb-center_x5)+(center_yb-center_y5)*(center_yb-center_y5)==distance)
			c5_state<=0;
		else c5_state<=c5_state;
	end

	always@(posedge clk) begin
		if(reset) c6_state<=1;
		else if((center_xb-center_x6)*(center_xb-center_x6)+(center_yb-center_y6)*(center_yb-center_y6)==distance)
			c6_state<=0;
		else c6_state<=c6_state;
	end

	always@(posedge clk) begin
		if(reset) c7_state<=1;
		else if((center_xb-center_x7)*(center_xb-center_x7)+(center_yb-center_y7)*(center_yb-center_y7)==distance)
			c7_state<=0;
		else c7_state<=c7_state;
	end

	always@(posedge clk) begin
		if(reset) c8_state<=1;
		else if((center_xb-center_x8)*(center_xb-center_x8)+(center_yb-center_y8)*(center_yb-center_y8)==distance)
			c8_state<=0;
		else c8_state<=c8_state;
	end

	always@(posedge clk) begin
		if(reset) c9_state<=1;
		else if((center_xb-center_x9)*(center_xb-center_x9)+(center_yb-center_y9)*(center_yb-center_y9)==distance)
			c9_state<=0;
		else c9_state<=c9_state;
	end

	always@(posedge clk) begin
		if(reset) c10_state<=1;
		else if((center_xb-center_x10)*(center_xb-center_x10)+(center_yb-center_y10)*(center_yb-center_y10)==distance)
			c10_state<=0;
		else c10_state<=c10_state;
	end

	always@(posedge clk) begin
		if(reset) c11_state<=1;
		else if((center_xb-center_x11)*(center_xb-center_x11)+(center_yb-center_y11)*(center_yb-center_y11)==distance)
			c11_state<=0;
		else c11_state<=c11_state;
	end

	always@(posedge clk) begin
		if(reset) c12_state<=1;
		else if((center_xb-center_x12)*(center_xb-center_x12)+(center_yb-center_y12)*(center_yb-center_y12)==distance)
			c12_state<=0;
		else c12_state<=c12_state;
	end

	always@(posedge clk) begin
		if(reset) c13_state<=1;
		else if((center_xb-center_x13)*(center_xb-center_x13)+(center_yb-center_y13)*(center_yb-center_y13)==distance)
			c13_state<=0;
		else c13_state<=c13_state;
	end

	always@(posedge clk) begin
		if(reset) c14_state<=1;
		else if((center_xb-center_x14)*(center_xb-center_x14)+(center_yb-center_y14)*(center_yb-center_y14)==distance)
			c14_state<=0;
		else c14_state<=c14_state;
	end

	always@(posedge clk) begin
		if(reset) c15_state<=1;
		else if((center_xb-center_x15)*(center_xb-center_x15)+(center_yb-center_y15)*(center_yb-center_y15)==distance)
			c15_state<=0;
		else c15_state<=c15_state;
	end

	always@(posedge clk) begin
		if(reset) c16_state<=1;
		else if((center_xb-center_x16)*(center_xb-center_x16)+(center_yb-center_y16)*(center_yb-center_y16)==distance)
			c16_state<=0;
		else c16_state<=c16_state;
	end

	always@(posedge clk) begin
		if(reset) c17_state<=1;
		else if((center_xb-center_x17)*(center_xb-center_x17)+(center_yb-center_y17)*(center_yb-center_y17)==distance)
			c17_state<=0;
		else c17_state<=c17_state;
	end

	always@(posedge clk) begin
		if(reset) c18_state<=1;
		else if((center_xb-center_x18)*(center_xb-center_x18)+(center_yb-center_y18)*(center_yb-center_y18)==distance)
			c18_state<=0;
		else c18_state<=c18_state;
	end

	always@(posedge clk) begin
		if(reset) c19_state<=1;
		else if((center_xb-center_x19)*(center_xb-center_x19)+(center_yb-center_y19)*(center_yb-center_y19)==distance)
			c19_state<=0;
		else c19_state<=c19_state;
	end

	always@(posedge clk) begin
		if(reset) c20_state<=1;
		else if((center_xb-center_x20)*(center_xb-center_x20)+(center_yb-center_y20)*(center_yb-center_y20)==distance)
			c20_state<=0;
		else c20_state<=c20_state;
	end

	always@(posedge lclk) begin // Bullet's state(static or moving)
		if(reset) b_state<=0;
		else if(kdata==8'h29) b_state<=1;
		else if(center_yb>623) b_state<=0;
		else b_state<=b_state;
	end

	always@(posedge lclk) begin // Emitter's direction
		if(reset) ed_state<=0; // Zero means up; ed_state has 8 value(3 bits)
		else if(kdata==8'h74) ed_state<=ed_state+1; // 45 degrees clockwise
		else if(kdata==8'h6B) ed_state<=ed_state-1; // 45 degrees counterclockwise
		else ed_state<=ed_state;
	end

	always@(posedge lclk) begin // Bullet's X direction(0: static, 1: right, 2: left)
		if(reset) bdx_state<=0;
		else begin
			case({b_state,ed_state})
				// Static
				4'b0000: bdx_state<=0;
				4'b0001: bdx_state<=1;
				4'b0010: bdx_state<=1;
				4'b0011: bdx_state<=1;
				4'b0100: bdx_state<=0;
				4'b0101: bdx_state<=2;
				4'b0110: bdx_state<=2;
				4'b0111: bdx_state<=2;
				end
				// Moving
				4'b1000: begin
					if(center_xb==104) bdx_state<=1;
					else if(center_xb==904) bdx_state<=2;
					else bdx_state<=bdx_state;
				end
				4'b1001: begin
					if(center_xb==104) bdx_state<=1;
					else if(center_xb==904) bdx_state<=2;
					else bdx_state<=bdx_state;
				end
				4'b1010: begin
					if(center_xb==104) bdx_state<=1;
					else if(center_xb==904) bdx_state<=2;
					else bdx_state<=bdx_state;
				end
				4'b1011: begin
					if(center_xb==104) bdx_state<=1;
					else if(center_xb==904) bdx_state<=2;
					else bdx_state<=bdx_state;
				end
				4'b1100: begin
					if(center_xb==104) bdx_state<=1;
					else if(center_xb==904) bdx_state<=2;
					else bdx_state<=bdx_state;
				end
				4'b1101: begin
					if(center_xb==104) bdx_state<=1;
					else if(center_xb==904) bdx_state<=2;
					else bdx_state<=bdx_state;
				end
				4'b1110: begin
					if(center_xb==104) bdx_state<=1;
					else if(center_xb==904) bdx_state<=2;
					else bdx_state<=bdx_state;
				end
				4'b1111: begin
					if(center_xb==104) bdx_state<=1;
					else if(center_xb==904) bdx_state<=2;
					else bdx_state<=bdx_state;
				end
				default: bdx_state<=bdx_state;
			endcase
		end
	end

	always@(posedge lclk) begin // Bullet's Y direction(0: static, 1: down, 2: up)
		if(reset) bdy_state<=0;
		else begin
			case({b_state,ed_state})
				// Static
				4'b0000: bdy_state<=2;
				4'b0001: bdy_state<=2;
				4'b0010: bdy_state<=0;
				4'b0011: bdy_state<=1;
				4'b0100: bdy_state<=1;
				4'b0101: bdy_state<=1;
				4'b0110: bdy_state<=0;
				4'b0111: bdy_state<=2;
				end
				// Moving
				4'b1000: begin
					if(center_yb==23) bdy_state<=1;
					else if(center_yb==623) bdy_state<=2;
					else bdy_state<=bdy_state;
				end
				4'b1001: begin
					if(center_yb==23) bdy_state<=1;
					else if(center_yb==623) bdy_state<=2;
					else bdy_state<=bdy_state;
				end
				4'b1010: begin
					if(center_yb==23) bdy_state<=1;
					else if(center_yb==623) bdy_state<=2;
					else bdy_state<=bdy_state;
				end
				4'b1011: begin
					if(center_yb==23) bdy_state<=1;
					else if(center_yb==623) bdy_state<=2;
					else bdy_state<=bdy_state;
				end
				4'b1100: begin
					if(center_yb==23) bdy_state<=1;
					else if(center_yb==623) bdy_state<=2;
					else bdy_state<=bdy_state;
				end
				4'b1101: begin
					if(center_yb==23) bdy_state<=1;
					else if(center_yb==623) bdy_state<=2;
					else bdy_state<=bdy_state;
				end
				4'b1110: begin
					if(center_yb==23) bdy_state<=1;
					else if(center_yb==623) bdy_state<=2;
					else bdy_state<=bdy_state;
				end
				4'b1111: begin
					if(center_yb==23) bdy_state<=1;
					else if(center_yb==623) bdy_state<=2;
					else bdy_state<=bdy_state;
				end
				default: bdy_state<=bdy_state;
			endcase
		end
	end

	always@(posedge lclk) begin // Bullet's X
		if(reset)
			center_xb<=500;
		else begin
			case(b_state)
				1'b0: // Bullet is static(at origin)
					center_xb<=500;
				1'b1: // Bullet is moving
					case(bdx_state)
						0: center_xb<=center_xb;
						1: center_xb<=center_xb+1;
						2: center_xb<=center_xb-1;
						default: center_xb<=center_xb;
					endcase
				default: center_xb<=center_xb;
			endcase
		end
	end

	always@(posedge lclk) begin // Bullet's Y
		if(reset)
			center_yb<=500;
		else begin
			case(b_state)
				1'b0: // Bullet is static(at origin)
					center_yb<=500;
				1'b1: // Bullet is moving
					case(bdy_state)
						0: center_yb<=center_yb;
						1: center_yb<=center_yb+1;
						2: center_yb<=center_yb-1;
						default: center_yb<=center_yb;
					endcase
				default: center_yb<=center_yb;
			endcase
		end
	end
	
	always@(posedge clk)
	begin
	    if(reset)
		    RGB_buff<={ 1'b0,1'b0,1'b0 };
		else if( (pixel_col-center_xb)*(pixel_col-center_xb)+(pixel_row-center_yb)*(pixel_row-center_yb) < b_area)
			    RGB_buff<={ 1'b0,1'b0,1'b1 };
		else if( (pixel_col-center_xe)*(pixel_col-center_xe)+(pixel_row-center_ye)*(pixel_row-center_ye) < c_area)
			    RGB_buff<={ 1'b1,1'b0,1'b0 };
		else if( ((pixel_col-center_x1)*(pixel_col-center_x1)+(pixel_row-center_y1)*(pixel_row-center_y1) < c_area)&&c1_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x2)*(pixel_col-center_x2)+(pixel_row-center_y2)*(pixel_row-center_y2) < c_area)&&c2_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x3)*(pixel_col-center_x3)+(pixel_row-center_y3)*(pixel_row-center_y3) < c_area)&&c3_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x4)*(pixel_col-center_x4)+(pixel_row-center_y4)*(pixel_row-center_y4) < c_area)&&c4_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x5)*(pixel_col-center_x5)+(pixel_row-center_y5)*(pixel_row-center_y5) < c_area)&&c5_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x6)*(pixel_col-center_x6)+(pixel_row-center_y6)*(pixel_row-center_y6) < c_area)&&c6_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x7)*(pixel_col-center_x7)+(pixel_row-center_y7)*(pixel_row-center_y7) < c_area)&&c7_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x8)*(pixel_col-center_x8)+(pixel_row-center_y8)*(pixel_row-center_y8) < c_area)&&c8_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x9)*(pixel_col-center_x9)+(pixel_row-center_y9)*(pixel_row-center_y9) < c_area)&&c9_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x10)*(pixel_col-center_x10)+(pixel_row-center_y10)*(pixel_row-center_y10) < c_area)&&c10_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x11)*(pixel_col-center_x11)+(pixel_row-center_y11)*(pixel_row-center_y11) < c_area)&&c11_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x12)*(pixel_col-center_x12)+(pixel_row-center_y12)*(pixel_row-center_y12) < c_area)&&c12_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x13)*(pixel_col-center_x13)+(pixel_row-center_y13)*(pixel_row-center_y13) < c_area)&&c13_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x14)*(pixel_col-center_x14)+(pixel_row-center_y14)*(pixel_row-center_y14) < c_area)&&c14_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x15)*(pixel_col-center_x15)+(pixel_row-center_y15)*(pixel_row-center_y15) < c_area)&&c15_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x16)*(pixel_col-center_x16)+(pixel_row-center_y16)*(pixel_row-center_y16) < c_area)&&c16_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x17)*(pixel_col-center_x17)+(pixel_row-center_y17)*(pixel_row-center_y17) < c_area)&&c17_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x18)*(pixel_col-center_x18)+(pixel_row-center_y18)*(pixel_row-center_y18) < c_area)&&c18_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x19)*(pixel_col-center_x19)+(pixel_row-center_y19)*(pixel_row-center_y19) < c_area)&&c19_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
		else if( ((pixel_col-center_x20)*(pixel_col-center_x20)+(pixel_row-center_y20)*(pixel_row-center_y20) < c_area)&&c20_state==1)
			    RGB_buff<={ 1'b1,1'b1,1'b0 };
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
