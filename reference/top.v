//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date:    05/25/2009 
// Design Name:    Dlab lab05 example
// Module Name:    Lab05_example 
// Description: 
// 		VGA display two grids
// 		push BTN1 => grid 1 display O
// 		push BTN2 => grid 2 display O
// 		push reset => empty grids
//
//////////////////////////////////////////////////////////////////////////////////

//死掉按空白鍵重生
//方向鍵控制方向
//空白鍵發射球


module project(
    clock,
    reset,
     red,
    green,
    blue,
    hsync,
    vsync,
     KDAT, KCLK 
   );



input KDAT,KCLK;
input clock;
input reset;
output hsync;
output vsync;
output red, green, blue;

wire   hsync, vsync;
reg [10:0] pixel_col;
reg [9:0]  pixel_row;

wire visible;

reg row_Inc;
reg red, green, blue;
reg 	[2:0] rgb_buffer;
wire [7:0] KDATA;
//reg [10:0] down,left;
reg [5:0] state;
wire word1,word2,word3,word4,word5,word6;
wire [10:0] col;
wire [9:0]  row;
reg    [10:0] center_x,center_y; 
reg [29:0] counter1;
reg [30:0] r;
wire [60:0] area;

keyboard i_keyboard( .clk(clock), .reset(reset), .KCLK(KCLK), .KDAT(KDAT), .DATA(KDATA));

parameter down =104;
parameter left =23;

reg [10:0] c_down,c_left;



assign col = pixel_col - down;
assign row = pixel_row - left;

word_one  w1(   .word(word1),
			 .row(row[5:2]) ,
			 .col(col[5:2]) 
			  );
			  
word_two  w2(   .word(word2),
			 .row(row[6:3]) ,
			 .col(col[6:3]) 
			  );
		
		
word_three  w3(   .word(word3),
			 .row(row[6:3]) ,
			 .col(col[6:3]) 
			  );
word_four  w4(   .word(word4),
			 .row(row[6:3]) ,
			 .col(col[6:3]) 
			  );
		
word_five  w5(   .word(word5),
			 .row(row[6:3]) ,
			 .col(col[6:3]) 
			  );
			  
word_six  w6(   .word(word6),
			 .row(row[6:3]) ,
			 .col(col[6:3]) 
			  );


reg g1,g2,g3,g4,g5,g6,g7,g8,g9,gg1,gg2,gg3,gg4,gg5,gg6,gg7,gg8,gg9;

always @ (posedge clock)
begin
	if(reset)
		counter1<=0;
	else if(counter1==522143)
		counter1<=0;
	else 
		counter1<=counter1+1;
end

always @(posedge clock)		 
begin
	if(reset)
		r<=15;
	else 
		r<=r;
end


reg [30:0] length;
reg count,count2;

always @(posedge clock)		 
begin
	if(reset)
		count<=0;
	else if(length==256 || length==64)
		count<=1;
	else
		count<=count;
end

always @(posedge clock)		 
begin
	if(reset)
		count2<=0;
	else if(count==1 && (g7 && gg9))
		count2<=1;
	else
		count2<=count2;
end


always@(posedge clock)
begin
	if(reset)
		length<=128;
	else if(gg9==1 && (count==0 && count2==0))
		length<=256;
	else if(g7==1 && (count==1 && count2==1))
		length<=64;
	else
		length<=length;
end

assign area = r*r;


wire r1,r2,r3,r4,r5,r6,r7,r8,r9,rr1,rr2,rr3,rr4,rr5,rr6,rr7,rr8,rr9;

assign r1 = (center_x-r<=down+64 && center_y>=left && center_y<=left+64) || (center_y-r<=left+64 && center_x>=down && center_x<=down+64);
assign r2 = (center_x-r<=down+128 && center_y>=left && center_y<=left+64) || (center_y-r<=left+64 && center_x>=down+64 && center_x<=down+128);
assign r3 = (center_x-r<=down+192 && center_y>=left && center_y<=left+64) || (center_y-r<=left+64 && center_x>=down+128 && center_x<=down+192);
assign r4 = (center_x-r<=down+64 && center_y>=left+64 && center_y<=left+128) || (center_y-r<=left+128 && center_x>=down && center_x<=down+64);
assign r5 = (center_x-r<=down+128 && center_y>=left+64 && center_y<=left+128) || (center_y-r<=left+128 && center_x>=down+64 && center_x<=down+128);
assign r6 = (center_x-r<=down+192 && center_y>=left+64 && center_y<=left+128) || (center_y-r<=left+128 && center_x>=down+128 && center_x<=down+192);
assign r7 = (center_x-r<=down+64 && center_y>=left+128 && center_y<=left+192) || (center_y-r<=left+192 && center_x>=down && center_x<=down+64);
assign r8 =  (center_x-r<=down+128 && center_y>=left+128 && center_y<=left+192) || (center_y-r<=left+192 && center_x>=down+64 && center_x<=down+128);
assign r9 = (center_x-r<=down+192 && center_y>=left+128 && center_y<=left+192) || (center_y-r<=left+192 && center_x>=down+128 && center_x<=down+192);


always@(posedge clock)
begin
	if(reset)
		c_down<=350;
	else if(KDATA==8'h74  && c_down<=904-length && (counter1==100000 || counter1==200000 || counter1==300000 || counter1==400000 || counter1==500000))
		c_down<=c_down+1;
	else if(KDATA==8'h6b  && c_down>=104 && (counter1==100000 || counter1==200000 || counter1==300000 || counter1==400000 || counter1==500000))
		c_down<=c_down-1;
	else
		c_down<=c_down;
end

always@(posedge clock)
begin
	if(reset)
		g1<=0;
	else if(center_x-r<=down+64 && center_y>=left && center_y<=left+64)
		g1<=1;
	else if(center_y-r<=left+64 && center_x>=down && center_x<=down+64)
		g1<=1;
	else 
		g1<=g1;
end

always@(posedge clock)
begin
	if(reset)
		g2<=0;
	else if(center_x-r<=down+128 && center_y>=left && center_y<=left+64)
		g2<=1;
	else if(center_y-r<=left+64 && center_x>=down+64 && center_x<=down+128)
		g2<=1;
	else 
		g2<=g2;
end
always@(posedge clock)
begin
	if(reset)
		g3<=0;
	else if(center_x-r<=down+192 && center_y>=left && center_y<=left+64)
		g3<=1;
	else if(center_y-r<=left+64 && center_x>=down+128 && center_x<=down+192)
		g3<=1;
	else 
		g3<=g3;
end
always@(posedge clock)
begin
	if(reset)
		g4<=0;
	else if(center_x-r<=down+64 && center_y>=left+64 && center_y<=left+128)
		g4<=1;
	else if(center_y-r<=left+128 && center_x>=down && center_x<=down+64)
		g4<=1;
	else 
		g4<=g4;
end
always@(posedge clock)
begin
	if(reset)
		g5<=0;
	else if(center_x-r<=down+128 && center_y>=left+64 && center_y<=left+128)
		g5<=1;
	else if(center_y-r<=left+128 && center_x>=down+64 && center_x<=down+128)
		g5<=1;
	else 
		g5<=g5;
end
always@(posedge clock)
begin
	if(reset)
		g6<=0;
	else if(center_x-r<=down+192 && center_y>=left+64 && center_y<=left+128)
		g6<=1;
	else if(center_y-r<=left+128 && center_x>=down+128 && center_x<=down+192)
		g6<=1;
	else 
		g6<=g6;
end
always@(posedge clock)
begin
	if(reset)
		g7<=0;
	else if(center_x-r<=down+64 && center_y>=left+128 && center_y<=left+192)
		g7<=1;
	else if(center_y-r<=left+192 && center_x>=down && center_x<=down+64)
		g7<=1;
	else 
		g7<=g7;
end
always@(posedge clock)
begin
	if(reset)
		g8<=0;
	else if(center_x-r<=down+128  && center_y>=left+128 && center_y<=left+192)
		g8<=1;
	else if(center_y-r<=left+192 && center_x>=down+64 && center_x<=down+128)
		g8<=1;
	else 
		g8<=g8;
end

always@(posedge clock)
begin
	if(reset)
		g9<=0;
	else if(center_x-r<=down+192 && center_y>=left+128 && center_y<=left+192)
		g9<=1;
	else if(center_y-r<=left+192 && center_x>=down+128 && center_x<=down+192)
		g9<=1;
	else 
		g9<=g9;
end

assign rr1 = ((center_x+r>=down+576) && center_y>=left && center_y<=left+64) || (center_y-r<=left+64 && (center_x<=down+640 && center_x>=down+576));
assign rr2 = (( center_x+r>=down+640) && center_y>=left && center_y<=left+64) || (center_y-r<=left+64 && (center_x<=down+704 &&center_x>=down+640));
assign rr3 = ((center_x+r>=down+704) && center_y>=left && center_y<=left+64) || (center_y-r<=left+64 && (center_x<=down+768 && center_x>=down+704));
assign rr4 = ((center_x+r>=down+576) && center_y>=left+64 && center_y<=left+128) || (center_y-r<=left+128 && (center_x<=down+640 && center_x>=down+576));
assign rr5 = ((center_x+r>=down+640) && center_y>=left+64 && center_y<=left+128) || (center_y-r<=left+128 && (center_x<=down+704 &&center_x>=down+640));
assign rr6 = ((center_x+r>=down+704) && center_y>=left+64 && center_y<=left+128) || (center_y-r<=left+128 && (center_x<=down+768 && center_x>=down+704));
assign rr7 = ((center_x+r>=down+576) && center_y>=left+128 && center_y<=left+192) || (center_y-r<=left+192 && (center_x<=down+640 && center_x>=down+576));
assign rr8 = ((center_x+r>=down+640) && center_y>=left+128 && center_y<=left+192) || (center_y-r<=left+192 && (center_x<=down+704 &&center_x>=down+640));
assign rr9 = ((center_x+r>=down+704) && center_y>=left+128 && center_y<=left+192) || (center_y-r<=left+192 && (center_x<=down+768 && center_x>=down+704));



always@(posedge clock)
begin
	if(reset)
		gg1<=0;
	else if(center_x+r>=down+576 && center_y>=left && center_y<=left+64)
		gg1<=1;
	else if(center_y-r<=left+64 && (center_x<=down+640 && center_x>=down+576))
		gg1<=1;
	else 
		gg1<=gg1;
end

always@(posedge clock)
begin
	if(reset)
		gg2<=0;
	else if( center_x+r>=down+640 && center_y>=left && center_y<=left+64)
		gg2<=1;
	else if(center_y-r<=left+64 && (center_x<=down+704 &&center_x>=down+640))
		gg2<=1;
	else 
		gg2<=gg2;
end
always@(posedge clock)
begin
	if(reset)
		gg3<=0;
	else if(( center_x+r>=down+704) && center_y>=left && center_y<=left+64)
		gg3<=1;
	else if(center_y-r<=left+64  && (center_x<=down+768 && center_x>=down+704))
		gg3<=1;
	else 
		gg3<=gg3;
end
always@(posedge clock)
begin
	if(reset)
		gg4<=0;
	else if((center_x+r>=down+576) && center_y>=left+64 && center_y<=left+128)
		gg4<=1;
	else if(center_y-r<=left+128  && (center_x<=down+640 &&center_x>=down+576))
		gg4<=1;
	else 
		gg4<=gg4;
end
always@(posedge clock)
begin
	if(reset)
		gg5<=0;
	else if((center_x+r>=down+640) && center_y>=left+64 && center_y<=left+128)
		gg5<=1;
	else if(center_y-r<=left+128  && (center_x<=down+704 && center_x>=down+640))
		gg5<=1;
	else 
		gg5<=gg5;
end
always@(posedge clock)
begin
	if(reset)
		gg6<=0;
	else if((center_x+r>=down+704) && center_y>=left+64 && center_y<=left+128)
		gg6<=1;
	else if(center_y-r<=left+128  && (center_x<=down+768 && center_x>=down+704))
		gg6<=1;
	else 
		gg6<=gg6;
end
always@(posedge clock)
begin
	if(reset)
		gg7<=0;
	else if((center_x+r>=down+576) && center_y>=left+128 && center_y<=left+192)
		gg7<=1;
	else if(center_y-r<=left+192  && (center_x<=down+640 && center_x>=down+576))
		gg7<=1;
	else 
		gg7<=gg7;
end
always@(posedge clock)
begin
	if(reset)
		gg8<=0;
	else if((center_x+r>=down+640) && center_y>=left+128 && center_y<=left+192)
		gg8<=1;
	else if(center_y-r<=left+192 && (center_x<=down+704 && center_x>=down+640))
		gg8<=1;
	else 
		gg8<=gg8;
end

always@(posedge clock)
begin
	if(reset)
		gg9<=0;
	else if(( center_x+r>=down+704) && center_y>=left+128 && center_y<=left+192)
		gg9<=1;
	else if(center_y-r<=left+192 && (center_x<=down+768 && center_x>=down+704))
		gg9<=1;
	else 
		gg9<=gg9;
end

reg restart;
reg [10:0] countre;

always @ (posedge clock)
begin
	if(reset)
		countre<=0;
	else if(counter1==522143)
		countre<=countre+1;
	else 
		counter1<=counter1;
end

always@(posedge clock)
begin
	if(reset)
		restart<=0;
	else if(KDATA==8'h29 && state==5)
		restart<=1;
	else if(countre==1)
		restart<=0;
	else 
		restart<=restart;
end

always @ (posedge clock)
 begin
		if(state==5)
			rgb_buffer = 3'b111;
		else if(state!=6) 
		begin
	   if((pixel_col >= down) & (pixel_col< down+64) & (pixel_row >= left) & (pixel_row < left+64) && g1==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+64) & (pixel_col< down+128) & (pixel_row >= left) & (pixel_row < left+64) &&g2==0)
			rgb_buffer = {~word1,1'b1,1'b1};
   	else if((pixel_col >= down+128) & (pixel_col< down+192) & (pixel_row >= left) & (pixel_row < left+64) && g3==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down) & (pixel_col< down+64) & (pixel_row >= left+64) & (pixel_row < left+128) && g4==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+64) & (pixel_col< down+128) & (pixel_row >= left+64) & (pixel_row < left+128) && g5==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+128) & (pixel_col< down+192) & (pixel_row >= left+64) & (pixel_row < left+128) && g6==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down) & (pixel_col< down+64) & (pixel_row >= left+128) & (pixel_row < left+192) && g7==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+64) & (pixel_col< down+128) & (pixel_row >= left+128) & (pixel_row < left+192) && g8==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+128) & (pixel_col< down+192) & (pixel_row >= left+128) & (pixel_row < left+192) && g9==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		
		else if((pixel_col >= down+576) & (pixel_col< down+640) & (pixel_row >= left) & (pixel_row < left+64) && gg1==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+640) & (pixel_col< down+704) & (pixel_row >= left) & (pixel_row < left+64) &&gg2==0)
			rgb_buffer = {~word1,1'b1,1'b1};
   	else if((pixel_col >= down+704) & (pixel_col< down+768) & (pixel_row >= left) & (pixel_row < left+64) && gg3==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+576) & (pixel_col< down+640) & (pixel_row >= left+64) & (pixel_row < left+128) && gg4==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+640) & (pixel_col< down+704) & (pixel_row >= left+64) & (pixel_row < left+128) && gg5==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+704) & (pixel_col< down+768) & (pixel_row >= left+64) & (pixel_row < left+128) && gg6==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+576) & (pixel_col< down+640) & (pixel_row >= left+128) & (pixel_row < left+192) && gg7==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+640) & (pixel_col< down+704) & (pixel_row >= left+128) & (pixel_row < left+192) && gg8==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col >= down+704) & (pixel_col< down+768) & (pixel_row >= left+128) & (pixel_row < left+192) && gg9==0)
			rgb_buffer = {~word1,1'b1,1'b1};
		else if((pixel_col-center_x)*(pixel_col-center_x)+(pixel_row-center_y)*(pixel_row-center_y)< area)      //ball size 
	      rgb_buffer = 3'b111;  
      else if((pixel_col >= down+256) & (pixel_col< down+384) & (pixel_row >= left+256) & (pixel_row < left+384) && restart==1)
			rgb_buffer = {word3,1'b0,1'b0};	 
		else if((pixel_col >= down+384) & (pixel_col< down+512) & (pixel_row >= left+256) & (pixel_row < left+384) && restart==1)
			rgb_buffer = {word4,1'b0,1'b0};	
		
		else if((pixel_col >= c_down) & (pixel_col< c_down+length) & (pixel_row >= 591) & (pixel_row < 623))
			rgb_buffer = {1'b1,1'b0,~word2};
	   
		else
		    rgb_buffer = 3'b000; 
		end
	  else if((pixel_col >= down+256) & (pixel_col< down+384) & (pixel_row >= left+256) & (pixel_row < left+384) && state==6)
			rgb_buffer = {1'b1,~word5,1'b0};	
	  else if((pixel_col >= down+384) & (pixel_col< down+512) & (pixel_row >= left+256) & (pixel_row < left+384) && state==6)
			rgb_buffer = {1'b1,~word6,1'b0};	
		else 
		rgb_buffer = 3'b000; 
end

always @ (posedge clock)begin 
  if(reset)                      state<=4; 
  else if(state!=5 && state!=4 && state!=6)
  begin
  if(center_y>=623-r-32 && state==1 && center_x>=c_down && center_x<=c_down+length)       state<=2; 
  else if(center_y>=623-r-32 && state==0 && center_x>=c_down && center_x<=c_down+length)       state<=3; 
  else if((center_y<=23+r || (r1 && ~g1) || (r2 && ~g2)|| (r3 && ~g3)|| (r4 && ~g4)|| (r5 && ~g5)|| (r6 && ~g6)|| (r7 && ~g7)|| (r8 && ~g8)|| (r9 && ~g9) || (rr1 && ~gg1) || (rr2 && ~gg2)|| (rr3 && ~gg3)|| (rr4 && ~gg4)|| (rr5 && ~gg5)|| (rr6 && ~gg6)|| (rr7 && ~gg7)|| (rr8 && ~gg8)|| (rr9 && ~gg9))&& state==3)        state<=0;  
  else if((center_x>=904-r || (r1 && ~g1) || (r2 && ~g2)|| (r3 && ~g3)|| (r4 && ~g4)|| (r5 && ~g5)|| (r6 && ~g6)|| (r7 && ~g7)|| (r8 && ~g8)|| (r9 && ~g9) || (rr1 && ~gg1) || (rr2 && ~gg2)|| (rr3 && ~gg3)|| (rr4 && ~gg4)|| (rr5 && ~gg5)|| (rr6 && ~gg6)|| (rr7 && ~gg7)|| (rr8 && ~gg8)|| (rr9 && ~gg9)) && state==0)       state<=1; 
  else if((center_x<=104+r  || (r1 && ~g1) || (r2 && ~g2)|| (r3 && ~g3)|| (r4 && ~g4)|| (r5 && ~g5)|| (r6 && ~g6)|| (r7 && ~g7)|| (r8 && ~g8)|| (r9 && ~g9) || (rr1 && ~gg1) || (rr2 && ~gg2)|| (rr3 && ~gg3)|| (rr4 && ~gg4)|| (rr5 && ~gg5)|| (rr6 && ~gg6)|| (rr7 && ~gg7)|| (rr8 && ~gg8)|| (rr9 && ~gg9))&& state==2)       state<=3; 
  else if((center_y>=623-r-32 || (r1 && ~g1) || (r2 && ~g2)|| (r3 && ~g3)|| (r4 && ~g4)|| (r5 && ~g5)|| (r6 && ~g6)|| (r7 && ~g7)|| (r8 && ~g8)|| (r9 && ~g9) || (rr1 && ~gg1) || (rr2 && ~gg2)|| (rr3 && ~gg3)|| (rr4 && ~gg4)|| (rr5 && ~gg5)|| (rr6 && ~gg6)|| (rr7 && ~gg7)|| (rr8 && ~gg8)|| (rr9 && ~gg9)) && state==0 && center_x>=c_down && center_x<=c_down+128)       state<=3; 
  else if((center_y<=23+r  || (r1 && ~g1) || (r2 && ~g2)|| (r3 && ~g3)|| (r4 && ~g4)|| (r5 && ~g5)|| (r6 && ~g6)|| (r7 && ~g7)|| (r8 && ~g8)|| (r9 && ~g9) || (rr1 && ~gg1) || (rr2 && ~gg2)|| (rr3 && ~gg3)|| (rr4 && ~gg4)|| (rr5 && ~gg5)|| (rr6 && ~gg6)|| (rr7 && ~gg7)|| (rr8 && ~gg8)|| (rr9 && ~gg9))&& state==2)        state<=1;  
  else if((center_x>=904-r  || (r1 && ~g1) || (r2 && ~g2)|| (r3 && ~g3)|| (r4 && ~g4)|| (r5 && ~g5)|| (r6 && ~g6)|| (r7 && ~g7)|| (r8 && ~g8)|| (r9 && ~g9) || (rr1 && ~gg1) || (rr2 && ~gg2)|| (rr3 && ~gg3)|| (rr4 && ~gg4)|| (rr5 && ~gg5)|| (rr6 && ~gg6)|| (rr7 && ~gg7)|| (rr8 && ~gg8)|| (rr9 && ~gg9))&& state==3)       state<=2; 
  else if((center_x<=104+r || (r1 && ~g1) || (r2 && ~g2)|| (r3 && ~g3)|| (r4 && ~g4)|| (r5 && ~g5)|| (r6 && ~g6)|| (r7 && ~g7)|| (r8 && ~g8)|| (r9 && ~g9) || (rr1 && ~gg1) || (rr2 && ~gg2)|| (rr3 && ~gg3)|| (rr4 && ~gg4)|| (rr5 && ~gg5)|| (rr6 && ~gg6)|| (rr7 && ~gg7)|| (rr8 && ~gg8)|| (rr9 && ~gg9)) && state==1)       state<=0; 
  else if(center_y>623) state<=5;
  else                         state<=state; 
  end
  else if(KDATA==8'h29 && state!=5 && state!=6)
	state<=2;
  else if(KDATA==8'h29 && state==5 && state!=6)
	state<=2;
  else if(g1+g2+g3+g4+g5+g6+g7+g8+g9+gg1+gg2+gg3+gg4+gg5+gg6+gg7+gg8+gg9==18)
	state<=6;
  else
		state<=state;
end 
//=============================================// 
//                          Design                                                    
//=============================================// 
reg [30:0] counter2,X;

always@(posedge clock)
begin
	if(reset)
		X<=322143;
	else if(g9==1)
		X<=150000;
	else
		X<=X;
end
always@(posedge clock)
begin
	if(reset)
		counter2<=0;
	else if(counter2==X)
		counter2<=0;
	else
		counter2<=counter2+1;
end
always @ (posedge clock)   
    begin 
        if(reset) begin 
        center_x <= c_down+length/2;        
        center_y <= 591-r;    
        end       
   else begin 
       if((counter2==X)&& state!=5)
		 begin 
       case(state)   
           0:begin center_x<=center_x+1;center_y <=center_y+1;end 
           1:begin center_x<=center_x-1;center_y <=center_y+1;end 
			  2:begin center_x<=center_x-1;center_y <=center_y-1;end 
           3:begin center_x<=center_x+1;center_y <=center_y-1;end
			  4:begin center_x<=c_down+length/2;center_y <=591-r; end     			
           default:begin center_x<=center_x;center_y <=center_y; end     
       endcase    
       end 
    end 
	 
end  

//////////////////////////////////
// Here control visible area /////
//////////////////////////////////

always @ (posedge clock) begin
	if (reset) begin
		pixel_col =0;
		row_Inc = 0;

	end  else	begin
	if (pixel_col == 1039)  begin
		row_Inc = 1;
		pixel_col = 0;
	end
     else 
		begin
		pixel_col = pixel_col + 1;
		row_Inc = 0;
		end				
end
end
always @ (posedge clock) begin
	if (reset) begin
		pixel_row =0;

	end  else	begin
	if (pixel_row == 665) 
		pixel_row = 0;
     else 	begin
		if(row_Inc == 1)
		pixel_row = pixel_row + 1;
		end					
end
end




assign hsync = ~((pixel_col >= 919) & (pixel_col < 1039) );

assign vsync = ~((pixel_row >= 659)&(pixel_row < 665)) ;

assign visible = ((pixel_col > 104) & (pixel_col <904 ) & (pixel_row > 23) & (pixel_row<623));   //c8  r6



always @(posedge clock)
begin
if (visible) 
  begin
    blue   = rgb_buffer[0];
	 red = rgb_buffer[1];
	 green  = rgb_buffer[2];
  end
else
	begin
	red   = 0;
	green = 0;
	blue  = 0;	
end
end
                                 
endmodule





module word_two(word,
			 row ,
			 col );
input [3:0]row;
input [3:0]col;
output word;
reg word;

wire [15:0]line_a,
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


assign line_a=16'b1111111111111111;
assign line_b=16'b1111111111111111;
assign line_c=16'b0000000000000000;
assign line_d=16'b0000000000000000;
assign line_e=16'b0000000000000000;
assign line_f=16'b0000000000000000;
assign line_g=16'b0000000000000000;
assign line_h=16'b0000000000000000;
assign line_i=16'b0000000000000000;
assign line_j=16'b0000000000000000;
assign line_k=16'b0000000000000000;
assign line_l=16'b0000000000000000;
assign line_m=16'b0000000000000000;
assign line_n=16'b0000000000000000;
assign line_o=16'b0000000000000000;
assign line_p=16'b0000000000000000;



always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or
           line_g or  line_h or  line_i or  line_j or line_k or line_l or line_m or
		 line_n or  line_o or line_p)
begin
	case   ({row,col})
	8'b0000_0000: 	word <= line_a[15];
	8'b0000_0001: 	word <= line_a[14];
	8'b0000_0010: 	word <= line_a[13];
	8'b0000_0011: 	word <= line_a[12];
	8'b0000_0100: 	word <= line_a[11];
	8'b0000_0101: 	word <= line_a[10];
	8'b0000_0110: 	word <= line_a[9];
	8'b0000_0111: 	word <= line_a[8];
	8'b0000_1000: 	word <= line_a[7];
	8'b0000_1001: 	word <= line_a[6];
	8'b0000_1010: 	word <= line_a[5];
	8'b0000_1011: 	word <= line_a[4];
	8'b0000_1100: 	word <= line_a[3];
	8'b0000_1101: 	word <= line_a[2];
	8'b0000_1110: 	word <= line_a[1];
	8'b0000_1111: 	word <= line_a[0];

	8'b0001_0000: 	word <= line_b[15];
	8'b0001_0001: 	word <= line_b[14];
	8'b0001_0010: 	word <= line_b[13];
	8'b0001_0011: 	word <= line_b[12];
	8'b0001_0100: 	word <= line_b[11];
	8'b0001_0101: 	word <= line_b[10];
	8'b0001_0110: 	word <= line_b[9];
	8'b0001_0111: 	word <= line_b[8];
	8'b0001_1000: 	word <= line_b[7];
	8'b0001_1001: 	word <= line_b[6];
	8'b0001_1010: 	word <= line_b[5];
	8'b0001_1011: 	word <= line_b[4];
	8'b0001_1100: 	word <= line_b[3];
	8'b0001_1101: 	word <= line_b[2];
	8'b0001_1110: 	word <= line_b[1];
	8'b0001_1111: 	word <= line_b[0];	

	8'b0010_0000: 	word <= line_c[15];
	8'b0010_0001: 	word <= line_c[14];
	8'b0010_0010: 	word <= line_c[13];
	8'b0010_0011: 	word <= line_c[12];
	8'b0010_0100: 	word <= line_c[11];
	8'b0010_0101: 	word <= line_c[10];
	8'b0010_0110: 	word <= line_c[9];
	8'b0010_0111: 	word <= line_c[8];
	8'b0010_1000: 	word <= line_c[7];
	8'b0010_1001: 	word <= line_c[6];
	8'b0010_1010: 	word <= line_c[5];
	8'b0010_1011: 	word <= line_c[4];
	8'b0010_1100: 	word <= line_c[3];
	8'b0010_1101: 	word <= line_c[2];
	8'b0010_1110: 	word <= line_c[1];
	8'b0010_1111: 	word <= line_c[0];

  	8'b0011_0000: 	word <= line_d[15];
	8'b0011_0001: 	word <= line_d[14];
	8'b0011_0010: 	word <= line_d[13];
	8'b0011_0011: 	word <= line_d[12];
	8'b0011_0100: 	word <= line_d[11];
	8'b0011_0101: 	word <= line_d[10];
	8'b0011_0110: 	word <= line_d[9];
	8'b0011_0111: 	word <= line_d[8];
	8'b0011_1000: 	word <= line_d[7];
	8'b0011_1001: 	word <= line_d[6];
	8'b0011_1010: 	word <= line_d[5];
	8'b0011_1011: 	word <= line_d[4];
	8'b0011_1100: 	word <= line_d[3];
	8'b0011_1101: 	word <= line_d[2];
	8'b0011_1110: 	word <= line_d[1];
	8'b0011_1111: 	word <= line_d[0];

 	8'b0100_0000: 	word <= line_e[15];
	8'b0100_0001: 	word <= line_e[14];
	8'b0100_0010: 	word <= line_e[13];
	8'b0100_0011: 	word <= line_e[12];
	8'b0100_0100: 	word <= line_e[11];
	8'b0100_0101: 	word <= line_e[10];
	8'b0100_0110: 	word <= line_e[9];
	8'b0100_0111: 	word <= line_e[8];
	8'b0100_1000: 	word <= line_e[7];
	8'b0100_1001: 	word <= line_e[6];
	8'b0100_1010: 	word <= line_e[5];
	8'b0100_1011: 	word <= line_e[4];
	8'b0100_1100: 	word <= line_e[3];
	8'b0100_1101: 	word <= line_e[2];
	8'b0100_1110: 	word <= line_e[1];
	8'b0100_1111: 	word <= line_e[0];

 	8'b0101_0000: 	word <= line_f[15];
	8'b0101_0001: 	word <= line_f[14];
	8'b0101_0010: 	word <= line_f[13];
	8'b0101_0011: 	word <= line_f[12];
	8'b0101_0100: 	word <= line_f[11];
	8'b0101_0101: 	word <= line_f[10];
	8'b0101_0110: 	word <= line_f[9];
	8'b0101_0111: 	word <= line_f[8];
	8'b0101_1000: 	word <= line_f[7];
	8'b0101_1001: 	word <= line_f[6];
	8'b0101_1010: 	word <= line_f[5];
	8'b0101_1011: 	word <= line_f[4];
	8'b0101_1100: 	word <= line_f[3];
	8'b0101_1101: 	word <= line_f[2];
	8'b0101_1110: 	word <= line_f[1];
	8'b0101_1111: 	word <= line_f[0];

 	8'b0110_0000: 	word <= line_g[15];
	8'b0110_0001: 	word <= line_g[14];
	8'b0110_0010: 	word <= line_g[13];
	8'b0110_0011: 	word <= line_g[12];
	8'b0110_0100: 	word <= line_g[11];
	8'b0110_0101: 	word <= line_g[10];
	8'b0110_0110: 	word <= line_g[9];
	8'b0110_0111: 	word <= line_g[8];
	8'b0110_1000: 	word <= line_g[7];
	8'b0110_1001: 	word <= line_g[6];
	8'b0110_1010: 	word <= line_g[5];
	8'b0110_1011: 	word <= line_g[4];
	8'b0110_1100: 	word <= line_g[3];
	8'b0110_1101: 	word <= line_g[2];
	8'b0110_1110: 	word <= line_g[1];
	8'b0110_1111: 	word <= line_g[0];

	8'b0111_0000: 	word <= line_h[15];
	8'b0111_0001: 	word <= line_h[14];
	8'b0111_0010: 	word <= line_h[13];
	8'b0111_0011: 	word <= line_h[12];
	8'b0111_0100: 	word <= line_h[11];
	8'b0111_0101: 	word <= line_h[10];
	8'b0111_0110: 	word <= line_h[9];
	8'b0111_0111: 	word <= line_h[8];
	8'b0111_1000: 	word <= line_h[7];
	8'b0111_1001: 	word <= line_h[6];
	8'b0111_1010: 	word <= line_h[5];
	8'b0111_1011: 	word <= line_h[4];
	8'b0111_1100: 	word <= line_h[3];
	8'b0111_1101: 	word <= line_h[2];
	8'b0111_1110: 	word <= line_h[1];
	8'b0111_1111: 	word <= line_h[0];

 
	8'b1000_0000: 	word <= line_i[15];
	8'b1000_0001: 	word <= line_i[14];
	8'b1000_0010: 	word <= line_i[13];
	8'b1000_0011: 	word <= line_i[12];
	8'b1000_0100: 	word <= line_i[11];
	8'b1000_0101: 	word <= line_i[10];
	8'b1000_0110: 	word <= line_i[9];
	8'b1000_0111: 	word <= line_i[8];
	8'b1000_1000: 	word <= line_i[7];
	8'b1000_1001: 	word <= line_i[6];
	8'b1000_1010: 	word <= line_i[5];
	8'b1000_1011: 	word <= line_i[4];
	8'b1000_1100: 	word <= line_i[3];
	8'b1000_1101: 	word <= line_i[2];
	8'b1000_1110: 	word <= line_i[1];
	8'b1000_1111: 	word <= line_i[0];

	8'b1001_0000: 	word <= line_j[15];
	8'b1001_0001: 	word <= line_j[14];
	8'b1001_0010: 	word <= line_j[13];
	8'b1001_0011: 	word <= line_j[12];
	8'b1001_0100: 	word <= line_j[11];
	8'b1001_0101: 	word <= line_j[10];
	8'b1001_0110: 	word <= line_j[9];
	8'b1001_0111: 	word <= line_j[8];
	8'b1001_1000: 	word <= line_j[7];
	8'b1001_1001: 	word <= line_j[6];
	8'b1001_1010: 	word <= line_j[5];
	8'b1001_1011: 	word <= line_j[4];
	8'b1001_1100: 	word <= line_j[3];
	8'b1001_1101: 	word <= line_j[2];
	8'b1001_1110: 	word <= line_j[1];
	8'b1001_1111: 	word <= line_j[0];	

	8'b1010_0000: 	word <= line_k[15];
	8'b1010_0001: 	word <= line_k[14];
	8'b1010_0010: 	word <= line_k[13];
	8'b1010_0011: 	word <= line_k[12];
	8'b1010_0100: 	word <= line_k[11];
	8'b1010_0101: 	word <= line_k[10];
	8'b1010_0110: 	word <= line_k[9];
	8'b1010_0111: 	word <= line_k[8];
	8'b1010_1000: 	word <= line_k[7];
	8'b1010_1001: 	word <= line_k[6];
	8'b1010_1010: 	word <= line_k[5];
	8'b1010_1011: 	word <= line_k[4];
	8'b1010_1100: 	word <= line_k[3];
	8'b1010_1101: 	word <= line_k[2];
	8'b1010_1110: 	word <= line_k[1];
	8'b1010_1111: 	word <= line_k[0];

  	8'b1011_0000: 	word <= line_l[15];
	8'b1011_0001: 	word <= line_l[14];
	8'b1011_0010: 	word <= line_l[13];
	8'b1011_0011: 	word <= line_l[12];
	8'b1011_0100: 	word <= line_l[11];
	8'b1011_0101: 	word <= line_l[10];
	8'b1011_0110: 	word <= line_l[9];
	8'b1011_0111: 	word <= line_l[8];
	8'b1011_1000: 	word <= line_l[7];
	8'b1011_1001: 	word <= line_l[6];
	8'b1011_1010: 	word <= line_l[5];
	8'b1011_1011: 	word <= line_l[4];
	8'b1011_1100: 	word <= line_l[3];
	8'b1011_1101: 	word <= line_l[2];
	8'b1011_1110: 	word <= line_l[1];
	8'b1011_1111: 	word <= line_l[0];

 	8'b1100_0000: 	word <= line_m[15];
	8'b1100_0001: 	word <= line_m[14];
	8'b1100_0010: 	word <= line_m[13];
	8'b1100_0011: 	word <= line_m[12];
	8'b1100_0100: 	word <= line_m[11];
	8'b1100_0101: 	word <= line_m[10];
	8'b1100_0110: 	word <= line_m[9];
	8'b1100_0111: 	word <= line_m[8];
	8'b1100_1000: 	word <= line_m[7];
	8'b1100_1001: 	word <= line_m[6];
	8'b1100_1010: 	word <= line_m[5];
	8'b1100_1011: 	word <= line_m[4];
	8'b1100_1100: 	word <= line_m[3];
	8'b1100_1101: 	word <= line_m[2];
	8'b1100_1110: 	word <= line_m[1];
	8'b1100_1111: 	word <= line_m[0];

 	8'b1101_0000: 	word <= line_n[15];
	8'b1101_0001: 	word <= line_n[14];
	8'b1101_0010: 	word <= line_n[13];
	8'b1101_0011: 	word <= line_n[12];
	8'b1101_0100: 	word <= line_n[11];
	8'b1101_0101: 	word <= line_n[10];
	8'b1101_0110: 	word <= line_n[9];
	8'b1101_0111: 	word <= line_n[8];
	8'b1101_1000: 	word <= line_n[7];
	8'b1101_1001: 	word <= line_n[6];
	8'b1101_1010: 	word <= line_n[5];
	8'b1101_1011: 	word <= line_n[4];
	8'b1101_1100: 	word <= line_n[3];
	8'b1101_1101: 	word <= line_n[2];
	8'b1101_1110: 	word <= line_n[1];
	8'b1101_1111: 	word <= line_n[0];

 	8'b1110_0000: 	word <= line_o[15];
	8'b1110_0001: 	word <= line_o[14];
	8'b1110_0010: 	word <= line_o[13];
	8'b1110_0011: 	word <= line_o[12];
	8'b1110_0100: 	word <= line_o[11];
	8'b1110_0101: 	word <= line_o[10];
	8'b1110_0110: 	word <= line_o[9];
	8'b1110_0111: 	word <= line_o[8];
	8'b1110_1000: 	word <= line_o[7];
	8'b1110_1001: 	word <= line_o[6];
	8'b1110_1010: 	word <= line_o[5];
	8'b1110_1011: 	word <= line_o[4];
	8'b1110_1100: 	word <= line_o[3];
	8'b1110_1101: 	word <= line_o[2];
	8'b1110_1110: 	word <= line_o[1];
	8'b1110_1111: 	word <= line_o[0];

	8'b1111_0000: 	word <= line_p[15];
	8'b1111_0001: 	word <= line_p[14];
	8'b1111_0010: 	word <= line_p[13];
	8'b1111_0011: 	word <= line_p[12];
	8'b1111_0100: 	word <= line_p[11];
	8'b1111_0101: 	word <= line_p[10];
	8'b1111_0110: 	word <= line_p[9];
	8'b1111_0111: 	word <= line_p[8];
	8'b1111_1000: 	word <= line_p[7];
	8'b1111_1001: 	word <= line_p[6];
	8'b1111_1010: 	word <= line_p[5];
	8'b1111_1011: 	word <= line_p[4];
	8'b1111_1100: 	word <= line_p[3];
	8'b1111_1101: 	word <= line_p[2];
	8'b1111_1110: 	word <= line_p[1];
	8'b1111_1111: 	word <= line_p[0];


	endcase
end


endmodule

module word_one(word,
			 row ,
			 col );
input [3:0]row;
input [3:0]col;
output word;
reg word;

wire [15:0]line_a,
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


assign line_a=16'b0000010000010000;
assign line_b=16'b0000010000010000;
assign line_c=16'b0000010000010000;
assign line_d=16'b1111111111111111;
assign line_e=16'b0010000010000010;
assign line_f=16'b0010000010000010;
assign line_g=16'b0010000010000010;
assign line_h=16'b1111111111111111;
assign line_i=16'b0100001000001000;
assign line_j=16'b0100001000001000;
assign line_k=16'b0100001000001000;
assign line_l=16'b1111111111111111;
assign line_m=16'b0001000010000100;
assign line_n=16'b0001000010000100;
assign line_o=16'b0001000010000100;
assign line_p=16'b1111111111111111;



always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or
           line_g or  line_h or  line_i or  line_j or line_k or line_l or line_m or
		 line_n or  line_o or line_p)
begin
	case   ({row,col})
	8'b0000_0000: 	word <= line_a[15];
	8'b0000_0001: 	word <= line_a[14];
	8'b0000_0010: 	word <= line_a[13];
	8'b0000_0011: 	word <= line_a[12];
	8'b0000_0100: 	word <= line_a[11];
	8'b0000_0101: 	word <= line_a[10];
	8'b0000_0110: 	word <= line_a[9];
	8'b0000_0111: 	word <= line_a[8];
	8'b0000_1000: 	word <= line_a[7];
	8'b0000_1001: 	word <= line_a[6];
	8'b0000_1010: 	word <= line_a[5];
	8'b0000_1011: 	word <= line_a[4];
	8'b0000_1100: 	word <= line_a[3];
	8'b0000_1101: 	word <= line_a[2];
	8'b0000_1110: 	word <= line_a[1];
	8'b0000_1111: 	word <= line_a[0];

	8'b0001_0000: 	word <= line_b[15];
	8'b0001_0001: 	word <= line_b[14];
	8'b0001_0010: 	word <= line_b[13];
	8'b0001_0011: 	word <= line_b[12];
	8'b0001_0100: 	word <= line_b[11];
	8'b0001_0101: 	word <= line_b[10];
	8'b0001_0110: 	word <= line_b[9];
	8'b0001_0111: 	word <= line_b[8];
	8'b0001_1000: 	word <= line_b[7];
	8'b0001_1001: 	word <= line_b[6];
	8'b0001_1010: 	word <= line_b[5];
	8'b0001_1011: 	word <= line_b[4];
	8'b0001_1100: 	word <= line_b[3];
	8'b0001_1101: 	word <= line_b[2];
	8'b0001_1110: 	word <= line_b[1];
	8'b0001_1111: 	word <= line_b[0];	

	8'b0010_0000: 	word <= line_c[15];
	8'b0010_0001: 	word <= line_c[14];
	8'b0010_0010: 	word <= line_c[13];
	8'b0010_0011: 	word <= line_c[12];
	8'b0010_0100: 	word <= line_c[11];
	8'b0010_0101: 	word <= line_c[10];
	8'b0010_0110: 	word <= line_c[9];
	8'b0010_0111: 	word <= line_c[8];
	8'b0010_1000: 	word <= line_c[7];
	8'b0010_1001: 	word <= line_c[6];
	8'b0010_1010: 	word <= line_c[5];
	8'b0010_1011: 	word <= line_c[4];
	8'b0010_1100: 	word <= line_c[3];
	8'b0010_1101: 	word <= line_c[2];
	8'b0010_1110: 	word <= line_c[1];
	8'b0010_1111: 	word <= line_c[0];

  	8'b0011_0000: 	word <= line_d[15];
	8'b0011_0001: 	word <= line_d[14];
	8'b0011_0010: 	word <= line_d[13];
	8'b0011_0011: 	word <= line_d[12];
	8'b0011_0100: 	word <= line_d[11];
	8'b0011_0101: 	word <= line_d[10];
	8'b0011_0110: 	word <= line_d[9];
	8'b0011_0111: 	word <= line_d[8];
	8'b0011_1000: 	word <= line_d[7];
	8'b0011_1001: 	word <= line_d[6];
	8'b0011_1010: 	word <= line_d[5];
	8'b0011_1011: 	word <= line_d[4];
	8'b0011_1100: 	word <= line_d[3];
	8'b0011_1101: 	word <= line_d[2];
	8'b0011_1110: 	word <= line_d[1];
	8'b0011_1111: 	word <= line_d[0];

 	8'b0100_0000: 	word <= line_e[15];
	8'b0100_0001: 	word <= line_e[14];
	8'b0100_0010: 	word <= line_e[13];
	8'b0100_0011: 	word <= line_e[12];
	8'b0100_0100: 	word <= line_e[11];
	8'b0100_0101: 	word <= line_e[10];
	8'b0100_0110: 	word <= line_e[9];
	8'b0100_0111: 	word <= line_e[8];
	8'b0100_1000: 	word <= line_e[7];
	8'b0100_1001: 	word <= line_e[6];
	8'b0100_1010: 	word <= line_e[5];
	8'b0100_1011: 	word <= line_e[4];
	8'b0100_1100: 	word <= line_e[3];
	8'b0100_1101: 	word <= line_e[2];
	8'b0100_1110: 	word <= line_e[1];
	8'b0100_1111: 	word <= line_e[0];

 	8'b0101_0000: 	word <= line_f[15];
	8'b0101_0001: 	word <= line_f[14];
	8'b0101_0010: 	word <= line_f[13];
	8'b0101_0011: 	word <= line_f[12];
	8'b0101_0100: 	word <= line_f[11];
	8'b0101_0101: 	word <= line_f[10];
	8'b0101_0110: 	word <= line_f[9];
	8'b0101_0111: 	word <= line_f[8];
	8'b0101_1000: 	word <= line_f[7];
	8'b0101_1001: 	word <= line_f[6];
	8'b0101_1010: 	word <= line_f[5];
	8'b0101_1011: 	word <= line_f[4];
	8'b0101_1100: 	word <= line_f[3];
	8'b0101_1101: 	word <= line_f[2];
	8'b0101_1110: 	word <= line_f[1];
	8'b0101_1111: 	word <= line_f[0];

 	8'b0110_0000: 	word <= line_g[15];
	8'b0110_0001: 	word <= line_g[14];
	8'b0110_0010: 	word <= line_g[13];
	8'b0110_0011: 	word <= line_g[12];
	8'b0110_0100: 	word <= line_g[11];
	8'b0110_0101: 	word <= line_g[10];
	8'b0110_0110: 	word <= line_g[9];
	8'b0110_0111: 	word <= line_g[8];
	8'b0110_1000: 	word <= line_g[7];
	8'b0110_1001: 	word <= line_g[6];
	8'b0110_1010: 	word <= line_g[5];
	8'b0110_1011: 	word <= line_g[4];
	8'b0110_1100: 	word <= line_g[3];
	8'b0110_1101: 	word <= line_g[2];
	8'b0110_1110: 	word <= line_g[1];
	8'b0110_1111: 	word <= line_g[0];

	8'b0111_0000: 	word <= line_h[15];
	8'b0111_0001: 	word <= line_h[14];
	8'b0111_0010: 	word <= line_h[13];
	8'b0111_0011: 	word <= line_h[12];
	8'b0111_0100: 	word <= line_h[11];
	8'b0111_0101: 	word <= line_h[10];
	8'b0111_0110: 	word <= line_h[9];
	8'b0111_0111: 	word <= line_h[8];
	8'b0111_1000: 	word <= line_h[7];
	8'b0111_1001: 	word <= line_h[6];
	8'b0111_1010: 	word <= line_h[5];
	8'b0111_1011: 	word <= line_h[4];
	8'b0111_1100: 	word <= line_h[3];
	8'b0111_1101: 	word <= line_h[2];
	8'b0111_1110: 	word <= line_h[1];
	8'b0111_1111: 	word <= line_h[0];

 
	8'b1000_0000: 	word <= line_i[15];
	8'b1000_0001: 	word <= line_i[14];
	8'b1000_0010: 	word <= line_i[13];
	8'b1000_0011: 	word <= line_i[12];
	8'b1000_0100: 	word <= line_i[11];
	8'b1000_0101: 	word <= line_i[10];
	8'b1000_0110: 	word <= line_i[9];
	8'b1000_0111: 	word <= line_i[8];
	8'b1000_1000: 	word <= line_i[7];
	8'b1000_1001: 	word <= line_i[6];
	8'b1000_1010: 	word <= line_i[5];
	8'b1000_1011: 	word <= line_i[4];
	8'b1000_1100: 	word <= line_i[3];
	8'b1000_1101: 	word <= line_i[2];
	8'b1000_1110: 	word <= line_i[1];
	8'b1000_1111: 	word <= line_i[0];

	8'b1001_0000: 	word <= line_j[15];
	8'b1001_0001: 	word <= line_j[14];
	8'b1001_0010: 	word <= line_j[13];
	8'b1001_0011: 	word <= line_j[12];
	8'b1001_0100: 	word <= line_j[11];
	8'b1001_0101: 	word <= line_j[10];
	8'b1001_0110: 	word <= line_j[9];
	8'b1001_0111: 	word <= line_j[8];
	8'b1001_1000: 	word <= line_j[7];
	8'b1001_1001: 	word <= line_j[6];
	8'b1001_1010: 	word <= line_j[5];
	8'b1001_1011: 	word <= line_j[4];
	8'b1001_1100: 	word <= line_j[3];
	8'b1001_1101: 	word <= line_j[2];
	8'b1001_1110: 	word <= line_j[1];
	8'b1001_1111: 	word <= line_j[0];	

	8'b1010_0000: 	word <= line_k[15];
	8'b1010_0001: 	word <= line_k[14];
	8'b1010_0010: 	word <= line_k[13];
	8'b1010_0011: 	word <= line_k[12];
	8'b1010_0100: 	word <= line_k[11];
	8'b1010_0101: 	word <= line_k[10];
	8'b1010_0110: 	word <= line_k[9];
	8'b1010_0111: 	word <= line_k[8];
	8'b1010_1000: 	word <= line_k[7];
	8'b1010_1001: 	word <= line_k[6];
	8'b1010_1010: 	word <= line_k[5];
	8'b1010_1011: 	word <= line_k[4];
	8'b1010_1100: 	word <= line_k[3];
	8'b1010_1101: 	word <= line_k[2];
	8'b1010_1110: 	word <= line_k[1];
	8'b1010_1111: 	word <= line_k[0];

  	8'b1011_0000: 	word <= line_l[15];
	8'b1011_0001: 	word <= line_l[14];
	8'b1011_0010: 	word <= line_l[13];
	8'b1011_0011: 	word <= line_l[12];
	8'b1011_0100: 	word <= line_l[11];
	8'b1011_0101: 	word <= line_l[10];
	8'b1011_0110: 	word <= line_l[9];
	8'b1011_0111: 	word <= line_l[8];
	8'b1011_1000: 	word <= line_l[7];
	8'b1011_1001: 	word <= line_l[6];
	8'b1011_1010: 	word <= line_l[5];
	8'b1011_1011: 	word <= line_l[4];
	8'b1011_1100: 	word <= line_l[3];
	8'b1011_1101: 	word <= line_l[2];
	8'b1011_1110: 	word <= line_l[1];
	8'b1011_1111: 	word <= line_l[0];

 	8'b1100_0000: 	word <= line_m[15];
	8'b1100_0001: 	word <= line_m[14];
	8'b1100_0010: 	word <= line_m[13];
	8'b1100_0011: 	word <= line_m[12];
	8'b1100_0100: 	word <= line_m[11];
	8'b1100_0101: 	word <= line_m[10];
	8'b1100_0110: 	word <= line_m[9];
	8'b1100_0111: 	word <= line_m[8];
	8'b1100_1000: 	word <= line_m[7];
	8'b1100_1001: 	word <= line_m[6];
	8'b1100_1010: 	word <= line_m[5];
	8'b1100_1011: 	word <= line_m[4];
	8'b1100_1100: 	word <= line_m[3];
	8'b1100_1101: 	word <= line_m[2];
	8'b1100_1110: 	word <= line_m[1];
	8'b1100_1111: 	word <= line_m[0];

 	8'b1101_0000: 	word <= line_n[15];
	8'b1101_0001: 	word <= line_n[14];
	8'b1101_0010: 	word <= line_n[13];
	8'b1101_0011: 	word <= line_n[12];
	8'b1101_0100: 	word <= line_n[11];
	8'b1101_0101: 	word <= line_n[10];
	8'b1101_0110: 	word <= line_n[9];
	8'b1101_0111: 	word <= line_n[8];
	8'b1101_1000: 	word <= line_n[7];
	8'b1101_1001: 	word <= line_n[6];
	8'b1101_1010: 	word <= line_n[5];
	8'b1101_1011: 	word <= line_n[4];
	8'b1101_1100: 	word <= line_n[3];
	8'b1101_1101: 	word <= line_n[2];
	8'b1101_1110: 	word <= line_n[1];
	8'b1101_1111: 	word <= line_n[0];

 	8'b1110_0000: 	word <= line_o[15];
	8'b1110_0001: 	word <= line_o[14];
	8'b1110_0010: 	word <= line_o[13];
	8'b1110_0011: 	word <= line_o[12];
	8'b1110_0100: 	word <= line_o[11];
	8'b1110_0101: 	word <= line_o[10];
	8'b1110_0110: 	word <= line_o[9];
	8'b1110_0111: 	word <= line_o[8];
	8'b1110_1000: 	word <= line_o[7];
	8'b1110_1001: 	word <= line_o[6];
	8'b1110_1010: 	word <= line_o[5];
	8'b1110_1011: 	word <= line_o[4];
	8'b1110_1100: 	word <= line_o[3];
	8'b1110_1101: 	word <= line_o[2];
	8'b1110_1110: 	word <= line_o[1];
	8'b1110_1111: 	word <= line_o[0];

	8'b1111_0000: 	word <= line_p[15];
	8'b1111_0001: 	word <= line_p[14];
	8'b1111_0010: 	word <= line_p[13];
	8'b1111_0011: 	word <= line_p[12];
	8'b1111_0100: 	word <= line_p[11];
	8'b1111_0101: 	word <= line_p[10];
	8'b1111_0110: 	word <= line_p[9];
	8'b1111_0111: 	word <= line_p[8];
	8'b1111_1000: 	word <= line_p[7];
	8'b1111_1001: 	word <= line_p[6];
	8'b1111_1010: 	word <= line_p[5];
	8'b1111_1011: 	word <= line_p[4];
	8'b1111_1100: 	word <= line_p[3];
	8'b1111_1101: 	word <= line_p[2];
	8'b1111_1110: 	word <= line_p[1];
	8'b1111_1111: 	word <= line_p[0];


	endcase
end
endmodule

module word_three(word,
			 row ,
			 col );
input [3:0]row;
input [3:0]col;
output word;
reg word;

wire [15:0]line_a,
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


assign line_a=16'b0000000000000000;
assign line_b=16'b0000001110000000;
assign line_c=16'b0000000000000000;
assign line_d=16'b0000111111100000;
assign line_e=16'b0000000100000000;
assign line_f=16'b0000011111000000;
assign line_g=16'b0000010101000000;
assign line_h=16'b0000011111000000;
assign line_i=16'b0000010101000000;
assign line_j=16'b0000011111000000;
assign line_k=16'b0000000100000000;
assign line_l=16'b0000011111000000;
assign line_m=16'b0000000100000000;
assign line_n=16'b0000111111100000;
assign line_o=16'b0000000000000000;
assign line_p=16'b0000000000000000;



always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or
           line_g or  line_h or  line_i or  line_j or line_k or line_l or line_m or
		 line_n or  line_o or line_p)
begin
	case   ({row,col})
	8'b0000_0000: 	word <= line_a[15];
	8'b0000_0001: 	word <= line_a[14];
	8'b0000_0010: 	word <= line_a[13];
	8'b0000_0011: 	word <= line_a[12];
	8'b0000_0100: 	word <= line_a[11];
	8'b0000_0101: 	word <= line_a[10];
	8'b0000_0110: 	word <= line_a[9];
	8'b0000_0111: 	word <= line_a[8];
	8'b0000_1000: 	word <= line_a[7];
	8'b0000_1001: 	word <= line_a[6];
	8'b0000_1010: 	word <= line_a[5];
	8'b0000_1011: 	word <= line_a[4];
	8'b0000_1100: 	word <= line_a[3];
	8'b0000_1101: 	word <= line_a[2];
	8'b0000_1110: 	word <= line_a[1];
	8'b0000_1111: 	word <= line_a[0];

	8'b0001_0000: 	word <= line_b[15];
	8'b0001_0001: 	word <= line_b[14];
	8'b0001_0010: 	word <= line_b[13];
	8'b0001_0011: 	word <= line_b[12];
	8'b0001_0100: 	word <= line_b[11];
	8'b0001_0101: 	word <= line_b[10];
	8'b0001_0110: 	word <= line_b[9];
	8'b0001_0111: 	word <= line_b[8];
	8'b0001_1000: 	word <= line_b[7];
	8'b0001_1001: 	word <= line_b[6];
	8'b0001_1010: 	word <= line_b[5];
	8'b0001_1011: 	word <= line_b[4];
	8'b0001_1100: 	word <= line_b[3];
	8'b0001_1101: 	word <= line_b[2];
	8'b0001_1110: 	word <= line_b[1];
	8'b0001_1111: 	word <= line_b[0];	

	8'b0010_0000: 	word <= line_c[15];
	8'b0010_0001: 	word <= line_c[14];
	8'b0010_0010: 	word <= line_c[13];
	8'b0010_0011: 	word <= line_c[12];
	8'b0010_0100: 	word <= line_c[11];
	8'b0010_0101: 	word <= line_c[10];
	8'b0010_0110: 	word <= line_c[9];
	8'b0010_0111: 	word <= line_c[8];
	8'b0010_1000: 	word <= line_c[7];
	8'b0010_1001: 	word <= line_c[6];
	8'b0010_1010: 	word <= line_c[5];
	8'b0010_1011: 	word <= line_c[4];
	8'b0010_1100: 	word <= line_c[3];
	8'b0010_1101: 	word <= line_c[2];
	8'b0010_1110: 	word <= line_c[1];
	8'b0010_1111: 	word <= line_c[0];

  	8'b0011_0000: 	word <= line_d[15];
	8'b0011_0001: 	word <= line_d[14];
	8'b0011_0010: 	word <= line_d[13];
	8'b0011_0011: 	word <= line_d[12];
	8'b0011_0100: 	word <= line_d[11];
	8'b0011_0101: 	word <= line_d[10];
	8'b0011_0110: 	word <= line_d[9];
	8'b0011_0111: 	word <= line_d[8];
	8'b0011_1000: 	word <= line_d[7];
	8'b0011_1001: 	word <= line_d[6];
	8'b0011_1010: 	word <= line_d[5];
	8'b0011_1011: 	word <= line_d[4];
	8'b0011_1100: 	word <= line_d[3];
	8'b0011_1101: 	word <= line_d[2];
	8'b0011_1110: 	word <= line_d[1];
	8'b0011_1111: 	word <= line_d[0];

 	8'b0100_0000: 	word <= line_e[15];
	8'b0100_0001: 	word <= line_e[14];
	8'b0100_0010: 	word <= line_e[13];
	8'b0100_0011: 	word <= line_e[12];
	8'b0100_0100: 	word <= line_e[11];
	8'b0100_0101: 	word <= line_e[10];
	8'b0100_0110: 	word <= line_e[9];
	8'b0100_0111: 	word <= line_e[8];
	8'b0100_1000: 	word <= line_e[7];
	8'b0100_1001: 	word <= line_e[6];
	8'b0100_1010: 	word <= line_e[5];
	8'b0100_1011: 	word <= line_e[4];
	8'b0100_1100: 	word <= line_e[3];
	8'b0100_1101: 	word <= line_e[2];
	8'b0100_1110: 	word <= line_e[1];
	8'b0100_1111: 	word <= line_e[0];

 	8'b0101_0000: 	word <= line_f[15];
	8'b0101_0001: 	word <= line_f[14];
	8'b0101_0010: 	word <= line_f[13];
	8'b0101_0011: 	word <= line_f[12];
	8'b0101_0100: 	word <= line_f[11];
	8'b0101_0101: 	word <= line_f[10];
	8'b0101_0110: 	word <= line_f[9];
	8'b0101_0111: 	word <= line_f[8];
	8'b0101_1000: 	word <= line_f[7];
	8'b0101_1001: 	word <= line_f[6];
	8'b0101_1010: 	word <= line_f[5];
	8'b0101_1011: 	word <= line_f[4];
	8'b0101_1100: 	word <= line_f[3];
	8'b0101_1101: 	word <= line_f[2];
	8'b0101_1110: 	word <= line_f[1];
	8'b0101_1111: 	word <= line_f[0];

 	8'b0110_0000: 	word <= line_g[15];
	8'b0110_0001: 	word <= line_g[14];
	8'b0110_0010: 	word <= line_g[13];
	8'b0110_0011: 	word <= line_g[12];
	8'b0110_0100: 	word <= line_g[11];
	8'b0110_0101: 	word <= line_g[10];
	8'b0110_0110: 	word <= line_g[9];
	8'b0110_0111: 	word <= line_g[8];
	8'b0110_1000: 	word <= line_g[7];
	8'b0110_1001: 	word <= line_g[6];
	8'b0110_1010: 	word <= line_g[5];
	8'b0110_1011: 	word <= line_g[4];
	8'b0110_1100: 	word <= line_g[3];
	8'b0110_1101: 	word <= line_g[2];
	8'b0110_1110: 	word <= line_g[1];
	8'b0110_1111: 	word <= line_g[0];

	8'b0111_0000: 	word <= line_h[15];
	8'b0111_0001: 	word <= line_h[14];
	8'b0111_0010: 	word <= line_h[13];
	8'b0111_0011: 	word <= line_h[12];
	8'b0111_0100: 	word <= line_h[11];
	8'b0111_0101: 	word <= line_h[10];
	8'b0111_0110: 	word <= line_h[9];
	8'b0111_0111: 	word <= line_h[8];
	8'b0111_1000: 	word <= line_h[7];
	8'b0111_1001: 	word <= line_h[6];
	8'b0111_1010: 	word <= line_h[5];
	8'b0111_1011: 	word <= line_h[4];
	8'b0111_1100: 	word <= line_h[3];
	8'b0111_1101: 	word <= line_h[2];
	8'b0111_1110: 	word <= line_h[1];
	8'b0111_1111: 	word <= line_h[0];

 
	8'b1000_0000: 	word <= line_i[15];
	8'b1000_0001: 	word <= line_i[14];
	8'b1000_0010: 	word <= line_i[13];
	8'b1000_0011: 	word <= line_i[12];
	8'b1000_0100: 	word <= line_i[11];
	8'b1000_0101: 	word <= line_i[10];
	8'b1000_0110: 	word <= line_i[9];
	8'b1000_0111: 	word <= line_i[8];
	8'b1000_1000: 	word <= line_i[7];
	8'b1000_1001: 	word <= line_i[6];
	8'b1000_1010: 	word <= line_i[5];
	8'b1000_1011: 	word <= line_i[4];
	8'b1000_1100: 	word <= line_i[3];
	8'b1000_1101: 	word <= line_i[2];
	8'b1000_1110: 	word <= line_i[1];
	8'b1000_1111: 	word <= line_i[0];

	8'b1001_0000: 	word <= line_j[15];
	8'b1001_0001: 	word <= line_j[14];
	8'b1001_0010: 	word <= line_j[13];
	8'b1001_0011: 	word <= line_j[12];
	8'b1001_0100: 	word <= line_j[11];
	8'b1001_0101: 	word <= line_j[10];
	8'b1001_0110: 	word <= line_j[9];
	8'b1001_0111: 	word <= line_j[8];
	8'b1001_1000: 	word <= line_j[7];
	8'b1001_1001: 	word <= line_j[6];
	8'b1001_1010: 	word <= line_j[5];
	8'b1001_1011: 	word <= line_j[4];
	8'b1001_1100: 	word <= line_j[3];
	8'b1001_1101: 	word <= line_j[2];
	8'b1001_1110: 	word <= line_j[1];
	8'b1001_1111: 	word <= line_j[0];	

	8'b1010_0000: 	word <= line_k[15];
	8'b1010_0001: 	word <= line_k[14];
	8'b1010_0010: 	word <= line_k[13];
	8'b1010_0011: 	word <= line_k[12];
	8'b1010_0100: 	word <= line_k[11];
	8'b1010_0101: 	word <= line_k[10];
	8'b1010_0110: 	word <= line_k[9];
	8'b1010_0111: 	word <= line_k[8];
	8'b1010_1000: 	word <= line_k[7];
	8'b1010_1001: 	word <= line_k[6];
	8'b1010_1010: 	word <= line_k[5];
	8'b1010_1011: 	word <= line_k[4];
	8'b1010_1100: 	word <= line_k[3];
	8'b1010_1101: 	word <= line_k[2];
	8'b1010_1110: 	word <= line_k[1];
	8'b1010_1111: 	word <= line_k[0];

  	8'b1011_0000: 	word <= line_l[15];
	8'b1011_0001: 	word <= line_l[14];
	8'b1011_0010: 	word <= line_l[13];
	8'b1011_0011: 	word <= line_l[12];
	8'b1011_0100: 	word <= line_l[11];
	8'b1011_0101: 	word <= line_l[10];
	8'b1011_0110: 	word <= line_l[9];
	8'b1011_0111: 	word <= line_l[8];
	8'b1011_1000: 	word <= line_l[7];
	8'b1011_1001: 	word <= line_l[6];
	8'b1011_1010: 	word <= line_l[5];
	8'b1011_1011: 	word <= line_l[4];
	8'b1011_1100: 	word <= line_l[3];
	8'b1011_1101: 	word <= line_l[2];
	8'b1011_1110: 	word <= line_l[1];
	8'b1011_1111: 	word <= line_l[0];

 	8'b1100_0000: 	word <= line_m[15];
	8'b1100_0001: 	word <= line_m[14];
	8'b1100_0010: 	word <= line_m[13];
	8'b1100_0011: 	word <= line_m[12];
	8'b1100_0100: 	word <= line_m[11];
	8'b1100_0101: 	word <= line_m[10];
	8'b1100_0110: 	word <= line_m[9];
	8'b1100_0111: 	word <= line_m[8];
	8'b1100_1000: 	word <= line_m[7];
	8'b1100_1001: 	word <= line_m[6];
	8'b1100_1010: 	word <= line_m[5];
	8'b1100_1011: 	word <= line_m[4];
	8'b1100_1100: 	word <= line_m[3];
	8'b1100_1101: 	word <= line_m[2];
	8'b1100_1110: 	word <= line_m[1];
	8'b1100_1111: 	word <= line_m[0];

 	8'b1101_0000: 	word <= line_n[15];
	8'b1101_0001: 	word <= line_n[14];
	8'b1101_0010: 	word <= line_n[13];
	8'b1101_0011: 	word <= line_n[12];
	8'b1101_0100: 	word <= line_n[11];
	8'b1101_0101: 	word <= line_n[10];
	8'b1101_0110: 	word <= line_n[9];
	8'b1101_0111: 	word <= line_n[8];
	8'b1101_1000: 	word <= line_n[7];
	8'b1101_1001: 	word <= line_n[6];
	8'b1101_1010: 	word <= line_n[5];
	8'b1101_1011: 	word <= line_n[4];
	8'b1101_1100: 	word <= line_n[3];
	8'b1101_1101: 	word <= line_n[2];
	8'b1101_1110: 	word <= line_n[1];
	8'b1101_1111: 	word <= line_n[0];

 	8'b1110_0000: 	word <= line_o[15];
	8'b1110_0001: 	word <= line_o[14];
	8'b1110_0010: 	word <= line_o[13];
	8'b1110_0011: 	word <= line_o[12];
	8'b1110_0100: 	word <= line_o[11];
	8'b1110_0101: 	word <= line_o[10];
	8'b1110_0110: 	word <= line_o[9];
	8'b1110_0111: 	word <= line_o[8];
	8'b1110_1000: 	word <= line_o[7];
	8'b1110_1001: 	word <= line_o[6];
	8'b1110_1010: 	word <= line_o[5];
	8'b1110_1011: 	word <= line_o[4];
	8'b1110_1100: 	word <= line_o[3];
	8'b1110_1101: 	word <= line_o[2];
	8'b1110_1110: 	word <= line_o[1];
	8'b1110_1111: 	word <= line_o[0];

	8'b1111_0000: 	word <= line_p[15];
	8'b1111_0001: 	word <= line_p[14];
	8'b1111_0010: 	word <= line_p[13];
	8'b1111_0011: 	word <= line_p[12];
	8'b1111_0100: 	word <= line_p[11];
	8'b1111_0101: 	word <= line_p[10];
	8'b1111_0110: 	word <= line_p[9];
	8'b1111_0111: 	word <= line_p[8];
	8'b1111_1000: 	word <= line_p[7];
	8'b1111_1001: 	word <= line_p[6];
	8'b1111_1010: 	word <= line_p[5];
	8'b1111_1011: 	word <= line_p[4];
	8'b1111_1100: 	word <= line_p[3];
	8'b1111_1101: 	word <= line_p[2];
	8'b1111_1110: 	word <= line_p[1];
	8'b1111_1111: 	word <= line_p[0];


	endcase
end


endmodule

module word_four(word,
			 row ,
			 col );
input [3:0]row;
input [3:0]col;
output word;
reg word;

wire [15:0]line_a,
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


assign line_a=16'b0000000000000000;
assign line_b=16'b0000000000000000;
assign line_c=16'b0000000100000000;
assign line_d=16'b0000100100000000;
assign line_e=16'b0000100100000000;
assign line_f=16'b0000111111100000;
assign line_g=16'b0001000100000000;
assign line_h=16'b0000000100000000;
assign line_i=16'b0000000100000000;
assign line_j=16'b0000011111000000;
assign line_k=16'b0000000100000000;
assign line_l=16'b0000000100000000;
assign line_m=16'b0000000100000000;
assign line_n=16'b0001111111110000;
assign line_o=16'b0000000000000000;
assign line_p=16'b0000000000000000;



always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or
           line_g or  line_h or  line_i or  line_j or line_k or line_l or line_m or
		 line_n or  line_o or line_p)
begin
	case   ({row,col})
	8'b0000_0000: 	word <= line_a[15];
	8'b0000_0001: 	word <= line_a[14];
	8'b0000_0010: 	word <= line_a[13];
	8'b0000_0011: 	word <= line_a[12];
	8'b0000_0100: 	word <= line_a[11];
	8'b0000_0101: 	word <= line_a[10];
	8'b0000_0110: 	word <= line_a[9];
	8'b0000_0111: 	word <= line_a[8];
	8'b0000_1000: 	word <= line_a[7];
	8'b0000_1001: 	word <= line_a[6];
	8'b0000_1010: 	word <= line_a[5];
	8'b0000_1011: 	word <= line_a[4];
	8'b0000_1100: 	word <= line_a[3];
	8'b0000_1101: 	word <= line_a[2];
	8'b0000_1110: 	word <= line_a[1];
	8'b0000_1111: 	word <= line_a[0];

	8'b0001_0000: 	word <= line_b[15];
	8'b0001_0001: 	word <= line_b[14];
	8'b0001_0010: 	word <= line_b[13];
	8'b0001_0011: 	word <= line_b[12];
	8'b0001_0100: 	word <= line_b[11];
	8'b0001_0101: 	word <= line_b[10];
	8'b0001_0110: 	word <= line_b[9];
	8'b0001_0111: 	word <= line_b[8];
	8'b0001_1000: 	word <= line_b[7];
	8'b0001_1001: 	word <= line_b[6];
	8'b0001_1010: 	word <= line_b[5];
	8'b0001_1011: 	word <= line_b[4];
	8'b0001_1100: 	word <= line_b[3];
	8'b0001_1101: 	word <= line_b[2];
	8'b0001_1110: 	word <= line_b[1];
	8'b0001_1111: 	word <= line_b[0];	

	8'b0010_0000: 	word <= line_c[15];
	8'b0010_0001: 	word <= line_c[14];
	8'b0010_0010: 	word <= line_c[13];
	8'b0010_0011: 	word <= line_c[12];
	8'b0010_0100: 	word <= line_c[11];
	8'b0010_0101: 	word <= line_c[10];
	8'b0010_0110: 	word <= line_c[9];
	8'b0010_0111: 	word <= line_c[8];
	8'b0010_1000: 	word <= line_c[7];
	8'b0010_1001: 	word <= line_c[6];
	8'b0010_1010: 	word <= line_c[5];
	8'b0010_1011: 	word <= line_c[4];
	8'b0010_1100: 	word <= line_c[3];
	8'b0010_1101: 	word <= line_c[2];
	8'b0010_1110: 	word <= line_c[1];
	8'b0010_1111: 	word <= line_c[0];

  	8'b0011_0000: 	word <= line_d[15];
	8'b0011_0001: 	word <= line_d[14];
	8'b0011_0010: 	word <= line_d[13];
	8'b0011_0011: 	word <= line_d[12];
	8'b0011_0100: 	word <= line_d[11];
	8'b0011_0101: 	word <= line_d[10];
	8'b0011_0110: 	word <= line_d[9];
	8'b0011_0111: 	word <= line_d[8];
	8'b0011_1000: 	word <= line_d[7];
	8'b0011_1001: 	word <= line_d[6];
	8'b0011_1010: 	word <= line_d[5];
	8'b0011_1011: 	word <= line_d[4];
	8'b0011_1100: 	word <= line_d[3];
	8'b0011_1101: 	word <= line_d[2];
	8'b0011_1110: 	word <= line_d[1];
	8'b0011_1111: 	word <= line_d[0];

 	8'b0100_0000: 	word <= line_e[15];
	8'b0100_0001: 	word <= line_e[14];
	8'b0100_0010: 	word <= line_e[13];
	8'b0100_0011: 	word <= line_e[12];
	8'b0100_0100: 	word <= line_e[11];
	8'b0100_0101: 	word <= line_e[10];
	8'b0100_0110: 	word <= line_e[9];
	8'b0100_0111: 	word <= line_e[8];
	8'b0100_1000: 	word <= line_e[7];
	8'b0100_1001: 	word <= line_e[6];
	8'b0100_1010: 	word <= line_e[5];
	8'b0100_1011: 	word <= line_e[4];
	8'b0100_1100: 	word <= line_e[3];
	8'b0100_1101: 	word <= line_e[2];
	8'b0100_1110: 	word <= line_e[1];
	8'b0100_1111: 	word <= line_e[0];

 	8'b0101_0000: 	word <= line_f[15];
	8'b0101_0001: 	word <= line_f[14];
	8'b0101_0010: 	word <= line_f[13];
	8'b0101_0011: 	word <= line_f[12];
	8'b0101_0100: 	word <= line_f[11];
	8'b0101_0101: 	word <= line_f[10];
	8'b0101_0110: 	word <= line_f[9];
	8'b0101_0111: 	word <= line_f[8];
	8'b0101_1000: 	word <= line_f[7];
	8'b0101_1001: 	word <= line_f[6];
	8'b0101_1010: 	word <= line_f[5];
	8'b0101_1011: 	word <= line_f[4];
	8'b0101_1100: 	word <= line_f[3];
	8'b0101_1101: 	word <= line_f[2];
	8'b0101_1110: 	word <= line_f[1];
	8'b0101_1111: 	word <= line_f[0];

 	8'b0110_0000: 	word <= line_g[15];
	8'b0110_0001: 	word <= line_g[14];
	8'b0110_0010: 	word <= line_g[13];
	8'b0110_0011: 	word <= line_g[12];
	8'b0110_0100: 	word <= line_g[11];
	8'b0110_0101: 	word <= line_g[10];
	8'b0110_0110: 	word <= line_g[9];
	8'b0110_0111: 	word <= line_g[8];
	8'b0110_1000: 	word <= line_g[7];
	8'b0110_1001: 	word <= line_g[6];
	8'b0110_1010: 	word <= line_g[5];
	8'b0110_1011: 	word <= line_g[4];
	8'b0110_1100: 	word <= line_g[3];
	8'b0110_1101: 	word <= line_g[2];
	8'b0110_1110: 	word <= line_g[1];
	8'b0110_1111: 	word <= line_g[0];

	8'b0111_0000: 	word <= line_h[15];
	8'b0111_0001: 	word <= line_h[14];
	8'b0111_0010: 	word <= line_h[13];
	8'b0111_0011: 	word <= line_h[12];
	8'b0111_0100: 	word <= line_h[11];
	8'b0111_0101: 	word <= line_h[10];
	8'b0111_0110: 	word <= line_h[9];
	8'b0111_0111: 	word <= line_h[8];
	8'b0111_1000: 	word <= line_h[7];
	8'b0111_1001: 	word <= line_h[6];
	8'b0111_1010: 	word <= line_h[5];
	8'b0111_1011: 	word <= line_h[4];
	8'b0111_1100: 	word <= line_h[3];
	8'b0111_1101: 	word <= line_h[2];
	8'b0111_1110: 	word <= line_h[1];
	8'b0111_1111: 	word <= line_h[0];

 
	8'b1000_0000: 	word <= line_i[15];
	8'b1000_0001: 	word <= line_i[14];
	8'b1000_0010: 	word <= line_i[13];
	8'b1000_0011: 	word <= line_i[12];
	8'b1000_0100: 	word <= line_i[11];
	8'b1000_0101: 	word <= line_i[10];
	8'b1000_0110: 	word <= line_i[9];
	8'b1000_0111: 	word <= line_i[8];
	8'b1000_1000: 	word <= line_i[7];
	8'b1000_1001: 	word <= line_i[6];
	8'b1000_1010: 	word <= line_i[5];
	8'b1000_1011: 	word <= line_i[4];
	8'b1000_1100: 	word <= line_i[3];
	8'b1000_1101: 	word <= line_i[2];
	8'b1000_1110: 	word <= line_i[1];
	8'b1000_1111: 	word <= line_i[0];

	8'b1001_0000: 	word <= line_j[15];
	8'b1001_0001: 	word <= line_j[14];
	8'b1001_0010: 	word <= line_j[13];
	8'b1001_0011: 	word <= line_j[12];
	8'b1001_0100: 	word <= line_j[11];
	8'b1001_0101: 	word <= line_j[10];
	8'b1001_0110: 	word <= line_j[9];
	8'b1001_0111: 	word <= line_j[8];
	8'b1001_1000: 	word <= line_j[7];
	8'b1001_1001: 	word <= line_j[6];
	8'b1001_1010: 	word <= line_j[5];
	8'b1001_1011: 	word <= line_j[4];
	8'b1001_1100: 	word <= line_j[3];
	8'b1001_1101: 	word <= line_j[2];
	8'b1001_1110: 	word <= line_j[1];
	8'b1001_1111: 	word <= line_j[0];	

	8'b1010_0000: 	word <= line_k[15];
	8'b1010_0001: 	word <= line_k[14];
	8'b1010_0010: 	word <= line_k[13];
	8'b1010_0011: 	word <= line_k[12];
	8'b1010_0100: 	word <= line_k[11];
	8'b1010_0101: 	word <= line_k[10];
	8'b1010_0110: 	word <= line_k[9];
	8'b1010_0111: 	word <= line_k[8];
	8'b1010_1000: 	word <= line_k[7];
	8'b1010_1001: 	word <= line_k[6];
	8'b1010_1010: 	word <= line_k[5];
	8'b1010_1011: 	word <= line_k[4];
	8'b1010_1100: 	word <= line_k[3];
	8'b1010_1101: 	word <= line_k[2];
	8'b1010_1110: 	word <= line_k[1];
	8'b1010_1111: 	word <= line_k[0];

  	8'b1011_0000: 	word <= line_l[15];
	8'b1011_0001: 	word <= line_l[14];
	8'b1011_0010: 	word <= line_l[13];
	8'b1011_0011: 	word <= line_l[12];
	8'b1011_0100: 	word <= line_l[11];
	8'b1011_0101: 	word <= line_l[10];
	8'b1011_0110: 	word <= line_l[9];
	8'b1011_0111: 	word <= line_l[8];
	8'b1011_1000: 	word <= line_l[7];
	8'b1011_1001: 	word <= line_l[6];
	8'b1011_1010: 	word <= line_l[5];
	8'b1011_1011: 	word <= line_l[4];
	8'b1011_1100: 	word <= line_l[3];
	8'b1011_1101: 	word <= line_l[2];
	8'b1011_1110: 	word <= line_l[1];
	8'b1011_1111: 	word <= line_l[0];

 	8'b1100_0000: 	word <= line_m[15];
	8'b1100_0001: 	word <= line_m[14];
	8'b1100_0010: 	word <= line_m[13];
	8'b1100_0011: 	word <= line_m[12];
	8'b1100_0100: 	word <= line_m[11];
	8'b1100_0101: 	word <= line_m[10];
	8'b1100_0110: 	word <= line_m[9];
	8'b1100_0111: 	word <= line_m[8];
	8'b1100_1000: 	word <= line_m[7];
	8'b1100_1001: 	word <= line_m[6];
	8'b1100_1010: 	word <= line_m[5];
	8'b1100_1011: 	word <= line_m[4];
	8'b1100_1100: 	word <= line_m[3];
	8'b1100_1101: 	word <= line_m[2];
	8'b1100_1110: 	word <= line_m[1];
	8'b1100_1111: 	word <= line_m[0];

 	8'b1101_0000: 	word <= line_n[15];
	8'b1101_0001: 	word <= line_n[14];
	8'b1101_0010: 	word <= line_n[13];
	8'b1101_0011: 	word <= line_n[12];
	8'b1101_0100: 	word <= line_n[11];
	8'b1101_0101: 	word <= line_n[10];
	8'b1101_0110: 	word <= line_n[9];
	8'b1101_0111: 	word <= line_n[8];
	8'b1101_1000: 	word <= line_n[7];
	8'b1101_1001: 	word <= line_n[6];
	8'b1101_1010: 	word <= line_n[5];
	8'b1101_1011: 	word <= line_n[4];
	8'b1101_1100: 	word <= line_n[3];
	8'b1101_1101: 	word <= line_n[2];
	8'b1101_1110: 	word <= line_n[1];
	8'b1101_1111: 	word <= line_n[0];

 	8'b1110_0000: 	word <= line_o[15];
	8'b1110_0001: 	word <= line_o[14];
	8'b1110_0010: 	word <= line_o[13];
	8'b1110_0011: 	word <= line_o[12];
	8'b1110_0100: 	word <= line_o[11];
	8'b1110_0101: 	word <= line_o[10];
	8'b1110_0110: 	word <= line_o[9];
	8'b1110_0111: 	word <= line_o[8];
	8'b1110_1000: 	word <= line_o[7];
	8'b1110_1001: 	word <= line_o[6];
	8'b1110_1010: 	word <= line_o[5];
	8'b1110_1011: 	word <= line_o[4];
	8'b1110_1100: 	word <= line_o[3];
	8'b1110_1101: 	word <= line_o[2];
	8'b1110_1110: 	word <= line_o[1];
	8'b1110_1111: 	word <= line_o[0];

	8'b1111_0000: 	word <= line_p[15];
	8'b1111_0001: 	word <= line_p[14];
	8'b1111_0010: 	word <= line_p[13];
	8'b1111_0011: 	word <= line_p[12];
	8'b1111_0100: 	word <= line_p[11];
	8'b1111_0101: 	word <= line_p[10];
	8'b1111_0110: 	word <= line_p[9];
	8'b1111_0111: 	word <= line_p[8];
	8'b1111_1000: 	word <= line_p[7];
	8'b1111_1001: 	word <= line_p[6];
	8'b1111_1010: 	word <= line_p[5];
	8'b1111_1011: 	word <= line_p[4];
	8'b1111_1100: 	word <= line_p[3];
	8'b1111_1101: 	word <= line_p[2];
	8'b1111_1110: 	word <= line_p[1];
	8'b1111_1111: 	word <= line_p[0];


	endcase
end
endmodule
module word_five(word,
			 row ,
			 col );
input [3:0]row;
input [3:0]col;
output word;
reg word;

wire [15:0]line_a,
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


assign line_a=16'b0000000000000000;
assign line_b=16'b0001110000000000;
assign line_c=16'b0010001000000000;
assign line_d=16'b0100000000000000;
assign line_e=16'b0100000000000000;
assign line_f=16'b0100000000000000;
assign line_g=16'b0010000000000000;
assign line_h=16'b0001100000011001;
assign line_i=16'b0000010000101010;
assign line_j=16'b0001100001001100;
assign line_k=16'b0010000001001000;
assign line_l=16'b0100000010001000;
assign line_m=16'b0100000010001000;
assign line_n=16'b0100000100001000;
assign line_o=16'b0010001000001000;
assign line_p=16'b0001110000001000;



always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or
           line_g or  line_h or  line_i or  line_j or line_k or line_l or line_m or
		 line_n or  line_o or line_p)
begin
	case   ({row,col})
	8'b0000_0000: 	word <= line_a[15];
	8'b0000_0001: 	word <= line_a[14];
	8'b0000_0010: 	word <= line_a[13];
	8'b0000_0011: 	word <= line_a[12];
	8'b0000_0100: 	word <= line_a[11];
	8'b0000_0101: 	word <= line_a[10];
	8'b0000_0110: 	word <= line_a[9];
	8'b0000_0111: 	word <= line_a[8];
	8'b0000_1000: 	word <= line_a[7];
	8'b0000_1001: 	word <= line_a[6];
	8'b0000_1010: 	word <= line_a[5];
	8'b0000_1011: 	word <= line_a[4];
	8'b0000_1100: 	word <= line_a[3];
	8'b0000_1101: 	word <= line_a[2];
	8'b0000_1110: 	word <= line_a[1];
	8'b0000_1111: 	word <= line_a[0];

	8'b0001_0000: 	word <= line_b[15];
	8'b0001_0001: 	word <= line_b[14];
	8'b0001_0010: 	word <= line_b[13];
	8'b0001_0011: 	word <= line_b[12];
	8'b0001_0100: 	word <= line_b[11];
	8'b0001_0101: 	word <= line_b[10];
	8'b0001_0110: 	word <= line_b[9];
	8'b0001_0111: 	word <= line_b[8];
	8'b0001_1000: 	word <= line_b[7];
	8'b0001_1001: 	word <= line_b[6];
	8'b0001_1010: 	word <= line_b[5];
	8'b0001_1011: 	word <= line_b[4];
	8'b0001_1100: 	word <= line_b[3];
	8'b0001_1101: 	word <= line_b[2];
	8'b0001_1110: 	word <= line_b[1];
	8'b0001_1111: 	word <= line_b[0];	

	8'b0010_0000: 	word <= line_c[15];
	8'b0010_0001: 	word <= line_c[14];
	8'b0010_0010: 	word <= line_c[13];
	8'b0010_0011: 	word <= line_c[12];
	8'b0010_0100: 	word <= line_c[11];
	8'b0010_0101: 	word <= line_c[10];
	8'b0010_0110: 	word <= line_c[9];
	8'b0010_0111: 	word <= line_c[8];
	8'b0010_1000: 	word <= line_c[7];
	8'b0010_1001: 	word <= line_c[6];
	8'b0010_1010: 	word <= line_c[5];
	8'b0010_1011: 	word <= line_c[4];
	8'b0010_1100: 	word <= line_c[3];
	8'b0010_1101: 	word <= line_c[2];
	8'b0010_1110: 	word <= line_c[1];
	8'b0010_1111: 	word <= line_c[0];

  	8'b0011_0000: 	word <= line_d[15];
	8'b0011_0001: 	word <= line_d[14];
	8'b0011_0010: 	word <= line_d[13];
	8'b0011_0011: 	word <= line_d[12];
	8'b0011_0100: 	word <= line_d[11];
	8'b0011_0101: 	word <= line_d[10];
	8'b0011_0110: 	word <= line_d[9];
	8'b0011_0111: 	word <= line_d[8];
	8'b0011_1000: 	word <= line_d[7];
	8'b0011_1001: 	word <= line_d[6];
	8'b0011_1010: 	word <= line_d[5];
	8'b0011_1011: 	word <= line_d[4];
	8'b0011_1100: 	word <= line_d[3];
	8'b0011_1101: 	word <= line_d[2];
	8'b0011_1110: 	word <= line_d[1];
	8'b0011_1111: 	word <= line_d[0];

 	8'b0100_0000: 	word <= line_e[15];
	8'b0100_0001: 	word <= line_e[14];
	8'b0100_0010: 	word <= line_e[13];
	8'b0100_0011: 	word <= line_e[12];
	8'b0100_0100: 	word <= line_e[11];
	8'b0100_0101: 	word <= line_e[10];
	8'b0100_0110: 	word <= line_e[9];
	8'b0100_0111: 	word <= line_e[8];
	8'b0100_1000: 	word <= line_e[7];
	8'b0100_1001: 	word <= line_e[6];
	8'b0100_1010: 	word <= line_e[5];
	8'b0100_1011: 	word <= line_e[4];
	8'b0100_1100: 	word <= line_e[3];
	8'b0100_1101: 	word <= line_e[2];
	8'b0100_1110: 	word <= line_e[1];
	8'b0100_1111: 	word <= line_e[0];

 	8'b0101_0000: 	word <= line_f[15];
	8'b0101_0001: 	word <= line_f[14];
	8'b0101_0010: 	word <= line_f[13];
	8'b0101_0011: 	word <= line_f[12];
	8'b0101_0100: 	word <= line_f[11];
	8'b0101_0101: 	word <= line_f[10];
	8'b0101_0110: 	word <= line_f[9];
	8'b0101_0111: 	word <= line_f[8];
	8'b0101_1000: 	word <= line_f[7];
	8'b0101_1001: 	word <= line_f[6];
	8'b0101_1010: 	word <= line_f[5];
	8'b0101_1011: 	word <= line_f[4];
	8'b0101_1100: 	word <= line_f[3];
	8'b0101_1101: 	word <= line_f[2];
	8'b0101_1110: 	word <= line_f[1];
	8'b0101_1111: 	word <= line_f[0];

 	8'b0110_0000: 	word <= line_g[15];
	8'b0110_0001: 	word <= line_g[14];
	8'b0110_0010: 	word <= line_g[13];
	8'b0110_0011: 	word <= line_g[12];
	8'b0110_0100: 	word <= line_g[11];
	8'b0110_0101: 	word <= line_g[10];
	8'b0110_0110: 	word <= line_g[9];
	8'b0110_0111: 	word <= line_g[8];
	8'b0110_1000: 	word <= line_g[7];
	8'b0110_1001: 	word <= line_g[6];
	8'b0110_1010: 	word <= line_g[5];
	8'b0110_1011: 	word <= line_g[4];
	8'b0110_1100: 	word <= line_g[3];
	8'b0110_1101: 	word <= line_g[2];
	8'b0110_1110: 	word <= line_g[1];
	8'b0110_1111: 	word <= line_g[0];

	8'b0111_0000: 	word <= line_h[15];
	8'b0111_0001: 	word <= line_h[14];
	8'b0111_0010: 	word <= line_h[13];
	8'b0111_0011: 	word <= line_h[12];
	8'b0111_0100: 	word <= line_h[11];
	8'b0111_0101: 	word <= line_h[10];
	8'b0111_0110: 	word <= line_h[9];
	8'b0111_0111: 	word <= line_h[8];
	8'b0111_1000: 	word <= line_h[7];
	8'b0111_1001: 	word <= line_h[6];
	8'b0111_1010: 	word <= line_h[5];
	8'b0111_1011: 	word <= line_h[4];
	8'b0111_1100: 	word <= line_h[3];
	8'b0111_1101: 	word <= line_h[2];
	8'b0111_1110: 	word <= line_h[1];
	8'b0111_1111: 	word <= line_h[0];

 
	8'b1000_0000: 	word <= line_i[15];
	8'b1000_0001: 	word <= line_i[14];
	8'b1000_0010: 	word <= line_i[13];
	8'b1000_0011: 	word <= line_i[12];
	8'b1000_0100: 	word <= line_i[11];
	8'b1000_0101: 	word <= line_i[10];
	8'b1000_0110: 	word <= line_i[9];
	8'b1000_0111: 	word <= line_i[8];
	8'b1000_1000: 	word <= line_i[7];
	8'b1000_1001: 	word <= line_i[6];
	8'b1000_1010: 	word <= line_i[5];
	8'b1000_1011: 	word <= line_i[4];
	8'b1000_1100: 	word <= line_i[3];
	8'b1000_1101: 	word <= line_i[2];
	8'b1000_1110: 	word <= line_i[1];
	8'b1000_1111: 	word <= line_i[0];

	8'b1001_0000: 	word <= line_j[15];
	8'b1001_0001: 	word <= line_j[14];
	8'b1001_0010: 	word <= line_j[13];
	8'b1001_0011: 	word <= line_j[12];
	8'b1001_0100: 	word <= line_j[11];
	8'b1001_0101: 	word <= line_j[10];
	8'b1001_0110: 	word <= line_j[9];
	8'b1001_0111: 	word <= line_j[8];
	8'b1001_1000: 	word <= line_j[7];
	8'b1001_1001: 	word <= line_j[6];
	8'b1001_1010: 	word <= line_j[5];
	8'b1001_1011: 	word <= line_j[4];
	8'b1001_1100: 	word <= line_j[3];
	8'b1001_1101: 	word <= line_j[2];
	8'b1001_1110: 	word <= line_j[1];
	8'b1001_1111: 	word <= line_j[0];	

	8'b1010_0000: 	word <= line_k[15];
	8'b1010_0001: 	word <= line_k[14];
	8'b1010_0010: 	word <= line_k[13];
	8'b1010_0011: 	word <= line_k[12];
	8'b1010_0100: 	word <= line_k[11];
	8'b1010_0101: 	word <= line_k[10];
	8'b1010_0110: 	word <= line_k[9];
	8'b1010_0111: 	word <= line_k[8];
	8'b1010_1000: 	word <= line_k[7];
	8'b1010_1001: 	word <= line_k[6];
	8'b1010_1010: 	word <= line_k[5];
	8'b1010_1011: 	word <= line_k[4];
	8'b1010_1100: 	word <= line_k[3];
	8'b1010_1101: 	word <= line_k[2];
	8'b1010_1110: 	word <= line_k[1];
	8'b1010_1111: 	word <= line_k[0];

  	8'b1011_0000: 	word <= line_l[15];
	8'b1011_0001: 	word <= line_l[14];
	8'b1011_0010: 	word <= line_l[13];
	8'b1011_0011: 	word <= line_l[12];
	8'b1011_0100: 	word <= line_l[11];
	8'b1011_0101: 	word <= line_l[10];
	8'b1011_0110: 	word <= line_l[9];
	8'b1011_0111: 	word <= line_l[8];
	8'b1011_1000: 	word <= line_l[7];
	8'b1011_1001: 	word <= line_l[6];
	8'b1011_1010: 	word <= line_l[5];
	8'b1011_1011: 	word <= line_l[4];
	8'b1011_1100: 	word <= line_l[3];
	8'b1011_1101: 	word <= line_l[2];
	8'b1011_1110: 	word <= line_l[1];
	8'b1011_1111: 	word <= line_l[0];

 	8'b1100_0000: 	word <= line_m[15];
	8'b1100_0001: 	word <= line_m[14];
	8'b1100_0010: 	word <= line_m[13];
	8'b1100_0011: 	word <= line_m[12];
	8'b1100_0100: 	word <= line_m[11];
	8'b1100_0101: 	word <= line_m[10];
	8'b1100_0110: 	word <= line_m[9];
	8'b1100_0111: 	word <= line_m[8];
	8'b1100_1000: 	word <= line_m[7];
	8'b1100_1001: 	word <= line_m[6];
	8'b1100_1010: 	word <= line_m[5];
	8'b1100_1011: 	word <= line_m[4];
	8'b1100_1100: 	word <= line_m[3];
	8'b1100_1101: 	word <= line_m[2];
	8'b1100_1110: 	word <= line_m[1];
	8'b1100_1111: 	word <= line_m[0];

 	8'b1101_0000: 	word <= line_n[15];
	8'b1101_0001: 	word <= line_n[14];
	8'b1101_0010: 	word <= line_n[13];
	8'b1101_0011: 	word <= line_n[12];
	8'b1101_0100: 	word <= line_n[11];
	8'b1101_0101: 	word <= line_n[10];
	8'b1101_0110: 	word <= line_n[9];
	8'b1101_0111: 	word <= line_n[8];
	8'b1101_1000: 	word <= line_n[7];
	8'b1101_1001: 	word <= line_n[6];
	8'b1101_1010: 	word <= line_n[5];
	8'b1101_1011: 	word <= line_n[4];
	8'b1101_1100: 	word <= line_n[3];
	8'b1101_1101: 	word <= line_n[2];
	8'b1101_1110: 	word <= line_n[1];
	8'b1101_1111: 	word <= line_n[0];

 	8'b1110_0000: 	word <= line_o[15];
	8'b1110_0001: 	word <= line_o[14];
	8'b1110_0010: 	word <= line_o[13];
	8'b1110_0011: 	word <= line_o[12];
	8'b1110_0100: 	word <= line_o[11];
	8'b1110_0101: 	word <= line_o[10];
	8'b1110_0110: 	word <= line_o[9];
	8'b1110_0111: 	word <= line_o[8];
	8'b1110_1000: 	word <= line_o[7];
	8'b1110_1001: 	word <= line_o[6];
	8'b1110_1010: 	word <= line_o[5];
	8'b1110_1011: 	word <= line_o[4];
	8'b1110_1100: 	word <= line_o[3];
	8'b1110_1101: 	word <= line_o[2];
	8'b1110_1110: 	word <= line_o[1];
	8'b1110_1111: 	word <= line_o[0];

	8'b1111_0000: 	word <= line_p[15];
	8'b1111_0001: 	word <= line_p[14];
	8'b1111_0010: 	word <= line_p[13];
	8'b1111_0011: 	word <= line_p[12];
	8'b1111_0100: 	word <= line_p[11];
	8'b1111_0101: 	word <= line_p[10];
	8'b1111_0110: 	word <= line_p[9];
	8'b1111_0111: 	word <= line_p[8];
	8'b1111_1000: 	word <= line_p[7];
	8'b1111_1001: 	word <= line_p[6];
	8'b1111_1010: 	word <= line_p[5];
	8'b1111_1011: 	word <= line_p[4];
	8'b1111_1100: 	word <= line_p[3];
	8'b1111_1101: 	word <= line_p[2];
	8'b1111_1110: 	word <= line_p[1];
	8'b1111_1111: 	word <= line_p[0];


	endcase
end

endmodule

module word_six(word,
			 row ,
			 col );
input [3:0]row;
input [3:0]col;
output word;
reg word;

wire [15:0]line_a,
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


assign line_a=16'b0000000000000000;
assign line_b=16'b0000000000000000;
assign line_c=16'b0000000000100000;
assign line_d=16'b0000000000100000;
assign line_e=16'b0000000000100000;
assign line_f=16'b0000000000100000;
assign line_g=16'b0000000000100000;
assign line_h=16'b1000000000100000;
assign line_i=16'b0100000000100000;
assign line_j=16'b0100000000100000;
assign line_k=16'b0100001111100000;
assign line_l=16'b0100010000110000;
assign line_m=16'b0100010000110000;
assign line_n=16'b0100010000101000;
assign line_o=16'b0100110001001000;
assign line_p=16'b0011001111000100;


always @ (row or col or line_a or line_b or line_c or line_d or line_e or line_f or
           line_g or  line_h or  line_i or  line_j or line_k or line_l or line_m or
		 line_n or  line_o or line_p)
begin
	case   ({row,col})
	8'b0000_0000: 	word <= line_a[15];
	8'b0000_0001: 	word <= line_a[14];
	8'b0000_0010: 	word <= line_a[13];
	8'b0000_0011: 	word <= line_a[12];
	8'b0000_0100: 	word <= line_a[11];
	8'b0000_0101: 	word <= line_a[10];
	8'b0000_0110: 	word <= line_a[9];
	8'b0000_0111: 	word <= line_a[8];
	8'b0000_1000: 	word <= line_a[7];
	8'b0000_1001: 	word <= line_a[6];
	8'b0000_1010: 	word <= line_a[5];
	8'b0000_1011: 	word <= line_a[4];
	8'b0000_1100: 	word <= line_a[3];
	8'b0000_1101: 	word <= line_a[2];
	8'b0000_1110: 	word <= line_a[1];
	8'b0000_1111: 	word <= line_a[0];

	8'b0001_0000: 	word <= line_b[15];
	8'b0001_0001: 	word <= line_b[14];
	8'b0001_0010: 	word <= line_b[13];
	8'b0001_0011: 	word <= line_b[12];
	8'b0001_0100: 	word <= line_b[11];
	8'b0001_0101: 	word <= line_b[10];
	8'b0001_0110: 	word <= line_b[9];
	8'b0001_0111: 	word <= line_b[8];
	8'b0001_1000: 	word <= line_b[7];
	8'b0001_1001: 	word <= line_b[6];
	8'b0001_1010: 	word <= line_b[5];
	8'b0001_1011: 	word <= line_b[4];
	8'b0001_1100: 	word <= line_b[3];
	8'b0001_1101: 	word <= line_b[2];
	8'b0001_1110: 	word <= line_b[1];
	8'b0001_1111: 	word <= line_b[0];	

	8'b0010_0000: 	word <= line_c[15];
	8'b0010_0001: 	word <= line_c[14];
	8'b0010_0010: 	word <= line_c[13];
	8'b0010_0011: 	word <= line_c[12];
	8'b0010_0100: 	word <= line_c[11];
	8'b0010_0101: 	word <= line_c[10];
	8'b0010_0110: 	word <= line_c[9];
	8'b0010_0111: 	word <= line_c[8];
	8'b0010_1000: 	word <= line_c[7];
	8'b0010_1001: 	word <= line_c[6];
	8'b0010_1010: 	word <= line_c[5];
	8'b0010_1011: 	word <= line_c[4];
	8'b0010_1100: 	word <= line_c[3];
	8'b0010_1101: 	word <= line_c[2];
	8'b0010_1110: 	word <= line_c[1];
	8'b0010_1111: 	word <= line_c[0];

  	8'b0011_0000: 	word <= line_d[15];
	8'b0011_0001: 	word <= line_d[14];
	8'b0011_0010: 	word <= line_d[13];
	8'b0011_0011: 	word <= line_d[12];
	8'b0011_0100: 	word <= line_d[11];
	8'b0011_0101: 	word <= line_d[10];
	8'b0011_0110: 	word <= line_d[9];
	8'b0011_0111: 	word <= line_d[8];
	8'b0011_1000: 	word <= line_d[7];
	8'b0011_1001: 	word <= line_d[6];
	8'b0011_1010: 	word <= line_d[5];
	8'b0011_1011: 	word <= line_d[4];
	8'b0011_1100: 	word <= line_d[3];
	8'b0011_1101: 	word <= line_d[2];
	8'b0011_1110: 	word <= line_d[1];
	8'b0011_1111: 	word <= line_d[0];

 	8'b0100_0000: 	word <= line_e[15];
	8'b0100_0001: 	word <= line_e[14];
	8'b0100_0010: 	word <= line_e[13];
	8'b0100_0011: 	word <= line_e[12];
	8'b0100_0100: 	word <= line_e[11];
	8'b0100_0101: 	word <= line_e[10];
	8'b0100_0110: 	word <= line_e[9];
	8'b0100_0111: 	word <= line_e[8];
	8'b0100_1000: 	word <= line_e[7];
	8'b0100_1001: 	word <= line_e[6];
	8'b0100_1010: 	word <= line_e[5];
	8'b0100_1011: 	word <= line_e[4];
	8'b0100_1100: 	word <= line_e[3];
	8'b0100_1101: 	word <= line_e[2];
	8'b0100_1110: 	word <= line_e[1];
	8'b0100_1111: 	word <= line_e[0];

 	8'b0101_0000: 	word <= line_f[15];
	8'b0101_0001: 	word <= line_f[14];
	8'b0101_0010: 	word <= line_f[13];
	8'b0101_0011: 	word <= line_f[12];
	8'b0101_0100: 	word <= line_f[11];
	8'b0101_0101: 	word <= line_f[10];
	8'b0101_0110: 	word <= line_f[9];
	8'b0101_0111: 	word <= line_f[8];
	8'b0101_1000: 	word <= line_f[7];
	8'b0101_1001: 	word <= line_f[6];
	8'b0101_1010: 	word <= line_f[5];
	8'b0101_1011: 	word <= line_f[4];
	8'b0101_1100: 	word <= line_f[3];
	8'b0101_1101: 	word <= line_f[2];
	8'b0101_1110: 	word <= line_f[1];
	8'b0101_1111: 	word <= line_f[0];

 	8'b0110_0000: 	word <= line_g[15];
	8'b0110_0001: 	word <= line_g[14];
	8'b0110_0010: 	word <= line_g[13];
	8'b0110_0011: 	word <= line_g[12];
	8'b0110_0100: 	word <= line_g[11];
	8'b0110_0101: 	word <= line_g[10];
	8'b0110_0110: 	word <= line_g[9];
	8'b0110_0111: 	word <= line_g[8];
	8'b0110_1000: 	word <= line_g[7];
	8'b0110_1001: 	word <= line_g[6];
	8'b0110_1010: 	word <= line_g[5];
	8'b0110_1011: 	word <= line_g[4];
	8'b0110_1100: 	word <= line_g[3];
	8'b0110_1101: 	word <= line_g[2];
	8'b0110_1110: 	word <= line_g[1];
	8'b0110_1111: 	word <= line_g[0];

	8'b0111_0000: 	word <= line_h[15];
	8'b0111_0001: 	word <= line_h[14];
	8'b0111_0010: 	word <= line_h[13];
	8'b0111_0011: 	word <= line_h[12];
	8'b0111_0100: 	word <= line_h[11];
	8'b0111_0101: 	word <= line_h[10];
	8'b0111_0110: 	word <= line_h[9];
	8'b0111_0111: 	word <= line_h[8];
	8'b0111_1000: 	word <= line_h[7];
	8'b0111_1001: 	word <= line_h[6];
	8'b0111_1010: 	word <= line_h[5];
	8'b0111_1011: 	word <= line_h[4];
	8'b0111_1100: 	word <= line_h[3];
	8'b0111_1101: 	word <= line_h[2];
	8'b0111_1110: 	word <= line_h[1];
	8'b0111_1111: 	word <= line_h[0];

 
	8'b1000_0000: 	word <= line_i[15];
	8'b1000_0001: 	word <= line_i[14];
	8'b1000_0010: 	word <= line_i[13];
	8'b1000_0011: 	word <= line_i[12];
	8'b1000_0100: 	word <= line_i[11];
	8'b1000_0101: 	word <= line_i[10];
	8'b1000_0110: 	word <= line_i[9];
	8'b1000_0111: 	word <= line_i[8];
	8'b1000_1000: 	word <= line_i[7];
	8'b1000_1001: 	word <= line_i[6];
	8'b1000_1010: 	word <= line_i[5];
	8'b1000_1011: 	word <= line_i[4];
	8'b1000_1100: 	word <= line_i[3];
	8'b1000_1101: 	word <= line_i[2];
	8'b1000_1110: 	word <= line_i[1];
	8'b1000_1111: 	word <= line_i[0];

	8'b1001_0000: 	word <= line_j[15];
	8'b1001_0001: 	word <= line_j[14];
	8'b1001_0010: 	word <= line_j[13];
	8'b1001_0011: 	word <= line_j[12];
	8'b1001_0100: 	word <= line_j[11];
	8'b1001_0101: 	word <= line_j[10];
	8'b1001_0110: 	word <= line_j[9];
	8'b1001_0111: 	word <= line_j[8];
	8'b1001_1000: 	word <= line_j[7];
	8'b1001_1001: 	word <= line_j[6];
	8'b1001_1010: 	word <= line_j[5];
	8'b1001_1011: 	word <= line_j[4];
	8'b1001_1100: 	word <= line_j[3];
	8'b1001_1101: 	word <= line_j[2];
	8'b1001_1110: 	word <= line_j[1];
	8'b1001_1111: 	word <= line_j[0];	

	8'b1010_0000: 	word <= line_k[15];
	8'b1010_0001: 	word <= line_k[14];
	8'b1010_0010: 	word <= line_k[13];
	8'b1010_0011: 	word <= line_k[12];
	8'b1010_0100: 	word <= line_k[11];
	8'b1010_0101: 	word <= line_k[10];
	8'b1010_0110: 	word <= line_k[9];
	8'b1010_0111: 	word <= line_k[8];
	8'b1010_1000: 	word <= line_k[7];
	8'b1010_1001: 	word <= line_k[6];
	8'b1010_1010: 	word <= line_k[5];
	8'b1010_1011: 	word <= line_k[4];
	8'b1010_1100: 	word <= line_k[3];
	8'b1010_1101: 	word <= line_k[2];
	8'b1010_1110: 	word <= line_k[1];
	8'b1010_1111: 	word <= line_k[0];

  	8'b1011_0000: 	word <= line_l[15];
	8'b1011_0001: 	word <= line_l[14];
	8'b1011_0010: 	word <= line_l[13];
	8'b1011_0011: 	word <= line_l[12];
	8'b1011_0100: 	word <= line_l[11];
	8'b1011_0101: 	word <= line_l[10];
	8'b1011_0110: 	word <= line_l[9];
	8'b1011_0111: 	word <= line_l[8];
	8'b1011_1000: 	word <= line_l[7];
	8'b1011_1001: 	word <= line_l[6];
	8'b1011_1010: 	word <= line_l[5];
	8'b1011_1011: 	word <= line_l[4];
	8'b1011_1100: 	word <= line_l[3];
	8'b1011_1101: 	word <= line_l[2];
	8'b1011_1110: 	word <= line_l[1];
	8'b1011_1111: 	word <= line_l[0];

 	8'b1100_0000: 	word <= line_m[15];
	8'b1100_0001: 	word <= line_m[14];
	8'b1100_0010: 	word <= line_m[13];
	8'b1100_0011: 	word <= line_m[12];
	8'b1100_0100: 	word <= line_m[11];
	8'b1100_0101: 	word <= line_m[10];
	8'b1100_0110: 	word <= line_m[9];
	8'b1100_0111: 	word <= line_m[8];
	8'b1100_1000: 	word <= line_m[7];
	8'b1100_1001: 	word <= line_m[6];
	8'b1100_1010: 	word <= line_m[5];
	8'b1100_1011: 	word <= line_m[4];
	8'b1100_1100: 	word <= line_m[3];
	8'b1100_1101: 	word <= line_m[2];
	8'b1100_1110: 	word <= line_m[1];
	8'b1100_1111: 	word <= line_m[0];

 	8'b1101_0000: 	word <= line_n[15];
	8'b1101_0001: 	word <= line_n[14];
	8'b1101_0010: 	word <= line_n[13];
	8'b1101_0011: 	word <= line_n[12];
	8'b1101_0100: 	word <= line_n[11];
	8'b1101_0101: 	word <= line_n[10];
	8'b1101_0110: 	word <= line_n[9];
	8'b1101_0111: 	word <= line_n[8];
	8'b1101_1000: 	word <= line_n[7];
	8'b1101_1001: 	word <= line_n[6];
	8'b1101_1010: 	word <= line_n[5];
	8'b1101_1011: 	word <= line_n[4];
	8'b1101_1100: 	word <= line_n[3];
	8'b1101_1101: 	word <= line_n[2];
	8'b1101_1110: 	word <= line_n[1];
	8'b1101_1111: 	word <= line_n[0];

 	8'b1110_0000: 	word <= line_o[15];
	8'b1110_0001: 	word <= line_o[14];
	8'b1110_0010: 	word <= line_o[13];
	8'b1110_0011: 	word <= line_o[12];
	8'b1110_0100: 	word <= line_o[11];
	8'b1110_0101: 	word <= line_o[10];
	8'b1110_0110: 	word <= line_o[9];
	8'b1110_0111: 	word <= line_o[8];
	8'b1110_1000: 	word <= line_o[7];
	8'b1110_1001: 	word <= line_o[6];
	8'b1110_1010: 	word <= line_o[5];
	8'b1110_1011: 	word <= line_o[4];
	8'b1110_1100: 	word <= line_o[3];
	8'b1110_1101: 	word <= line_o[2];
	8'b1110_1110: 	word <= line_o[1];
	8'b1110_1111: 	word <= line_o[0];

	8'b1111_0000: 	word <= line_p[15];
	8'b1111_0001: 	word <= line_p[14];
	8'b1111_0010: 	word <= line_p[13];
	8'b1111_0011: 	word <= line_p[12];
	8'b1111_0100: 	word <= line_p[11];
	8'b1111_0101: 	word <= line_p[10];
	8'b1111_0110: 	word <= line_p[9];
	8'b1111_0111: 	word <= line_p[8];
	8'b1111_1000: 	word <= line_p[7];
	8'b1111_1001: 	word <= line_p[6];
	8'b1111_1010: 	word <= line_p[5];
	8'b1111_1011: 	word <= line_p[4];
	8'b1111_1100: 	word <= line_p[3];
	8'b1111_1101: 	word <= line_p[2];
	8'b1111_1110: 	word <= line_p[1];
	8'b1111_1111: 	word <= line_p[0];


	endcase
end

endmodule

module keyboard( clk, reset, KCLK, KDAT, DATA);

input clk,reset;
input KCLK,KDAT;
output [7:0] DATA;

reg [21:0] R;    //receive
reg [3:0] counter;
reg [7:0] DATA;
reg c_state,n_state;


always@(posedge clk)begin
    if(reset)begin
	     c_state <= 1'b0;
		  n_state <= 1'b0;
	 end
	 else begin
	     c_state <= n_state;
		  n_state <= KCLK;
    end
end

always@(posedge clk)begin
    if(reset)
	     R <= 22'b11_00000000_0_11_00000000_0;
	 else begin
	     case({c_state,n_state})
		      2'b10:R <= {KDAT,R[21:1]};
				default:R <= R;
		  endcase
    end
end

always@(posedge clk)begin
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

always@(posedge clk)begin
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

