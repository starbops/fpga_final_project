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
	wire [9:0] m_row;
	wire [10:0] m_col;
	wire [9:0] b_row;
	wire [10:0] b_col;
	wire [9:0] gg_row;
	wire [10:0] gg_col;

	
	wire word,word_region,marker,marker_region,bullets,bullets_region,gg,gg_region;
	
	reg row_inc;
	reg [2:0] RGB_buff;
	reg [9:0] pixel_row;
	reg [10:0] pixel_col;
	
	reg [9:0] center_xg;
	reg [10:0] center_yg;
	
	reg [9:0] center_xm;
	reg [10:0] center_ym;
	
	reg [9:0] center_xb;
	reg [10:0] center_yb;
	
	reg [9:0] center_xbc;
	reg [10:0] center_ybc;
	
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
	reg c1tmp_state,c2tmp_state,c3tmp_state,c4tmp_state,c5tmp_state,c6tmp_state,c7tmp_state,c8tmp_state,c9tmp_state,c10tmp_state,
		c11tmp_state,c12tmp_state,c13tmp_state,c14tmp_state,c15tmp_state,c16tmp_state,c17tmp_state,c18tmp_state,c19tmp_state,c20tmp_state;

	reg b_state;
	reg [1:0] bdx_state;
	reg [1:0] bdy_state;
	reg [2:0] ed_state;

	wire [5:0] b_radius;
	wire [5:0] c_radius;
	wire [11:0] b_area;
	wire [11:0] c_area;
	
	reg k1c_state,k2c_state,kctmp_state,k1cc_state,k2cc_state,kcctmp_state,b2_state,btmp_state;
	
	reg [4:0] counter;
	reg [2:0] b_counter;
	
	assign col=pixel_col-337;
	assign row=pixel_row-164;
	assign m_col=pixel_col-center_xm;
	assign m_row=pixel_row-center_ym;
	assign b_col=pixel_col-center_xbc;
	assign b_row=pixel_row-center_ybc;
	assign gg_col=pixel_col-center_xg;
	assign gg_row=pixel_row-center_yg;
	
	WORD word_1(.word(word), .pic_cnt(ed_state), .row(row[6:3]), .col(col[6:3]), .reset(reset));
	MARKER marker_1(.word(marker), .pic_cnt(counter), .row(m_row[6:3]), .col(m_col[6:3]), .reset(reset));
	BULLETS bullets_1(.word(bullets), .pic_cnt(b_counter), .row(b_row[6:3]), .col(b_col[6:3]), .reset(reset));
	GG gg_1(.word(gg), .pic_cnt(0), .row(gg_row[6:3]), .col(gg_col[6:3]), .reset(reset));
	
	assign word_region = (pixel_col >= center_xe - 64) & (pixel_col < center_xe + 64) & (pixel_row >= center_ye - 64) & (pixel_row < center_ye + 64);
	assign marker_region = (pixel_col >= center_xm) & (pixel_col < center_xm + 128) & (pixel_row >= center_ym) & (pixel_row < center_ym + 128);
	assign bullets_region = (pixel_col >= center_xbc) & (pixel_col < center_xbc + 128) & (pixel_row >= center_ybc) & (pixel_row < center_ybc + 128);
	assign gg_region = (pixel_col >= center_xg) & (pixel_col < center_xg + 128) & (pixel_row >= center_yg) & (pixel_row < center_yg + 128);
	
	assign b_radius=5;	// Bullet's radius
	assign b_area=b_radius*b_radius;
	assign c_radius=20;	// Emitter & Flyer's radius
	assign c_area=c_radius*c_radius;
		
	always@(posedge lclk) begin
		if(reset) begin
			center_xg<=400;
			center_yg<=400;
		end
		else begin
			center_xg<=400;
			center_yg<=400;
		end
	end
	
	always@(posedge lclk) begin
		if(reset) begin
			center_xbc<=600;
			center_ybc<=300;
		end
		else begin
			center_xbc<=600;
			center_ybc<=300;
		end
	end
	
	always@(posedge lclk) begin
		if(reset) begin
			center_xm<=700;
			center_ym<=500;
		end
		else begin
			center_xm<=700;
			center_ym<=500;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_xe<=400;
			center_ye<=225;
		end
		else begin
			center_xe<=400;
			center_ye<=225;
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
			center_y7<=500;
		end
		else begin
			center_x7<=450;
			center_y7<=500;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x8<=510;
			center_y8<=120;
		end
		else begin
			center_x8<=510;
			center_y8<=120;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x9<=550;
			center_y9<=200;
		end
		else begin
			center_x9<=550;
			center_y9<=200;
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
			center_x11<=300;
			center_y11<=225;
		end
		else begin
			center_x11<=300;
			center_y11<=225;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x12<=500;
			center_y12<=260;
		end
		else begin
			center_x12<=500;
			center_y12<=260;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x13<=150;
			center_y13<=600;
		end
		else begin
			center_x13<=150;
			center_y13<=600;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x14<=200;
			center_y14<=400;
		end
		else begin
			center_x14<=200;
			center_y14<=400;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x15<=230;
			center_y15<=380;
		end
		else begin
			center_x15<=230;
			center_y15<=380;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x16<=300;
			center_y16<=450;
		end
		else begin
			center_x16<=300;
			center_y16<=450;
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
			center_y18<=450;
		end
		else begin
			center_x18<=400;
			center_y18<=450;
		end
	end

	always@(posedge lclk) begin
		if(reset) begin
			center_x19<=435;
			center_y19<=320;
		end
		else begin
			center_x19<=435;
			center_y19<=320;
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

	always@(posedge lclk) begin
		if(reset) c1_state<=1;
		else if((center_xb<center_x1+c_radius)&&(center_xb>center_x1-c_radius)&&(center_yb<center_y1+c_radius)&&(center_yb>center_y1-c_radius))
			c1_state<=0;
		else c1_state<=c1_state;
	end

	always@(posedge lclk) begin
		if(reset) c2_state<=1;
		else if((center_xb<center_x2+c_radius)&&(center_xb>center_x2-c_radius)&&(center_yb<center_y2+c_radius)&&(center_yb>center_y2-c_radius))
			c2_state<=0;
		else c2_state<=c2_state;
	end

	always@(posedge lclk) begin
		if(reset) c3_state<=1;
		else if((center_xb<center_x3+c_radius)&&(center_xb>center_x3-c_radius)&&(center_yb<center_y3+c_radius)&&(center_yb>center_y3-c_radius))
			c3_state<=0;
		else c3_state<=c3_state;
	end

	always@(posedge lclk) begin
		if(reset) c4_state<=1;
		else if((center_xb<center_x4+c_radius)&&(center_xb>center_x4-c_radius)&&(center_yb<center_y4+c_radius)&&(center_yb>center_y4-c_radius))
			c4_state<=0;
		else c4_state<=c4_state;
	end

	always@(posedge lclk) begin
		if(reset) c5_state<=1;
		else if((center_xb<center_x5+c_radius)&&(center_xb>center_x5-c_radius)&&(center_yb<center_y5+c_radius)&&(center_yb>center_y5-c_radius))
			c5_state<=0;
		else c5_state<=c5_state;
	end

	always@(posedge lclk) begin
		if(reset) c6_state<=1;
		else if((center_xb<center_x6+c_radius)&&(center_xb>center_x6-c_radius)&&(center_yb<center_y6+c_radius)&&(center_yb>center_y6-c_radius))
			c6_state<=0;
		else c6_state<=c6_state;
	end

	always@(posedge lclk) begin
		if(reset) c7_state<=1;
		else if((center_xb<center_x7+c_radius)&&(center_xb>center_x7-c_radius)&&(center_yb<center_y7+c_radius)&&(center_yb>center_y7-c_radius))
			c7_state<=0;
		else c7_state<=c7_state;
	end

	always@(posedge lclk) begin
		if(reset) c8_state<=1;
		else if((center_xb<center_x8+c_radius)&&(center_xb>center_x8-c_radius)&&(center_yb<center_y8+c_radius)&&(center_yb>center_y8-c_radius))
			c8_state<=0;
		else c8_state<=c8_state;
	end

	always@(posedge lclk) begin
		if(reset) c9_state<=1;
		else if((center_xb<center_x9+c_radius)&&(center_xb>center_x9-c_radius)&&(center_yb<center_y9+c_radius)&&(center_yb>center_y9-c_radius))
			c9_state<=0;
		else c9_state<=c9_state;
	end

	always@(posedge lclk) begin
		if(reset) c10_state<=1;
		else if((center_xb<center_x10+c_radius)&&(center_xb>center_x10-c_radius)&&(center_yb<center_y10+c_radius)&&(center_yb>center_y10-c_radius))
			c10_state<=0;
		else c10_state<=c10_state;
	end

	always@(posedge lclk) begin
		if(reset) c11_state<=1;
		else if((center_xb<center_x11+c_radius)&&(center_xb>center_x11-c_radius)&&(center_yb<center_y11+c_radius)&&(center_yb>center_y11-c_radius))
			c11_state<=0;
		else c11_state<=c11_state;
	end

	always@(posedge lclk) begin
		if(reset) c12_state<=1;
		else if((center_xb<center_x12+c_radius)&&(center_xb>center_x12-c_radius)&&(center_yb<center_y12+c_radius)&&(center_yb>center_y12-c_radius))
			c12_state<=0;
		else c12_state<=c12_state;
	end

	always@(posedge lclk) begin
		if(reset) c13_state<=1;
		else if((center_xb<center_x13+c_radius)&&(center_xb>center_x13-c_radius)&&(center_yb<center_y13+c_radius)&&(center_yb>center_y13-c_radius))
			c13_state<=0;
		else c13_state<=c13_state;
	end

	always@(posedge lclk) begin
		if(reset) c14_state<=1;
		else if((center_xb<center_x14+c_radius)&&(center_xb>center_x14-c_radius)&&(center_yb<center_y14+c_radius)&&(center_yb>center_y14-c_radius))
			c14_state<=0;
		else c14_state<=c14_state;
	end

	always@(posedge lclk) begin
		if(reset) c15_state<=1;
		else if((center_xb<center_x15+c_radius)&&(center_xb>center_x15-c_radius)&&(center_yb<center_y15+c_radius)&&(center_yb>center_y15-c_radius))
			c15_state<=0;
		else c15_state<=c15_state;
	end

	always@(posedge lclk) begin
		if(reset) c16_state<=1;
		else if((center_xb<center_x16+c_radius)&&(center_xb>center_x16-c_radius)&&(center_yb<center_y16+c_radius)&&(center_yb>center_y16-c_radius))
			c16_state<=0;
		else c16_state<=c16_state;
	end

	always@(posedge lclk) begin
		if(reset) c17_state<=1;
		else if((center_xb<center_x17+c_radius)&&(center_xb>center_x17-c_radius)&&(center_yb<center_y17+c_radius)&&(center_yb>center_y17-c_radius))
			c17_state<=0;
		else c17_state<=c17_state;
	end

	always@(posedge lclk) begin
		if(reset) c18_state<=1;
		else if((center_xb<center_x18+c_radius)&&(center_xb>center_x18-c_radius)&&(center_yb<center_y18+c_radius)&&(center_yb>center_y18-c_radius))
			c18_state<=0;
		else c18_state<=c18_state;
	end

	always@(posedge lclk) begin
		if(reset) c19_state<=1;
		else if((center_xb<center_x19+c_radius)&&(center_xb>center_x19-c_radius)&&(center_yb<center_y19+c_radius)&&(center_yb>center_y19-c_radius))
			c19_state<=0;
		else c19_state<=c19_state;
	end

	always@(posedge lclk) begin
		if(reset) c20_state<=1;
		else if((center_xb<center_x20+c_radius)&&(center_xb>center_x20-c_radius)&&(center_yb<center_y20+c_radius)&&(center_yb>center_y20-c_radius))
			c20_state<=0;
		else c20_state<=c20_state;
	end
	
	always@(posedge clk) begin
		if(reset) begin
			c1tmp_state<=c1_state;
			c2tmp_state<=c2_state;
			c3tmp_state<=c3_state;
			c4tmp_state<=c4_state;
			c5tmp_state<=c5_state;
			c6tmp_state<=c6_state;
			c7tmp_state<=c7_state;
			c8tmp_state<=c8_state;
			c9tmp_state<=c9_state;
			c10tmp_state<=c10_state;
			c11tmp_state<=c11_state;
			c12tmp_state<=c12_state;
			c13tmp_state<=c13_state;
			c14tmp_state<=c14_state;
			c15tmp_state<=c15_state;
			c16tmp_state<=c16_state;
			c17tmp_state<=c17_state;
			c18tmp_state<=c18_state;
			c19tmp_state<=c19_state;
			c20tmp_state<=c20_state;
		end
		else begin
			c1tmp_state<=c1_state;
			c2tmp_state<=c2_state;
			c3tmp_state<=c3_state;
			c4tmp_state<=c4_state;
			c5tmp_state<=c5_state;
			c6tmp_state<=c6_state;
			c7tmp_state<=c7_state;
			c8tmp_state<=c8_state;
			c9tmp_state<=c9_state;
			c10tmp_state<=c10_state;
			c11tmp_state<=c11_state;
			c12tmp_state<=c12_state;
			c13tmp_state<=c13_state;
			c14tmp_state<=c14_state;
			c15tmp_state<=c15_state;
			c16tmp_state<=c16_state;
			c17tmp_state<=c17_state;
			c18tmp_state<=c18_state;
			c19tmp_state<=c19_state;
			c20tmp_state<=c20_state;
		end
	end
	
	always@(posedge clk) begin
		if(reset) counter<=0;
		else if(c1tmp_state==1&&c1_state==0) counter<=counter+1;
		else if(c2tmp_state==1&&c2_state==0) counter<=counter+1;
		else if(c3tmp_state==1&&c3_state==0) counter<=counter+1;
		else if(c4tmp_state==1&&c4_state==0) counter<=counter+1;
		else if(c5tmp_state==1&&c5_state==0) counter<=counter+1;
		else if(c6tmp_state==1&&c6_state==0) counter<=counter+1;
		else if(c7tmp_state==1&&c7_state==0) counter<=counter+1;
		else if(c8tmp_state==1&&c8_state==0) counter<=counter+1;
		else if(c9tmp_state==1&&c9_state==0) counter<=counter+1;
		else if(c10tmp_state==1&&c10_state==0) counter<=counter+1;
		else if(c11tmp_state==1&&c11_state==0) counter<=counter+1;
		else if(c12tmp_state==1&&c12_state==0) counter<=counter+1;
		else if(c13tmp_state==1&&c13_state==0) counter<=counter+1;
		else if(c14tmp_state==1&&c14_state==0) counter<=counter+1;
		else if(c15tmp_state==1&&c15_state==0) counter<=counter+1;
		else if(c16tmp_state==1&&c16_state==0) counter<=counter+1;
		else if(c17tmp_state==1&&c17_state==0) counter<=counter+1;
		else if(c18tmp_state==1&&c18_state==0) counter<=counter+1;
		else if(c19tmp_state==1&&c19_state==0) counter<=counter+1;
		else if(c20tmp_state==1&&c20_state==0) counter<=counter+1;
		else counter<=counter;
	end

	always@(posedge lclk) begin // Bullet's state(static or moving)
		if(reset) b_state<=0;
		else if(b_counter==0) b_state<=0;
		else if(kdata==8'h29) b_state<=1;
		else if(kdata==8'h15||center_yb>623) b_state<=0;
		else b_state<=b_state;
	end
	
	always@(posedge lclk) begin
		if(reset) btmp_state<=b_state;
		else btmp_state<=b_state;
	end
	
	always@(posedge lclk) begin
		if(reset) b2_state<=0;
		else begin
			case({btmp_state,b_state})
				2'b00: b2_state<=0;
				2'b01: b2_state<=0;
				2'b10: b2_state<=1;
				2'b11: b2_state<=0;
				default: b2_state<=0;
			endcase
		end
	end
		
	always@(posedge lclk) begin // How many bullets does the player have?
		if(reset) b_counter<=6;
		//else if(b_counter==0) b_counter<=7;
		else if(b2_state==1) begin
			case(b_counter)
				0: b_counter<=7;
				1: b_counter<=0;
				2: b_counter<=1;
				3: b_counter<=2;
				4: b_counter<=3;
				5: b_counter<=4;
				6: b_counter<=5;
				7: b_counter<=6;
				default: b_counter<=b_counter;
			endcase
		end
		else b_counter<=b_counter;
	end
	
	always@(posedge clk) begin // Keyboard clockwise
		if(reset) k1c_state<=0;
		else begin
			case(kdata)
				8'h74: k1c_state<=1;
				default: k1c_state<=0;
			endcase
		end
	end
		
	always@(posedge clk) begin // Keyboard counterclockwise
		if(reset) k1cc_state<=0;
		else begin
			case(kdata)
				8'h6B: k1cc_state<=1;
				default: k1cc_state<=0;
			endcase
		end
	end
	
	always@(posedge clk) begin // Last state of keyboard clockwise
		if(reset) kctmp_state<=k1c_state;
		else kctmp_state<=k1c_state;
	end
		
	always@(posedge clk) begin // Last state of keyboard counterclockwise
		if(reset) kcctmp_state<=k1cc_state;
		else kcctmp_state<=k1cc_state;
	end
	
	always@(posedge clk) begin
		if(reset) k2c_state<=0;
		else begin
			case({kctmp_state,k1c_state})
				2'b00: k2c_state<=0;
				2'b01: k2c_state<=0;
				2'b10: k2c_state<=1;
				2'b11: k2c_state<=0;
				default: k2c_state<=0;
			endcase
		end
	end
		
	always@(posedge clk) begin
		if(reset) k2cc_state<=0;
		else begin
			case({kcctmp_state,k1cc_state})
				2'b00: k2cc_state<=0;
				2'b01: k2cc_state<=0;
				2'b10: k2cc_state<=1;
				2'b11: k2cc_state<=0;
				default: k2cc_state<=0;
			endcase
		end
	end

	always@(posedge clk) begin // Emitter's direction
		if(reset) ed_state<=0; // Zero means up; ed_state has 8 value(3 bits)
		else if(k2c_state==1&&b_counter!=0) begin // 45 degrees clockwise
			case(ed_state)
				0: ed_state<=1;
				1: ed_state<=2;
				2: ed_state<=3;
				3: ed_state<=4;
				4: ed_state<=5;
				5: ed_state<=6;
				6: ed_state<=7;
				7: ed_state<=0;
				default: ed_state<=ed_state;
			endcase
		end
		else if(k2cc_state==1&&b_counter!=0) begin // 45 degrees counterclockwise
			case(ed_state)
				0: ed_state<=7;
				1: ed_state<=0;
				2: ed_state<=1;
				3: ed_state<=2;
				4: ed_state<=3;
				5: ed_state<=4;
				6: ed_state<=5;
				7: ed_state<=6;
				default: ed_state<=ed_state;
			endcase
		end
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
			center_xb<=400;
		else begin
			case(b_state)
				1'b0: // Bullet is static(at origin)
					center_xb<=400;
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
			center_yb<=225;
		else begin
			case(b_state)
				1'b0: // Bullet is static(at origin)
					center_yb<=225;
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
		else if((gg_region&gg)&&b_counter==0) RGB_buff<={ 1'b1, 1'b1, 1'b1 };
		else if(bullets_region&bullets) RGB_buff<={ 1'b0, 1'b0, 1'b1 };
		else if(marker_region&marker) RGB_buff<={ 1'b0, 1'b1, 1'b0 };
		else if( (pixel_col-center_xb)*(pixel_col-center_xb)+(pixel_row-center_yb)*(pixel_row-center_yb) < b_area)
			    RGB_buff<={ 1'b0,1'b0,1'b1 };
		else if(word_region&word) RGB_buff<={ 1'b0, 1'b1, 1'b1 };
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
		    RGB_buff<={ 1'b0,1'b0,1'b0 };
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

module WORD(
  //output
  word,
  //input
  pic_cnt, row, col, reset);
input [3:0] row;
input [3:0] col;
input [5:0] pic_cnt;
input reset ;
output word;
reg word;
reg [15:0] line_a,
		   line_b,
		   line_c,
		   line_d,
		   line_e,
		   line_f,
		   line_g,
		   line_h, 
		  
		   line_i,
		   line_j,
		   line_k,
		   line_l,
		   line_m,
		   line_n,
		   line_o,
		   line_p;

always@( pic_cnt )begin
    case( pic_cnt )
		0: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0000000110000000;
			line_f <= 16'b0000001111000000;
			line_g <= 16'b0000000110000000;
			line_h <= 16'b0000000110000000;
			line_i <= 16'b0000000110000000;
			line_j <= 16'b0000000110000000;
			line_k <= 16'b0000000110000000;
			line_l <= 16'b0000000110000000;
			line_m <= 16'b0000000000000000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		1: begin
                        line_a <= 16'b0000000000000000;
                        line_b <= 16'b0000000000000000;
                        line_c <= 16'b0000000000000000;
                        line_d <= 16'b0000000000000000;
                        line_e <= 16'b0000000011110000;
                        line_f <= 16'b0000000001110000;
                        line_g <= 16'b0000000011010000;
                        line_h <= 16'b0000000110000000;
                        line_i <= 16'b0000001100000000;
                        line_j <= 16'b0000011000000000;
                        line_k <= 16'b0000110000000000;
                        line_l <= 16'b0001100000000000;
                        line_m <= 16'b0000000000000000;
                        line_n <= 16'b0000000000000000;
                        line_o <= 16'b0000000000000000;
                        line_p <= 16'b0000000000000000;

		end
		2: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0000000000000000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000100000;
			line_h <= 16'b0000111111110000;
			line_i <= 16'b0000111111110000;
			line_j <= 16'b0000000000100000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0000000000000000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		3: begin
                        line_a <= 16'b0000000000000000;
                        line_b <= 16'b0000000000000000;
                        line_c <= 16'b0000000000000000;
                        line_d <= 16'b0000000000000000;
                        line_e <= 16'b0000110000000000;
                        line_f <= 16'b0000011000000000;
                        line_g <= 16'b0000001100000000;
                        line_h <= 16'b0000000110000000;
                        line_i <= 16'b0000000011000000;
                        line_j <= 16'b0000000001101000;
                        line_k <= 16'b0000000000111000;
                        line_l <= 16'b0000000001111000;
                        line_m <= 16'b0000000000000000;
                        line_n <= 16'b0000000000000000;
                        line_o <= 16'b0000000000000000;
                        line_p <= 16'b0000000000000000;
		end
		4: begin
                        line_a <= 16'b0000000000000000;
                        line_b <= 16'b0000000000000000;
                        line_c <= 16'b0000000000000000;
                        line_d <= 16'b0000000000000000;
                        line_e <= 16'b0000000110000000;
                        line_f <= 16'b0000000110000000;
                        line_g <= 16'b0000000110000000;
                        line_h <= 16'b0000000110000000;
                        line_i <= 16'b0000000110000000;
                        line_j <= 16'b0000000110000000;
                        line_k <= 16'b0000001111000000;
                        line_l <= 16'b0000000110000000;
                        line_m <= 16'b0000000000000000;
                        line_n <= 16'b0000000000000000;
                        line_o <= 16'b0000000000000000;
                        line_p <= 16'b0000000000000000;

		end
		5: begin
                        line_a <= 16'b0000000000000000;
                        line_b <= 16'b0000000000000000;
                        line_c <= 16'b0000000000000000;
                        line_d <= 16'b0000000000000000;
                        line_e <= 16'b0000000000110000;
                        line_f <= 16'b0000000001100000;
                        line_g <= 16'b0000000011000000;
                        line_h <= 16'b0000000110000000;
                        line_i <= 16'b0000001100000000;
                        line_j <= 16'b0001011000000000;
                        line_k <= 16'b0001110000000000;
                        line_l <= 16'b0001111000000000;
                        line_m <= 16'b0000000000000000;
                        line_n <= 16'b0000000000000000;
                        line_o <= 16'b0000000000000000;
                        line_p <= 16'b0000000000000000;

		end
		6: begin
                        line_a <= 16'b0000000000000000;
                        line_b <= 16'b0000000000000000;
                        line_c <= 16'b0000000000000000;
                        line_d <= 16'b0000000000000000;
                        line_e <= 16'b0000000000000000;
                        line_f <= 16'b0000000000000000;
                        line_g <= 16'b0000010000000000;
                        line_h <= 16'b0000111111110000;
                        line_i <= 16'b0000111111110000;
                        line_j <= 16'b0000010000000000;
                        line_k <= 16'b0000000000000000;
                        line_l <= 16'b0000000000000000;
                        line_m <= 16'b0000000000000000;
                        line_n <= 16'b0000000000000000;
                        line_o <= 16'b0000000000000000;
                        line_p <= 16'b0000000000000000;

		end
		7: begin
                        line_a <= 16'b0000000000000000;
                        line_b <= 16'b0000000000000000;
                        line_c <= 16'b0000000000000000;
                        line_d <= 16'b0000000000000000;
                        line_e <= 16'b0000111100000000;
                        line_f <= 16'b0000111000000000;
                        line_g <= 16'b0000101100000000;
                        line_h <= 16'b0000000110000000;
                        line_i <= 16'b0000000011000000;
                        line_j <= 16'b0000000001100000;
                        line_k <= 16'b0000000000110000;
                        line_l <= 16'b0000000000011000;
                        line_m <= 16'b0000000000000000;
                        line_n <= 16'b0000000000000000;
                        line_o <= 16'b0000000000000000;
                        line_p <= 16'b0000000000000000;

		end
		default: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0000000000000000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0000000000000000;
			line_i <= 16'b0000000000000000;
			line_j <= 16'b0000000000000000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0000000000000000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
	endcase
end

always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or line_g or
		  line_h or  line_i or  line_j or line_k or line_l or line_m or line_n or  line_o or line_p) begin
		  
	case({row,col})
		8'b0000_0000: word <= line_a[15];
		8'b0000_0001: word <= line_a[14];
		8'b0000_0010: word <= line_a[13];
		8'b0000_0011: word <= line_a[12];
		8'b0000_0100: word <= line_a[11];
		8'b0000_0101: word <= line_a[10];
		8'b0000_0110: word <= line_a[9];
		8'b0000_0111: word <= line_a[8];
		8'b0000_1000: word <= line_a[7];
		8'b0000_1001: word <= line_a[6];
		8'b0000_1010: word <= line_a[5];
		8'b0000_1011: word <= line_a[4];
		8'b0000_1100: word <= line_a[3];
		8'b0000_1101: word <= line_a[2];
		8'b0000_1110: word <= line_a[1];
		8'b0000_1111: word <= line_a[0];

		8'b0001_0000: word <= line_b[15];
		8'b0001_0001: word <= line_b[14];
		8'b0001_0010: word <= line_b[13];
		8'b0001_0011: word <= line_b[12];
		8'b0001_0100: word <= line_b[11];
		8'b0001_0101: word <= line_b[10];
		8'b0001_0110: word <= line_b[9];
		8'b0001_0111: word <= line_b[8];
		8'b0001_1000: word <= line_b[7];
		8'b0001_1001: word <= line_b[6];
		8'b0001_1010: word <= line_b[5];
		8'b0001_1011: word <= line_b[4];
		8'b0001_1100: word <= line_b[3];
		8'b0001_1101: word <= line_b[2];
		8'b0001_1110: word <= line_b[1];
		8'b0001_1111: word <= line_b[0];	

		8'b0010_0000: word <= line_c[15];
		8'b0010_0001: word <= line_c[14];
		8'b0010_0010: word <= line_c[13];
		8'b0010_0011: word <= line_c[12];
		8'b0010_0100: word <= line_c[11];
		8'b0010_0101: word <= line_c[10];
		8'b0010_0110: word <= line_c[9];
		8'b0010_0111: word <= line_c[8];
		8'b0010_1000: word <= line_c[7];
		8'b0010_1001: word <= line_c[6];
		8'b0010_1010: word <= line_c[5];
		8'b0010_1011: word <= line_c[4];
		8'b0010_1100: word <= line_c[3];
		8'b0010_1101: word <= line_c[2];
		8'b0010_1110: word <= line_c[1];
		8'b0010_1111: word <= line_c[0];

		8'b0011_0000: word <= line_d[15];
		8'b0011_0001: word <= line_d[14];
		8'b0011_0010: word <= line_d[13];
		8'b0011_0011: word <= line_d[12];
		8'b0011_0100: word <= line_d[11];
		8'b0011_0101: word <= line_d[10];
		8'b0011_0110: word <= line_d[9];
		8'b0011_0111: word <= line_d[8];
		8'b0011_1000: word <= line_d[7];
		8'b0011_1001: word <= line_d[6];
		8'b0011_1010: word <= line_d[5];
		8'b0011_1011: word <= line_d[4];
		8'b0011_1100: word <= line_d[3];
		8'b0011_1101: word <= line_d[2];
		8'b0011_1110: word <= line_d[1];
		8'b0011_1111: word <= line_d[0];

		8'b0100_0000: word <= line_e[15];
		8'b0100_0001: word <= line_e[14];
		8'b0100_0010: word <= line_e[13];
		8'b0100_0011: word <= line_e[12];
		8'b0100_0100: word <= line_e[11];
		8'b0100_0101: word <= line_e[10];
		8'b0100_0110: word <= line_e[9];
		8'b0100_0111: word <= line_e[8];
		8'b0100_1000: word <= line_e[7];
		8'b0100_1001: word <= line_e[6];
		8'b0100_1010: word <= line_e[5];
		8'b0100_1011: word <= line_e[4];
		8'b0100_1100: word <= line_e[3];
		8'b0100_1101: word <= line_e[2];
		8'b0100_1110: word <= line_e[1];
		8'b0100_1111: word <= line_e[0];

		8'b0101_0000: word <= line_f[15];
		8'b0101_0001: word <= line_f[14];
		8'b0101_0010: word <= line_f[13];
		8'b0101_0011: word <= line_f[12];
		8'b0101_0100: word <= line_f[11];
		8'b0101_0101: word <= line_f[10];
		8'b0101_0110: word <= line_f[9];
		8'b0101_0111: word <= line_f[8];
		8'b0101_1000: word <= line_f[7];
		8'b0101_1001: word <= line_f[6];
		8'b0101_1010: word <= line_f[5];
		8'b0101_1011: word <= line_f[4];
		8'b0101_1100: word <= line_f[3];
		8'b0101_1101: word <= line_f[2];
		8'b0101_1110: word <= line_f[1];
		8'b0101_1111: word <= line_f[0];

		8'b0110_0000: word <= line_g[15];
		8'b0110_0001: word <= line_g[14];
		8'b0110_0010: word <= line_g[13];
		8'b0110_0011: word <= line_g[12];
		8'b0110_0100: word <= line_g[11];
		8'b0110_0101: word <= line_g[10];
		8'b0110_0110: word <= line_g[9];
		8'b0110_0111: word <= line_g[8];
		8'b0110_1000: word <= line_g[7];
		8'b0110_1001: word <= line_g[6];
		8'b0110_1010: word <= line_g[5];
		8'b0110_1011: word <= line_g[4];
		8'b0110_1100: word <= line_g[3];
		8'b0110_1101: word <= line_g[2];
		8'b0110_1110: word <= line_g[1];
		8'b0110_1111: word <= line_g[0];

		8'b0111_0000: word <= line_h[15];
		8'b0111_0001: word <= line_h[14];
		8'b0111_0010: word <= line_h[13];
		8'b0111_0011: word <= line_h[12];
		8'b0111_0100: word <= line_h[11];
		8'b0111_0101: word <= line_h[10];
		8'b0111_0110: word <= line_h[9];
		8'b0111_0111: word <= line_h[8];
		8'b0111_1000: word <= line_h[7];
		8'b0111_1001: word <= line_h[6];
		8'b0111_1010: word <= line_h[5];
		8'b0111_1011: word <= line_h[4];
		8'b0111_1100: word <= line_h[3];
		8'b0111_1101: word <= line_h[2];
		8'b0111_1110: word <= line_h[1];
		8'b0111_1111: word <= line_h[0];

		8'b1000_0000: word <= line_i[15];
		8'b1000_0001: word <= line_i[14];
		8'b1000_0010: word <= line_i[13];
		8'b1000_0011: word <= line_i[12];
		8'b1000_0100: word <= line_i[11];
		8'b1000_0101: word <= line_i[10];
		8'b1000_0110: word <= line_i[9];
		8'b1000_0111: word <= line_i[8];
		8'b1000_1000: word <= line_i[7];
		8'b1000_1001: word <= line_i[6];
		8'b1000_1010: word <= line_i[5];
		8'b1000_1011: word <= line_i[4];
		8'b1000_1100: word <= line_i[3];
		8'b1000_1101: word <= line_i[2];
		8'b1000_1110: word <= line_i[1];
		8'b1000_1111: word <= line_i[0];

		8'b1001_0000: word <= line_j[15];
		8'b1001_0001: word <= line_j[14];
		8'b1001_0010: word <= line_j[13];
		8'b1001_0011: word <= line_j[12];
		8'b1001_0100: word <= line_j[11];
		8'b1001_0101: word <= line_j[10];
		8'b1001_0110: word <= line_j[9];
		8'b1001_0111: word <= line_j[8];
		8'b1001_1000: word <= line_j[7];
		8'b1001_1001: word <= line_j[6];
		8'b1001_1010: word <= line_j[5];
		8'b1001_1011: word <= line_j[4];
		8'b1001_1100: word <= line_j[3];
		8'b1001_1101: word <= line_j[2];
		8'b1001_1110: word <= line_j[1];
		8'b1001_1111: word <= line_j[0];	

		8'b1010_0000: word <= line_k[15];
		8'b1010_0001: word <= line_k[14];
		8'b1010_0010: word <= line_k[13];
		8'b1010_0011: word <= line_k[12];
		8'b1010_0100: word <= line_k[11];
		8'b1010_0101: word <= line_k[10];
		8'b1010_0110: word <= line_k[9];
		8'b1010_0111: word <= line_k[8];
		8'b1010_1000: word <= line_k[7];
		8'b1010_1001: word <= line_k[6];
		8'b1010_1010: word <= line_k[5];
		8'b1010_1011: word <= line_k[4];
		8'b1010_1100: word <= line_k[3];
		8'b1010_1101: word <= line_k[2];
		8'b1010_1110: word <= line_k[1];
		8'b1010_1111: word <= line_k[0];

		8'b1011_0000: word <= line_l[15];
		8'b1011_0001: word <= line_l[14];
		8'b1011_0010: word <= line_l[13];
		8'b1011_0011: word <= line_l[12];
		8'b1011_0100: word <= line_l[11];
		8'b1011_0101: word <= line_l[10];
		8'b1011_0110: word <= line_l[9];
		8'b1011_0111: word <= line_l[8];
		8'b1011_1000: word <= line_l[7];
		8'b1011_1001: word <= line_l[6];
		8'b1011_1010: word <= line_l[5];
		8'b1011_1011: word <= line_l[4];
		8'b1011_1100: word <= line_l[3];
		8'b1011_1101: word <= line_l[2];
		8'b1011_1110: word <= line_l[1];
		8'b1011_1111: word <= line_l[0];

		8'b1100_0000: word <= line_m[15];
		8'b1100_0001: word <= line_m[14];
		8'b1100_0010: word <= line_m[13];
		8'b1100_0011: word <= line_m[12];
		8'b1100_0100: word <= line_m[11];
		8'b1100_0101: word <= line_m[10];
		8'b1100_0110: word <= line_m[9];
		8'b1100_0111: word <= line_m[8];
		8'b1100_1000: word <= line_m[7];
		8'b1100_1001: word <= line_m[6];
		8'b1100_1010: word <= line_m[5];
		8'b1100_1011: word <= line_m[4];
		8'b1100_1100: word <= line_m[3];
		8'b1100_1101: word <= line_m[2];
		8'b1100_1110: word <= line_m[1];
		8'b1100_1111: word <= line_m[0];

		8'b1101_0000: word <= line_n[15];
		8'b1101_0001: word <= line_n[14];
		8'b1101_0010: word <= line_n[13];
		8'b1101_0011: word <= line_n[12];
		8'b1101_0100: word <= line_n[11];
		8'b1101_0101: word <= line_n[10];
		8'b1101_0110: word <= line_n[9];
		8'b1101_0111: word <= line_n[8];
		8'b1101_1000: word <= line_n[7];
		8'b1101_1001: word <= line_n[6];
		8'b1101_1010: word <= line_n[5];
		8'b1101_1011: word <= line_n[4];
		8'b1101_1100: word <= line_n[3];
		8'b1101_1101: word <= line_n[2];
		8'b1101_1110: word <= line_n[1];
		8'b1101_1111: word <= line_n[0];

		8'b1110_0000: word <= line_o[15];
		8'b1110_0001: word <= line_o[14];
		8'b1110_0010: word <= line_o[13];
		8'b1110_0011: word <= line_o[12];
		8'b1110_0100: word <= line_o[11];
		8'b1110_0101: word <= line_o[10];
		8'b1110_0110: word <= line_o[9];
		8'b1110_0111: word <= line_o[8];
		8'b1110_1000: word <= line_o[7];
		8'b1110_1001: word <= line_o[6];
		8'b1110_1010: word <= line_o[5];
		8'b1110_1011: word <= line_o[4];
		8'b1110_1100: word <= line_o[3];
		8'b1110_1101: word <= line_o[2];
		8'b1110_1110: word <= line_o[1];
		8'b1110_1111: word <= line_o[0];

		8'b1111_0000: word <= line_p[15];
		8'b1111_0001: word <= line_p[14];
		8'b1111_0010: word <= line_p[13];
		8'b1111_0011: word <= line_p[12];
		8'b1111_0100: word <= line_p[11];
		8'b1111_0101: word <= line_p[10];
		8'b1111_0110: word <= line_p[9];
		8'b1111_0111: word <= line_p[8];
		8'b1111_1000: word <= line_p[7];
		8'b1111_1001: word <= line_p[6];
		8'b1111_1010: word <= line_p[5];
		8'b1111_1011: word <= line_p[4];
		8'b1111_1100: word <= line_p[3];
		8'b1111_1101: word <= line_p[2];
		8'b1111_1110: word <= line_p[1];
		8'b1111_1111: word <= line_p[0];
	endcase
end

endmodule

module MARKER(
  //output
  word,
  //input
  pic_cnt, row, col, reset);
input [3:0] row;
input [3:0] col;
input [5:0] pic_cnt;
input reset ;
output word;
reg word;
reg [15:0] line_a,
		   line_b,
		   line_c,
		   line_d,
		   line_e,
		   line_f,
		   line_g,
		   line_h, 
		  
		   line_i,
		   line_j,
		   line_k,
		   line_l,
		   line_m,
		   line_n,
		   line_o,
		   line_p;

always@( pic_cnt )begin
    case( pic_cnt )
0:
begin
line_a <= 16'b0000000000000000;
line_b <= 16'b0000000000000000;
line_c <= 16'b0000000000000000;
line_d <= 16'b0000111111110000;
line_e <= 16'b0000100000110000;
line_f <= 16'b0000100001010000;
line_g <= 16'b0000100010010000;
line_h <= 16'b0000100100010000;
line_i <= 16'b0000100100010000;
line_j <= 16'b0000101000010000;
line_k <= 16'b0000110000010000;
line_l <= 16'b0000111111110000;
line_m <= 16'b0000000000000000;
line_n <= 16'b0000000000000000;
line_o <= 16'b0000000000000000;
line_p <= 16'b0000000000000000;
end
		1: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000001100000000;
			line_c <= 16'b0000111100000000;
			line_d <= 16'b0000001100000000;
			line_e <= 16'b0000001100000000;
			line_f <= 16'b0000001100000000;
			line_g <= 16'b0000001100000000;
			line_h <= 16'b0000001100000000;
			line_i <= 16'b0000001100000000;
			line_j <= 16'b0000001100000000;
			line_k <= 16'b0000001100000000;
			line_l <= 16'b0000001100000000;
			line_m <= 16'b0000001100000000;
			line_n <= 16'b0000001100000000;
			line_o <= 16'b0000111111000000;
			line_p <= 16'b0000000000000000;
		end
2:
begin			
line_a <= 16'b0000000000000000;
line_b <= 16'b0000000000000000;
line_c <= 16'b0011111111110000;
line_d <= 16'b0000000000010000;
line_e <= 16'b0000000000010000;
line_f <= 16'b0011111111110000;
line_g <= 16'b0010000000000000;
line_h <= 16'b0010000000000000;
line_i <= 16'b0011111111110000;
line_j <= 16'b0000000000000000;
line_k <= 16'b0000000000000000;
line_l <= 16'b0000000000000000;
line_m <= 16'b0000000000000000;
line_n <= 16'b0000000000000000;
line_o <= 16'b0000000000000000;
line_p <= 16'b0000000000000000;
end
3:
begin
line_a <= 16'b0000000000000000;
line_b <= 16'b0000000000000000;
line_c <= 16'b0000000000000000;
line_d <= 16'b0001111111110000;
line_e <= 16'b0000000000010000;
line_f <= 16'b0000000000010000;
line_g <= 16'b0001111111110000;
line_h <= 16'b0000000000010000;
line_i <= 16'b0000000000010000;
line_j <= 16'b0000000000010000;
line_k <= 16'b0001111111110000;
line_l <= 16'b0000000000000000;
line_m <= 16'b0000000000000000;
line_n <= 16'b0000000000000000;
line_o <= 16'b0000000000000000;
line_p <= 16'b0000000000000000;
end
4:
begin
line_a <= 16'b0000000000000000;
line_b <= 16'b0000000000000000;
line_c <= 16'b0000000000000000;
line_d <= 16'b0000000000000000;
line_e <= 16'b0000100000010000;
line_f <= 16'b0000100000010000;
line_g <= 16'b0000100000010000;
line_h <= 16'b0000100000010000;
line_i <= 16'b0000111111110000;
line_j <= 16'b0000000000010000;
line_k <= 16'b0000000000010000;
line_l <= 16'b0000000000010000;
line_m <= 16'b0000000000010000;
line_n <= 16'b0000000000000000;
line_o <= 16'b0000000000000000;
line_p <= 16'b0000000000000000;
end
5:
begin
line_a <= 16'b0000000000000000;
line_b <= 16'b0000000000000000;
line_c <= 16'b0000000000000000;
line_d <= 16'b0000111111110000;
line_e <= 16'b0000100000000000;
line_f <= 16'b0000100000000000;
line_g <= 16'b0000111111110000;
line_h <= 16'b0000000000010000;
line_i <= 16'b0000000000010000;
line_j <= 16'b0000000000010000;
line_k <= 16'b0000111111110000;
line_l <= 16'b0000000000000000;
line_m <= 16'b0000000000000000;
line_n <= 16'b0000000000000000;
line_o <= 16'b0000000000000000;
line_p <= 16'b0000000000000000;
end
6:
begin
line_a <= 16'b0000000000000000;
line_b <= 16'b0000000000000000;
line_c <= 16'b0000000000000000;
line_d <= 16'b0000000000000000;
line_e <= 16'b0000111111111000;
line_f <= 16'b0000100000000000;
line_g <= 16'b0000100000000000;
line_h <= 16'b0000111111111000;
line_i <= 16'b0000100000001000;
line_j <= 16'b0000100000001000;
line_k <= 16'b0000100000001000;
line_l <= 16'b0000111111111000;
line_m <= 16'b0000000000000000;
line_n <= 16'b0000000000000000;
line_o <= 16'b0000000000000000;
line_p <= 16'b0000000000000000;
end
7:
begin
line_a <= 16'b0000000000000000;
line_b <= 16'b0000000000000000;
line_c <= 16'b0000000000000000;
line_d <= 16'b0000000000000000;
line_e <= 16'b0000111111110000;
line_f <= 16'b0000000000010000;
line_g <= 16'b0000000000010000;
line_h <= 16'b0000000000010000;
line_i <= 16'b0000000000010000;
line_j <= 16'b0000000000010000;
line_k <= 16'b0000000000010000;
line_l <= 16'b0000000000010000;
line_m <= 16'b0000000000010000;
line_n <= 16'b0000000000000000;
line_o <= 16'b0000000000000000;
line_p <= 16'b0000000000000000;
end
8:
begin
line_a <= 16'b0000000000000000;
line_b <= 16'b0000000000000000;
line_c <= 16'b0000000000000000;
line_d <= 16'b0000111111110000;
line_e <= 16'b0000100000010000;
line_f <= 16'b0000100000010000;
line_g <= 16'b0000100000010000;
line_h <= 16'b0000111111110000;
line_i <= 16'b0000100000010000;
line_j <= 16'b0000100000010000;
line_k <= 16'b0000100000010000;
line_l <= 16'b0000111111110000;
line_m <= 16'b0000000000000000;
line_n <= 16'b0000000000000000;
line_o <= 16'b0000000000000000;
line_p <= 16'b0000000000000000;
end
9:
begin
line_a <= 16'b0000000000000000;
line_b <= 16'b0000000000000000;
line_c <= 16'b0000000000000000;
line_d <= 16'b0000000000000000;
line_e <= 16'b0000111111110000;
line_f <= 16'b0000100000010000;
line_g <= 16'b0000100000010000;
line_h <= 16'b0000111111110000;
line_i <= 16'b0000000000010000;
line_j <= 16'b0000000000010000;
line_k <= 16'b0000000000010000;
line_l <= 16'b0000111111110000;
line_m <= 16'b0000000000000000;
line_n <= 16'b0000000000000000;
line_o <= 16'b0000000000000000;
line_p <= 16'b0000000000000000;
end
		10: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011100011111000;
			line_f <= 16'b0001100010001000;
			line_g <= 16'b0001100010001000;
			line_h <= 16'b0001100010001000;
			line_i <= 16'b0001100010001000;
			line_j <= 16'b0001100010001000;
			line_k <= 16'b0001100010001000;
			line_l <= 16'b0001100010001000;
			line_m <= 16'b0011110011111000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		11: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0001110000111000;
			line_f <= 16'b0000110000011000;
			line_g <= 16'b0000110000011000;
			line_h <= 16'b0000110000011000;
			line_i <= 16'b0000110000011000;
			line_j <= 16'b0000110000011000;
			line_k <= 16'b0000110000011000;
			line_l <= 16'b0000110000011000;
			line_m <= 16'b0001111000111100;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		12: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011100011111000;
			line_f <= 16'b0001100000001000;
			line_g <= 16'b0001100000001000;
			line_h <= 16'b0001100000001000;
			line_i <= 16'b0001100011111000;
			line_j <= 16'b0001100010000000;
			line_k <= 16'b0001100010000000;
			line_l <= 16'b0001100010000000;
			line_m <= 16'b0011110011111000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		13: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011100001111100;
			line_f <= 16'b0001100000000100;
			line_g <= 16'b0001100000000100;
			line_h <= 16'b0001100000000100;
			line_i <= 16'b0001100001111100;
			line_j <= 16'b0001100000000100;
			line_k <= 16'b0001100000000100;
			line_l <= 16'b0001100000000100;
			line_m <= 16'b0011110001111100;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		14: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011100010000100;
			line_f <= 16'b0001100010000100;
			line_g <= 16'b0001100010000100;
			line_h <= 16'b0001100010000100;
			line_i <= 16'b0001100010000100;
			line_j <= 16'b0001100011111100;
			line_k <= 16'b0001100000000100;
			line_l <= 16'b0001100000000100;
			line_m <= 16'b0011110000000100;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		15: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011100001111100;
			line_f <= 16'b0001100001000000;
			line_g <= 16'b0001100001000000;
			line_h <= 16'b0001100001000000;
			line_i <= 16'b0001100001111100;
			line_j <= 16'b0001100000000100;
			line_k <= 16'b0001100000000100;
			line_l <= 16'b0001100000000100;
			line_m <= 16'b0011110001111100;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		16: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011100001111100;
			line_f <= 16'b0001100001000000;
			line_g <= 16'b0001100001000000;
			line_h <= 16'b0001100001000000;
			line_i <= 16'b0001100001111100;
			line_j <= 16'b0001100001000100;
			line_k <= 16'b0001100001000100;
			line_l <= 16'b0001100001000100;
			line_m <= 16'b0011110001111100;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		17: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011100011111000;
			line_f <= 16'b0001100000001000;
			line_g <= 16'b0001100000001000;
			line_h <= 16'b0001100000001000;
			line_i <= 16'b0001100000001000;
			line_j <= 16'b0001100000001000;
			line_k <= 16'b0001100000001000;
			line_l <= 16'b0001100000001000;
			line_m <= 16'b0011110000001000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		18: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011100011111100;
			line_f <= 16'b0001100010000100;
			line_g <= 16'b0001100010000100;
			line_h <= 16'b0001100010000100;
			line_i <= 16'b0001100011111100;
			line_j <= 16'b0001100010000100;
			line_k <= 16'b0001100010000100;
			line_l <= 16'b0001100010000100;
			line_m <= 16'b0011100011111100;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		19: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011100011111100;
			line_f <= 16'b0001100010000100;
			line_g <= 16'b0001100010000100;
			line_h <= 16'b0001100010000100;
			line_i <= 16'b0001100011111100;
			line_j <= 16'b0001100000000100;
			line_k <= 16'b0001100000000100;
			line_l <= 16'b0001100000000100;
			line_m <= 16'b0011110011111100;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		20: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0011111001111100;
			line_f <= 16'b0000001001000100;
			line_g <= 16'b0000001001000100;
			line_h <= 16'b0000001001000100;
			line_i <= 16'b0011111001000100;
			line_j <= 16'b0010000001000100;
			line_k <= 16'b0010000001000100;
			line_l <= 16'b0010000001000100;
			line_m <= 16'b0011111001111100;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		default: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0000000000000000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0000000000000000;
			line_i <= 16'b0000000000000000;
			line_j <= 16'b0000000000000000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0000000000000000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
	endcase
end

always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or line_g or
		  line_h or  line_i or  line_j or line_k or line_l or line_m or line_n or  line_o or line_p) begin
		  
	case({row,col})
		8'b0000_0000: word <= line_a[15];
		8'b0000_0001: word <= line_a[14];
		8'b0000_0010: word <= line_a[13];
		8'b0000_0011: word <= line_a[12];
		8'b0000_0100: word <= line_a[11];
		8'b0000_0101: word <= line_a[10];
		8'b0000_0110: word <= line_a[9];
		8'b0000_0111: word <= line_a[8];
		8'b0000_1000: word <= line_a[7];
		8'b0000_1001: word <= line_a[6];
		8'b0000_1010: word <= line_a[5];
		8'b0000_1011: word <= line_a[4];
		8'b0000_1100: word <= line_a[3];
		8'b0000_1101: word <= line_a[2];
		8'b0000_1110: word <= line_a[1];
		8'b0000_1111: word <= line_a[0];

		8'b0001_0000: word <= line_b[15];
		8'b0001_0001: word <= line_b[14];
		8'b0001_0010: word <= line_b[13];
		8'b0001_0011: word <= line_b[12];
		8'b0001_0100: word <= line_b[11];
		8'b0001_0101: word <= line_b[10];
		8'b0001_0110: word <= line_b[9];
		8'b0001_0111: word <= line_b[8];
		8'b0001_1000: word <= line_b[7];
		8'b0001_1001: word <= line_b[6];
		8'b0001_1010: word <= line_b[5];
		8'b0001_1011: word <= line_b[4];
		8'b0001_1100: word <= line_b[3];
		8'b0001_1101: word <= line_b[2];
		8'b0001_1110: word <= line_b[1];
		8'b0001_1111: word <= line_b[0];	

		8'b0010_0000: word <= line_c[15];
		8'b0010_0001: word <= line_c[14];
		8'b0010_0010: word <= line_c[13];
		8'b0010_0011: word <= line_c[12];
		8'b0010_0100: word <= line_c[11];
		8'b0010_0101: word <= line_c[10];
		8'b0010_0110: word <= line_c[9];
		8'b0010_0111: word <= line_c[8];
		8'b0010_1000: word <= line_c[7];
		8'b0010_1001: word <= line_c[6];
		8'b0010_1010: word <= line_c[5];
		8'b0010_1011: word <= line_c[4];
		8'b0010_1100: word <= line_c[3];
		8'b0010_1101: word <= line_c[2];
		8'b0010_1110: word <= line_c[1];
		8'b0010_1111: word <= line_c[0];

		8'b0011_0000: word <= line_d[15];
		8'b0011_0001: word <= line_d[14];
		8'b0011_0010: word <= line_d[13];
		8'b0011_0011: word <= line_d[12];
		8'b0011_0100: word <= line_d[11];
		8'b0011_0101: word <= line_d[10];
		8'b0011_0110: word <= line_d[9];
		8'b0011_0111: word <= line_d[8];
		8'b0011_1000: word <= line_d[7];
		8'b0011_1001: word <= line_d[6];
		8'b0011_1010: word <= line_d[5];
		8'b0011_1011: word <= line_d[4];
		8'b0011_1100: word <= line_d[3];
		8'b0011_1101: word <= line_d[2];
		8'b0011_1110: word <= line_d[1];
		8'b0011_1111: word <= line_d[0];

		8'b0100_0000: word <= line_e[15];
		8'b0100_0001: word <= line_e[14];
		8'b0100_0010: word <= line_e[13];
		8'b0100_0011: word <= line_e[12];
		8'b0100_0100: word <= line_e[11];
		8'b0100_0101: word <= line_e[10];
		8'b0100_0110: word <= line_e[9];
		8'b0100_0111: word <= line_e[8];
		8'b0100_1000: word <= line_e[7];
		8'b0100_1001: word <= line_e[6];
		8'b0100_1010: word <= line_e[5];
		8'b0100_1011: word <= line_e[4];
		8'b0100_1100: word <= line_e[3];
		8'b0100_1101: word <= line_e[2];
		8'b0100_1110: word <= line_e[1];
		8'b0100_1111: word <= line_e[0];

		8'b0101_0000: word <= line_f[15];
		8'b0101_0001: word <= line_f[14];
		8'b0101_0010: word <= line_f[13];
		8'b0101_0011: word <= line_f[12];
		8'b0101_0100: word <= line_f[11];
		8'b0101_0101: word <= line_f[10];
		8'b0101_0110: word <= line_f[9];
		8'b0101_0111: word <= line_f[8];
		8'b0101_1000: word <= line_f[7];
		8'b0101_1001: word <= line_f[6];
		8'b0101_1010: word <= line_f[5];
		8'b0101_1011: word <= line_f[4];
		8'b0101_1100: word <= line_f[3];
		8'b0101_1101: word <= line_f[2];
		8'b0101_1110: word <= line_f[1];
		8'b0101_1111: word <= line_f[0];

		8'b0110_0000: word <= line_g[15];
		8'b0110_0001: word <= line_g[14];
		8'b0110_0010: word <= line_g[13];
		8'b0110_0011: word <= line_g[12];
		8'b0110_0100: word <= line_g[11];
		8'b0110_0101: word <= line_g[10];
		8'b0110_0110: word <= line_g[9];
		8'b0110_0111: word <= line_g[8];
		8'b0110_1000: word <= line_g[7];
		8'b0110_1001: word <= line_g[6];
		8'b0110_1010: word <= line_g[5];
		8'b0110_1011: word <= line_g[4];
		8'b0110_1100: word <= line_g[3];
		8'b0110_1101: word <= line_g[2];
		8'b0110_1110: word <= line_g[1];
		8'b0110_1111: word <= line_g[0];

		8'b0111_0000: word <= line_h[15];
		8'b0111_0001: word <= line_h[14];
		8'b0111_0010: word <= line_h[13];
		8'b0111_0011: word <= line_h[12];
		8'b0111_0100: word <= line_h[11];
		8'b0111_0101: word <= line_h[10];
		8'b0111_0110: word <= line_h[9];
		8'b0111_0111: word <= line_h[8];
		8'b0111_1000: word <= line_h[7];
		8'b0111_1001: word <= line_h[6];
		8'b0111_1010: word <= line_h[5];
		8'b0111_1011: word <= line_h[4];
		8'b0111_1100: word <= line_h[3];
		8'b0111_1101: word <= line_h[2];
		8'b0111_1110: word <= line_h[1];
		8'b0111_1111: word <= line_h[0];

		8'b1000_0000: word <= line_i[15];
		8'b1000_0001: word <= line_i[14];
		8'b1000_0010: word <= line_i[13];
		8'b1000_0011: word <= line_i[12];
		8'b1000_0100: word <= line_i[11];
		8'b1000_0101: word <= line_i[10];
		8'b1000_0110: word <= line_i[9];
		8'b1000_0111: word <= line_i[8];
		8'b1000_1000: word <= line_i[7];
		8'b1000_1001: word <= line_i[6];
		8'b1000_1010: word <= line_i[5];
		8'b1000_1011: word <= line_i[4];
		8'b1000_1100: word <= line_i[3];
		8'b1000_1101: word <= line_i[2];
		8'b1000_1110: word <= line_i[1];
		8'b1000_1111: word <= line_i[0];

		8'b1001_0000: word <= line_j[15];
		8'b1001_0001: word <= line_j[14];
		8'b1001_0010: word <= line_j[13];
		8'b1001_0011: word <= line_j[12];
		8'b1001_0100: word <= line_j[11];
		8'b1001_0101: word <= line_j[10];
		8'b1001_0110: word <= line_j[9];
		8'b1001_0111: word <= line_j[8];
		8'b1001_1000: word <= line_j[7];
		8'b1001_1001: word <= line_j[6];
		8'b1001_1010: word <= line_j[5];
		8'b1001_1011: word <= line_j[4];
		8'b1001_1100: word <= line_j[3];
		8'b1001_1101: word <= line_j[2];
		8'b1001_1110: word <= line_j[1];
		8'b1001_1111: word <= line_j[0];	

		8'b1010_0000: word <= line_k[15];
		8'b1010_0001: word <= line_k[14];
		8'b1010_0010: word <= line_k[13];
		8'b1010_0011: word <= line_k[12];
		8'b1010_0100: word <= line_k[11];
		8'b1010_0101: word <= line_k[10];
		8'b1010_0110: word <= line_k[9];
		8'b1010_0111: word <= line_k[8];
		8'b1010_1000: word <= line_k[7];
		8'b1010_1001: word <= line_k[6];
		8'b1010_1010: word <= line_k[5];
		8'b1010_1011: word <= line_k[4];
		8'b1010_1100: word <= line_k[3];
		8'b1010_1101: word <= line_k[2];
		8'b1010_1110: word <= line_k[1];
		8'b1010_1111: word <= line_k[0];

		8'b1011_0000: word <= line_l[15];
		8'b1011_0001: word <= line_l[14];
		8'b1011_0010: word <= line_l[13];
		8'b1011_0011: word <= line_l[12];
		8'b1011_0100: word <= line_l[11];
		8'b1011_0101: word <= line_l[10];
		8'b1011_0110: word <= line_l[9];
		8'b1011_0111: word <= line_l[8];
		8'b1011_1000: word <= line_l[7];
		8'b1011_1001: word <= line_l[6];
		8'b1011_1010: word <= line_l[5];
		8'b1011_1011: word <= line_l[4];
		8'b1011_1100: word <= line_l[3];
		8'b1011_1101: word <= line_l[2];
		8'b1011_1110: word <= line_l[1];
		8'b1011_1111: word <= line_l[0];

		8'b1100_0000: word <= line_m[15];
		8'b1100_0001: word <= line_m[14];
		8'b1100_0010: word <= line_m[13];
		8'b1100_0011: word <= line_m[12];
		8'b1100_0100: word <= line_m[11];
		8'b1100_0101: word <= line_m[10];
		8'b1100_0110: word <= line_m[9];
		8'b1100_0111: word <= line_m[8];
		8'b1100_1000: word <= line_m[7];
		8'b1100_1001: word <= line_m[6];
		8'b1100_1010: word <= line_m[5];
		8'b1100_1011: word <= line_m[4];
		8'b1100_1100: word <= line_m[3];
		8'b1100_1101: word <= line_m[2];
		8'b1100_1110: word <= line_m[1];
		8'b1100_1111: word <= line_m[0];

		8'b1101_0000: word <= line_n[15];
		8'b1101_0001: word <= line_n[14];
		8'b1101_0010: word <= line_n[13];
		8'b1101_0011: word <= line_n[12];
		8'b1101_0100: word <= line_n[11];
		8'b1101_0101: word <= line_n[10];
		8'b1101_0110: word <= line_n[9];
		8'b1101_0111: word <= line_n[8];
		8'b1101_1000: word <= line_n[7];
		8'b1101_1001: word <= line_n[6];
		8'b1101_1010: word <= line_n[5];
		8'b1101_1011: word <= line_n[4];
		8'b1101_1100: word <= line_n[3];
		8'b1101_1101: word <= line_n[2];
		8'b1101_1110: word <= line_n[1];
		8'b1101_1111: word <= line_n[0];

		8'b1110_0000: word <= line_o[15];
		8'b1110_0001: word <= line_o[14];
		8'b1110_0010: word <= line_o[13];
		8'b1110_0011: word <= line_o[12];
		8'b1110_0100: word <= line_o[11];
		8'b1110_0101: word <= line_o[10];
		8'b1110_0110: word <= line_o[9];
		8'b1110_0111: word <= line_o[8];
		8'b1110_1000: word <= line_o[7];
		8'b1110_1001: word <= line_o[6];
		8'b1110_1010: word <= line_o[5];
		8'b1110_1011: word <= line_o[4];
		8'b1110_1100: word <= line_o[3];
		8'b1110_1101: word <= line_o[2];
		8'b1110_1110: word <= line_o[1];
		8'b1110_1111: word <= line_o[0];

		8'b1111_0000: word <= line_p[15];
		8'b1111_0001: word <= line_p[14];
		8'b1111_0010: word <= line_p[13];
		8'b1111_0011: word <= line_p[12];
		8'b1111_0100: word <= line_p[11];
		8'b1111_0101: word <= line_p[10];
		8'b1111_0110: word <= line_p[9];
		8'b1111_0111: word <= line_p[8];
		8'b1111_1000: word <= line_p[7];
		8'b1111_1001: word <= line_p[6];
		8'b1111_1010: word <= line_p[5];
		8'b1111_1011: word <= line_p[4];
		8'b1111_1100: word <= line_p[3];
		8'b1111_1101: word <= line_p[2];
		8'b1111_1110: word <= line_p[1];
		8'b1111_1111: word <= line_p[0];
	endcase
end

endmodule

module BULLETS(
  //output
  word,
  //input
  pic_cnt, row, col, reset);
input [3:0] row;
input [3:0] col;
input [5:0] pic_cnt;
input reset ;
output word;
reg word;
reg [15:0] line_a,
		   line_b,
		   line_c,
		   line_d,
		   line_e,
		   line_f,
		   line_g,
		   line_h, 
		  
		   line_i,
		   line_j,
		   line_k,
		   line_l,
		   line_m,
		   line_n,
		   line_o,
		   line_p;

always@( pic_cnt )begin
    case( pic_cnt )
		0: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0001110000111000;
			line_d <= 16'b0001010000101000;
			line_e <= 16'b0001110000111000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0001110000111000;
			line_i <= 16'b0001010000101000;
			line_j <= 16'b0001110000111000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0001110000111000;
			line_n <= 16'b0001010000101000;
			line_o <= 16'b0001110000111000;
			line_p <= 16'b0000000000000000;
		end
		1: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0001110000111000;
			line_d <= 16'b0001010000101000;
			line_e <= 16'b0001110000111000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0001110000111000;
			line_i <= 16'b0001010000101000;
			line_j <= 16'b0001110000111000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0001110000111000;
			line_n <= 16'b0001010000111000;
			line_o <= 16'b0001110000111000;
			line_p <= 16'b0000000000000000;
		end
		2: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0001110000111000;
			line_d <= 16'b0001010000101000;
			line_e <= 16'b0001110000111000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0001110000111000;
			line_i <= 16'b0001010000101000;
			line_j <= 16'b0001110000111000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0001110000111000;
			line_n <= 16'b0001110000111000;
			line_o <= 16'b0001110000111000;
			line_p <= 16'b0000000000000000;
		end
		3: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0001110000111000;
			line_d <= 16'b0001010000101000;
			line_e <= 16'b0001110000111000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0001110000111000;
			line_i <= 16'b0001010000111000;
			line_j <= 16'b0001110000111000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0001110000111000;
			line_n <= 16'b0001110000111000;
			line_o <= 16'b0001110000111000;
			line_p <= 16'b0000000000000000;
		end
		4: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0001110000111000;
			line_d <= 16'b0001010000101000;
			line_e <= 16'b0001110000111000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0001110000111000;
			line_i <= 16'b0001110000111000;
			line_j <= 16'b0001110000111000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0001110000111000;
			line_n <= 16'b0001110000111000;
			line_o <= 16'b0001110000111000;
			line_p <= 16'b0000000000000000;
		end
		5: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0001110000111000;
			line_d <= 16'b0001010000111000;
			line_e <= 16'b0001110000111000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0001110000111000;
			line_i <= 16'b0001110000111000;
			line_j <= 16'b0001110000111000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0001110000111000;
			line_n <= 16'b0001110000111000;
			line_o <= 16'b0001110000111000;
			line_p <= 16'b0000000000000000;
		end
		6: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0001110000111000;
			line_d <= 16'b0001110000111000;
			line_e <= 16'b0001110000111000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0001110000111000;
			line_i <= 16'b0001110000111000;
			line_j <= 16'b0001110000111000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0001110000111000;
			line_n <= 16'b0001110000111000;
			line_o <= 16'b0001110000111000;
			line_p <= 16'b0000000000000000;
		end
		default: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0000000000000000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0000000000000000;
			line_i <= 16'b0000000000000000;
			line_j <= 16'b0000000000000000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0000000000000000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
	endcase
end

always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or line_g or
		  line_h or  line_i or  line_j or line_k or line_l or line_m or line_n or  line_o or line_p) begin
		  
	case({row,col})
		8'b0000_0000: word <= line_a[15];
		8'b0000_0001: word <= line_a[14];
		8'b0000_0010: word <= line_a[13];
		8'b0000_0011: word <= line_a[12];
		8'b0000_0100: word <= line_a[11];
		8'b0000_0101: word <= line_a[10];
		8'b0000_0110: word <= line_a[9];
		8'b0000_0111: word <= line_a[8];
		8'b0000_1000: word <= line_a[7];
		8'b0000_1001: word <= line_a[6];
		8'b0000_1010: word <= line_a[5];
		8'b0000_1011: word <= line_a[4];
		8'b0000_1100: word <= line_a[3];
		8'b0000_1101: word <= line_a[2];
		8'b0000_1110: word <= line_a[1];
		8'b0000_1111: word <= line_a[0];

		8'b0001_0000: word <= line_b[15];
		8'b0001_0001: word <= line_b[14];
		8'b0001_0010: word <= line_b[13];
		8'b0001_0011: word <= line_b[12];
		8'b0001_0100: word <= line_b[11];
		8'b0001_0101: word <= line_b[10];
		8'b0001_0110: word <= line_b[9];
		8'b0001_0111: word <= line_b[8];
		8'b0001_1000: word <= line_b[7];
		8'b0001_1001: word <= line_b[6];
		8'b0001_1010: word <= line_b[5];
		8'b0001_1011: word <= line_b[4];
		8'b0001_1100: word <= line_b[3];
		8'b0001_1101: word <= line_b[2];
		8'b0001_1110: word <= line_b[1];
		8'b0001_1111: word <= line_b[0];	

		8'b0010_0000: word <= line_c[15];
		8'b0010_0001: word <= line_c[14];
		8'b0010_0010: word <= line_c[13];
		8'b0010_0011: word <= line_c[12];
		8'b0010_0100: word <= line_c[11];
		8'b0010_0101: word <= line_c[10];
		8'b0010_0110: word <= line_c[9];
		8'b0010_0111: word <= line_c[8];
		8'b0010_1000: word <= line_c[7];
		8'b0010_1001: word <= line_c[6];
		8'b0010_1010: word <= line_c[5];
		8'b0010_1011: word <= line_c[4];
		8'b0010_1100: word <= line_c[3];
		8'b0010_1101: word <= line_c[2];
		8'b0010_1110: word <= line_c[1];
		8'b0010_1111: word <= line_c[0];

		8'b0011_0000: word <= line_d[15];
		8'b0011_0001: word <= line_d[14];
		8'b0011_0010: word <= line_d[13];
		8'b0011_0011: word <= line_d[12];
		8'b0011_0100: word <= line_d[11];
		8'b0011_0101: word <= line_d[10];
		8'b0011_0110: word <= line_d[9];
		8'b0011_0111: word <= line_d[8];
		8'b0011_1000: word <= line_d[7];
		8'b0011_1001: word <= line_d[6];
		8'b0011_1010: word <= line_d[5];
		8'b0011_1011: word <= line_d[4];
		8'b0011_1100: word <= line_d[3];
		8'b0011_1101: word <= line_d[2];
		8'b0011_1110: word <= line_d[1];
		8'b0011_1111: word <= line_d[0];

		8'b0100_0000: word <= line_e[15];
		8'b0100_0001: word <= line_e[14];
		8'b0100_0010: word <= line_e[13];
		8'b0100_0011: word <= line_e[12];
		8'b0100_0100: word <= line_e[11];
		8'b0100_0101: word <= line_e[10];
		8'b0100_0110: word <= line_e[9];
		8'b0100_0111: word <= line_e[8];
		8'b0100_1000: word <= line_e[7];
		8'b0100_1001: word <= line_e[6];
		8'b0100_1010: word <= line_e[5];
		8'b0100_1011: word <= line_e[4];
		8'b0100_1100: word <= line_e[3];
		8'b0100_1101: word <= line_e[2];
		8'b0100_1110: word <= line_e[1];
		8'b0100_1111: word <= line_e[0];

		8'b0101_0000: word <= line_f[15];
		8'b0101_0001: word <= line_f[14];
		8'b0101_0010: word <= line_f[13];
		8'b0101_0011: word <= line_f[12];
		8'b0101_0100: word <= line_f[11];
		8'b0101_0101: word <= line_f[10];
		8'b0101_0110: word <= line_f[9];
		8'b0101_0111: word <= line_f[8];
		8'b0101_1000: word <= line_f[7];
		8'b0101_1001: word <= line_f[6];
		8'b0101_1010: word <= line_f[5];
		8'b0101_1011: word <= line_f[4];
		8'b0101_1100: word <= line_f[3];
		8'b0101_1101: word <= line_f[2];
		8'b0101_1110: word <= line_f[1];
		8'b0101_1111: word <= line_f[0];

		8'b0110_0000: word <= line_g[15];
		8'b0110_0001: word <= line_g[14];
		8'b0110_0010: word <= line_g[13];
		8'b0110_0011: word <= line_g[12];
		8'b0110_0100: word <= line_g[11];
		8'b0110_0101: word <= line_g[10];
		8'b0110_0110: word <= line_g[9];
		8'b0110_0111: word <= line_g[8];
		8'b0110_1000: word <= line_g[7];
		8'b0110_1001: word <= line_g[6];
		8'b0110_1010: word <= line_g[5];
		8'b0110_1011: word <= line_g[4];
		8'b0110_1100: word <= line_g[3];
		8'b0110_1101: word <= line_g[2];
		8'b0110_1110: word <= line_g[1];
		8'b0110_1111: word <= line_g[0];

		8'b0111_0000: word <= line_h[15];
		8'b0111_0001: word <= line_h[14];
		8'b0111_0010: word <= line_h[13];
		8'b0111_0011: word <= line_h[12];
		8'b0111_0100: word <= line_h[11];
		8'b0111_0101: word <= line_h[10];
		8'b0111_0110: word <= line_h[9];
		8'b0111_0111: word <= line_h[8];
		8'b0111_1000: word <= line_h[7];
		8'b0111_1001: word <= line_h[6];
		8'b0111_1010: word <= line_h[5];
		8'b0111_1011: word <= line_h[4];
		8'b0111_1100: word <= line_h[3];
		8'b0111_1101: word <= line_h[2];
		8'b0111_1110: word <= line_h[1];
		8'b0111_1111: word <= line_h[0];

		8'b1000_0000: word <= line_i[15];
		8'b1000_0001: word <= line_i[14];
		8'b1000_0010: word <= line_i[13];
		8'b1000_0011: word <= line_i[12];
		8'b1000_0100: word <= line_i[11];
		8'b1000_0101: word <= line_i[10];
		8'b1000_0110: word <= line_i[9];
		8'b1000_0111: word <= line_i[8];
		8'b1000_1000: word <= line_i[7];
		8'b1000_1001: word <= line_i[6];
		8'b1000_1010: word <= line_i[5];
		8'b1000_1011: word <= line_i[4];
		8'b1000_1100: word <= line_i[3];
		8'b1000_1101: word <= line_i[2];
		8'b1000_1110: word <= line_i[1];
		8'b1000_1111: word <= line_i[0];

		8'b1001_0000: word <= line_j[15];
		8'b1001_0001: word <= line_j[14];
		8'b1001_0010: word <= line_j[13];
		8'b1001_0011: word <= line_j[12];
		8'b1001_0100: word <= line_j[11];
		8'b1001_0101: word <= line_j[10];
		8'b1001_0110: word <= line_j[9];
		8'b1001_0111: word <= line_j[8];
		8'b1001_1000: word <= line_j[7];
		8'b1001_1001: word <= line_j[6];
		8'b1001_1010: word <= line_j[5];
		8'b1001_1011: word <= line_j[4];
		8'b1001_1100: word <= line_j[3];
		8'b1001_1101: word <= line_j[2];
		8'b1001_1110: word <= line_j[1];
		8'b1001_1111: word <= line_j[0];	

		8'b1010_0000: word <= line_k[15];
		8'b1010_0001: word <= line_k[14];
		8'b1010_0010: word <= line_k[13];
		8'b1010_0011: word <= line_k[12];
		8'b1010_0100: word <= line_k[11];
		8'b1010_0101: word <= line_k[10];
		8'b1010_0110: word <= line_k[9];
		8'b1010_0111: word <= line_k[8];
		8'b1010_1000: word <= line_k[7];
		8'b1010_1001: word <= line_k[6];
		8'b1010_1010: word <= line_k[5];
		8'b1010_1011: word <= line_k[4];
		8'b1010_1100: word <= line_k[3];
		8'b1010_1101: word <= line_k[2];
		8'b1010_1110: word <= line_k[1];
		8'b1010_1111: word <= line_k[0];

		8'b1011_0000: word <= line_l[15];
		8'b1011_0001: word <= line_l[14];
		8'b1011_0010: word <= line_l[13];
		8'b1011_0011: word <= line_l[12];
		8'b1011_0100: word <= line_l[11];
		8'b1011_0101: word <= line_l[10];
		8'b1011_0110: word <= line_l[9];
		8'b1011_0111: word <= line_l[8];
		8'b1011_1000: word <= line_l[7];
		8'b1011_1001: word <= line_l[6];
		8'b1011_1010: word <= line_l[5];
		8'b1011_1011: word <= line_l[4];
		8'b1011_1100: word <= line_l[3];
		8'b1011_1101: word <= line_l[2];
		8'b1011_1110: word <= line_l[1];
		8'b1011_1111: word <= line_l[0];

		8'b1100_0000: word <= line_m[15];
		8'b1100_0001: word <= line_m[14];
		8'b1100_0010: word <= line_m[13];
		8'b1100_0011: word <= line_m[12];
		8'b1100_0100: word <= line_m[11];
		8'b1100_0101: word <= line_m[10];
		8'b1100_0110: word <= line_m[9];
		8'b1100_0111: word <= line_m[8];
		8'b1100_1000: word <= line_m[7];
		8'b1100_1001: word <= line_m[6];
		8'b1100_1010: word <= line_m[5];
		8'b1100_1011: word <= line_m[4];
		8'b1100_1100: word <= line_m[3];
		8'b1100_1101: word <= line_m[2];
		8'b1100_1110: word <= line_m[1];
		8'b1100_1111: word <= line_m[0];

		8'b1101_0000: word <= line_n[15];
		8'b1101_0001: word <= line_n[14];
		8'b1101_0010: word <= line_n[13];
		8'b1101_0011: word <= line_n[12];
		8'b1101_0100: word <= line_n[11];
		8'b1101_0101: word <= line_n[10];
		8'b1101_0110: word <= line_n[9];
		8'b1101_0111: word <= line_n[8];
		8'b1101_1000: word <= line_n[7];
		8'b1101_1001: word <= line_n[6];
		8'b1101_1010: word <= line_n[5];
		8'b1101_1011: word <= line_n[4];
		8'b1101_1100: word <= line_n[3];
		8'b1101_1101: word <= line_n[2];
		8'b1101_1110: word <= line_n[1];
		8'b1101_1111: word <= line_n[0];

		8'b1110_0000: word <= line_o[15];
		8'b1110_0001: word <= line_o[14];
		8'b1110_0010: word <= line_o[13];
		8'b1110_0011: word <= line_o[12];
		8'b1110_0100: word <= line_o[11];
		8'b1110_0101: word <= line_o[10];
		8'b1110_0110: word <= line_o[9];
		8'b1110_0111: word <= line_o[8];
		8'b1110_1000: word <= line_o[7];
		8'b1110_1001: word <= line_o[6];
		8'b1110_1010: word <= line_o[5];
		8'b1110_1011: word <= line_o[4];
		8'b1110_1100: word <= line_o[3];
		8'b1110_1101: word <= line_o[2];
		8'b1110_1110: word <= line_o[1];
		8'b1110_1111: word <= line_o[0];

		8'b1111_0000: word <= line_p[15];
		8'b1111_0001: word <= line_p[14];
		8'b1111_0010: word <= line_p[13];
		8'b1111_0011: word <= line_p[12];
		8'b1111_0100: word <= line_p[11];
		8'b1111_0101: word <= line_p[10];
		8'b1111_0110: word <= line_p[9];
		8'b1111_0111: word <= line_p[8];
		8'b1111_1000: word <= line_p[7];
		8'b1111_1001: word <= line_p[6];
		8'b1111_1010: word <= line_p[5];
		8'b1111_1011: word <= line_p[4];
		8'b1111_1100: word <= line_p[3];
		8'b1111_1101: word <= line_p[2];
		8'b1111_1110: word <= line_p[1];
		8'b1111_1111: word <= line_p[0];
	endcase
end

endmodule

module GG(
  //output
  word,
  //input
  pic_cnt, row, col, reset);
input [3:0] row;
input [3:0] col;
input [5:0] pic_cnt;
input reset ;
output word;
reg word;
reg [15:0] line_a,
		   line_b,
		   line_c,
		   line_d,
		   line_e,
		   line_f,
		   line_g,
		   line_h, 
		  
		   line_i,
		   line_j,
		   line_k,
		   line_l,
		   line_m,
		   line_n,
		   line_o,
		   line_p;

always@( pic_cnt )begin
    case( pic_cnt )
		0: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0111110011111100;
			line_f <= 16'b0100000010000000;
			line_g <= 16'b0100000010000000;
			line_h <= 16'b0100000010000000;
			line_i <= 16'b0101111010011110;
			line_j <= 16'b0100010010000100;
			line_k <= 16'b0100010010000100;
			line_l <= 16'b0111110011111100;
			line_m <= 16'b0000000000000000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
		default: begin
			line_a <= 16'b0000000000000000;
			line_b <= 16'b0000000000000000;
			line_c <= 16'b0000000000000000;
			line_d <= 16'b0000000000000000;
			line_e <= 16'b0000000000000000;
			line_f <= 16'b0000000000000000;
			line_g <= 16'b0000000000000000;
			line_h <= 16'b0000000000000000;
			line_i <= 16'b0000000000000000;
			line_j <= 16'b0000000000000000;
			line_k <= 16'b0000000000000000;
			line_l <= 16'b0000000000000000;
			line_m <= 16'b0000000000000000;
			line_n <= 16'b0000000000000000;
			line_o <= 16'b0000000000000000;
			line_p <= 16'b0000000000000000;
		end
	endcase
end

always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or line_g or
		  line_h or  line_i or  line_j or line_k or line_l or line_m or line_n or  line_o or line_p) begin
		  
	case({row,col})
		8'b0000_0000: word <= line_a[15];
		8'b0000_0001: word <= line_a[14];
		8'b0000_0010: word <= line_a[13];
		8'b0000_0011: word <= line_a[12];
		8'b0000_0100: word <= line_a[11];
		8'b0000_0101: word <= line_a[10];
		8'b0000_0110: word <= line_a[9];
		8'b0000_0111: word <= line_a[8];
		8'b0000_1000: word <= line_a[7];
		8'b0000_1001: word <= line_a[6];
		8'b0000_1010: word <= line_a[5];
		8'b0000_1011: word <= line_a[4];
		8'b0000_1100: word <= line_a[3];
		8'b0000_1101: word <= line_a[2];
		8'b0000_1110: word <= line_a[1];
		8'b0000_1111: word <= line_a[0];

		8'b0001_0000: word <= line_b[15];
		8'b0001_0001: word <= line_b[14];
		8'b0001_0010: word <= line_b[13];
		8'b0001_0011: word <= line_b[12];
		8'b0001_0100: word <= line_b[11];
		8'b0001_0101: word <= line_b[10];
		8'b0001_0110: word <= line_b[9];
		8'b0001_0111: word <= line_b[8];
		8'b0001_1000: word <= line_b[7];
		8'b0001_1001: word <= line_b[6];
		8'b0001_1010: word <= line_b[5];
		8'b0001_1011: word <= line_b[4];
		8'b0001_1100: word <= line_b[3];
		8'b0001_1101: word <= line_b[2];
		8'b0001_1110: word <= line_b[1];
		8'b0001_1111: word <= line_b[0];	

		8'b0010_0000: word <= line_c[15];
		8'b0010_0001: word <= line_c[14];
		8'b0010_0010: word <= line_c[13];
		8'b0010_0011: word <= line_c[12];
		8'b0010_0100: word <= line_c[11];
		8'b0010_0101: word <= line_c[10];
		8'b0010_0110: word <= line_c[9];
		8'b0010_0111: word <= line_c[8];
		8'b0010_1000: word <= line_c[7];
		8'b0010_1001: word <= line_c[6];
		8'b0010_1010: word <= line_c[5];
		8'b0010_1011: word <= line_c[4];
		8'b0010_1100: word <= line_c[3];
		8'b0010_1101: word <= line_c[2];
		8'b0010_1110: word <= line_c[1];
		8'b0010_1111: word <= line_c[0];

		8'b0011_0000: word <= line_d[15];
		8'b0011_0001: word <= line_d[14];
		8'b0011_0010: word <= line_d[13];
		8'b0011_0011: word <= line_d[12];
		8'b0011_0100: word <= line_d[11];
		8'b0011_0101: word <= line_d[10];
		8'b0011_0110: word <= line_d[9];
		8'b0011_0111: word <= line_d[8];
		8'b0011_1000: word <= line_d[7];
		8'b0011_1001: word <= line_d[6];
		8'b0011_1010: word <= line_d[5];
		8'b0011_1011: word <= line_d[4];
		8'b0011_1100: word <= line_d[3];
		8'b0011_1101: word <= line_d[2];
		8'b0011_1110: word <= line_d[1];
		8'b0011_1111: word <= line_d[0];

		8'b0100_0000: word <= line_e[15];
		8'b0100_0001: word <= line_e[14];
		8'b0100_0010: word <= line_e[13];
		8'b0100_0011: word <= line_e[12];
		8'b0100_0100: word <= line_e[11];
		8'b0100_0101: word <= line_e[10];
		8'b0100_0110: word <= line_e[9];
		8'b0100_0111: word <= line_e[8];
		8'b0100_1000: word <= line_e[7];
		8'b0100_1001: word <= line_e[6];
		8'b0100_1010: word <= line_e[5];
		8'b0100_1011: word <= line_e[4];
		8'b0100_1100: word <= line_e[3];
		8'b0100_1101: word <= line_e[2];
		8'b0100_1110: word <= line_e[1];
		8'b0100_1111: word <= line_e[0];

		8'b0101_0000: word <= line_f[15];
		8'b0101_0001: word <= line_f[14];
		8'b0101_0010: word <= line_f[13];
		8'b0101_0011: word <= line_f[12];
		8'b0101_0100: word <= line_f[11];
		8'b0101_0101: word <= line_f[10];
		8'b0101_0110: word <= line_f[9];
		8'b0101_0111: word <= line_f[8];
		8'b0101_1000: word <= line_f[7];
		8'b0101_1001: word <= line_f[6];
		8'b0101_1010: word <= line_f[5];
		8'b0101_1011: word <= line_f[4];
		8'b0101_1100: word <= line_f[3];
		8'b0101_1101: word <= line_f[2];
		8'b0101_1110: word <= line_f[1];
		8'b0101_1111: word <= line_f[0];

		8'b0110_0000: word <= line_g[15];
		8'b0110_0001: word <= line_g[14];
		8'b0110_0010: word <= line_g[13];
		8'b0110_0011: word <= line_g[12];
		8'b0110_0100: word <= line_g[11];
		8'b0110_0101: word <= line_g[10];
		8'b0110_0110: word <= line_g[9];
		8'b0110_0111: word <= line_g[8];
		8'b0110_1000: word <= line_g[7];
		8'b0110_1001: word <= line_g[6];
		8'b0110_1010: word <= line_g[5];
		8'b0110_1011: word <= line_g[4];
		8'b0110_1100: word <= line_g[3];
		8'b0110_1101: word <= line_g[2];
		8'b0110_1110: word <= line_g[1];
		8'b0110_1111: word <= line_g[0];

		8'b0111_0000: word <= line_h[15];
		8'b0111_0001: word <= line_h[14];
		8'b0111_0010: word <= line_h[13];
		8'b0111_0011: word <= line_h[12];
		8'b0111_0100: word <= line_h[11];
		8'b0111_0101: word <= line_h[10];
		8'b0111_0110: word <= line_h[9];
		8'b0111_0111: word <= line_h[8];
		8'b0111_1000: word <= line_h[7];
		8'b0111_1001: word <= line_h[6];
		8'b0111_1010: word <= line_h[5];
		8'b0111_1011: word <= line_h[4];
		8'b0111_1100: word <= line_h[3];
		8'b0111_1101: word <= line_h[2];
		8'b0111_1110: word <= line_h[1];
		8'b0111_1111: word <= line_h[0];

		8'b1000_0000: word <= line_i[15];
		8'b1000_0001: word <= line_i[14];
		8'b1000_0010: word <= line_i[13];
		8'b1000_0011: word <= line_i[12];
		8'b1000_0100: word <= line_i[11];
		8'b1000_0101: word <= line_i[10];
		8'b1000_0110: word <= line_i[9];
		8'b1000_0111: word <= line_i[8];
		8'b1000_1000: word <= line_i[7];
		8'b1000_1001: word <= line_i[6];
		8'b1000_1010: word <= line_i[5];
		8'b1000_1011: word <= line_i[4];
		8'b1000_1100: word <= line_i[3];
		8'b1000_1101: word <= line_i[2];
		8'b1000_1110: word <= line_i[1];
		8'b1000_1111: word <= line_i[0];

		8'b1001_0000: word <= line_j[15];
		8'b1001_0001: word <= line_j[14];
		8'b1001_0010: word <= line_j[13];
		8'b1001_0011: word <= line_j[12];
		8'b1001_0100: word <= line_j[11];
		8'b1001_0101: word <= line_j[10];
		8'b1001_0110: word <= line_j[9];
		8'b1001_0111: word <= line_j[8];
		8'b1001_1000: word <= line_j[7];
		8'b1001_1001: word <= line_j[6];
		8'b1001_1010: word <= line_j[5];
		8'b1001_1011: word <= line_j[4];
		8'b1001_1100: word <= line_j[3];
		8'b1001_1101: word <= line_j[2];
		8'b1001_1110: word <= line_j[1];
		8'b1001_1111: word <= line_j[0];	

		8'b1010_0000: word <= line_k[15];
		8'b1010_0001: word <= line_k[14];
		8'b1010_0010: word <= line_k[13];
		8'b1010_0011: word <= line_k[12];
		8'b1010_0100: word <= line_k[11];
		8'b1010_0101: word <= line_k[10];
		8'b1010_0110: word <= line_k[9];
		8'b1010_0111: word <= line_k[8];
		8'b1010_1000: word <= line_k[7];
		8'b1010_1001: word <= line_k[6];
		8'b1010_1010: word <= line_k[5];
		8'b1010_1011: word <= line_k[4];
		8'b1010_1100: word <= line_k[3];
		8'b1010_1101: word <= line_k[2];
		8'b1010_1110: word <= line_k[1];
		8'b1010_1111: word <= line_k[0];

		8'b1011_0000: word <= line_l[15];
		8'b1011_0001: word <= line_l[14];
		8'b1011_0010: word <= line_l[13];
		8'b1011_0011: word <= line_l[12];
		8'b1011_0100: word <= line_l[11];
		8'b1011_0101: word <= line_l[10];
		8'b1011_0110: word <= line_l[9];
		8'b1011_0111: word <= line_l[8];
		8'b1011_1000: word <= line_l[7];
		8'b1011_1001: word <= line_l[6];
		8'b1011_1010: word <= line_l[5];
		8'b1011_1011: word <= line_l[4];
		8'b1011_1100: word <= line_l[3];
		8'b1011_1101: word <= line_l[2];
		8'b1011_1110: word <= line_l[1];
		8'b1011_1111: word <= line_l[0];

		8'b1100_0000: word <= line_m[15];
		8'b1100_0001: word <= line_m[14];
		8'b1100_0010: word <= line_m[13];
		8'b1100_0011: word <= line_m[12];
		8'b1100_0100: word <= line_m[11];
		8'b1100_0101: word <= line_m[10];
		8'b1100_0110: word <= line_m[9];
		8'b1100_0111: word <= line_m[8];
		8'b1100_1000: word <= line_m[7];
		8'b1100_1001: word <= line_m[6];
		8'b1100_1010: word <= line_m[5];
		8'b1100_1011: word <= line_m[4];
		8'b1100_1100: word <= line_m[3];
		8'b1100_1101: word <= line_m[2];
		8'b1100_1110: word <= line_m[1];
		8'b1100_1111: word <= line_m[0];

		8'b1101_0000: word <= line_n[15];
		8'b1101_0001: word <= line_n[14];
		8'b1101_0010: word <= line_n[13];
		8'b1101_0011: word <= line_n[12];
		8'b1101_0100: word <= line_n[11];
		8'b1101_0101: word <= line_n[10];
		8'b1101_0110: word <= line_n[9];
		8'b1101_0111: word <= line_n[8];
		8'b1101_1000: word <= line_n[7];
		8'b1101_1001: word <= line_n[6];
		8'b1101_1010: word <= line_n[5];
		8'b1101_1011: word <= line_n[4];
		8'b1101_1100: word <= line_n[3];
		8'b1101_1101: word <= line_n[2];
		8'b1101_1110: word <= line_n[1];
		8'b1101_1111: word <= line_n[0];

		8'b1110_0000: word <= line_o[15];
		8'b1110_0001: word <= line_o[14];
		8'b1110_0010: word <= line_o[13];
		8'b1110_0011: word <= line_o[12];
		8'b1110_0100: word <= line_o[11];
		8'b1110_0101: word <= line_o[10];
		8'b1110_0110: word <= line_o[9];
		8'b1110_0111: word <= line_o[8];
		8'b1110_1000: word <= line_o[7];
		8'b1110_1001: word <= line_o[6];
		8'b1110_1010: word <= line_o[5];
		8'b1110_1011: word <= line_o[4];
		8'b1110_1100: word <= line_o[3];
		8'b1110_1101: word <= line_o[2];
		8'b1110_1110: word <= line_o[1];
		8'b1110_1111: word <= line_o[0];

		8'b1111_0000: word <= line_p[15];
		8'b1111_0001: word <= line_p[14];
		8'b1111_0010: word <= line_p[13];
		8'b1111_0011: word <= line_p[12];
		8'b1111_0100: word <= line_p[11];
		8'b1111_0101: word <= line_p[10];
		8'b1111_0110: word <= line_p[9];
		8'b1111_0111: word <= line_p[8];
		8'b1111_1000: word <= line_p[7];
		8'b1111_1001: word <= line_p[6];
		8'b1111_1010: word <= line_p[5];
		8'b1111_1011: word <= line_p[4];
		8'b1111_1100: word <= line_p[3];
		8'b1111_1101: word <= line_p[2];
		8'b1111_1110: word <= line_p[1];
		8'b1111_1111: word <= line_p[0];
	endcase
end

endmodule

