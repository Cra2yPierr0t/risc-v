//////////////////////////////////////////////////////////////////////
//  Project     :	VGA
//  Module Name : TOP
//  Function    : VGAタイミング生成。640x480pix
//  Designer    : gogofpga
//	TextEditor Tab size	:	2
//--------------------------------------------------------------------
//	参考サイト: http://www.cs.shinshu-u.ac.jp/Lecture/DP/C/03/04.html
//--------------------------------------------------------------------
//	2016/11/11:	新規作成。
//
//////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

//------------------------------------------------Define
//------------------------------------------------Module
module vga_test(
	input           	CLK,			// 50MHz
	input							RESETn,		// -n プッシュボタン　押すとL。
  output	reg				VGA_HS, 
	output	reg				VGA_VS,
  output  reg 		[3:0] VGA_R,
  output  reg		[3:0] VGA_G,
  output  reg		[3:0] VGA_B
);
//------------------------------------------------parameter
parameter HMAX		= 800;
parameter HVALID	= 640;
parameter HPULSE	= 96;
parameter HBPORCH	= 16;

parameter VMAX		= 521;
parameter VVALID	= 480;
parameter VPULSE	= 2;
parameter VBPORCH	= 10;
//------------------------------------------------reg,wire
reg [9:0]	hcnt;
reg [9:0]	vcnt;
reg			clk25m;
reg [13:0] 	addr = 13'b0000000000000;
reg [4:0]	index = 5'b11111;
wire [31:0]	mem_out;
//------------------------------------------------

assign	reset	=	~RESETn;	// ボタン0押すとリセット

always @(posedge CLK or posedge reset)
		if (reset)
				clk25m	<=	1'b0;
		else
				clk25m	<=	~clk25m;

////////////////
// hcnt
////////////////
always @(posedge clk25m or posedge reset)
		if	(reset)
				hcnt <= 0;
    else if ( hcnt == HMAX - 1 )
				hcnt <= 0;
    else
				hcnt <= hcnt + 1;

////////////////
// vcnt
////////////////
always @(posedge clk25m or posedge reset)
		if (reset)
				vcnt <= 0;
    else if ( hcnt == HMAX - 1 ) 
				if ( vcnt == VMAX - 1 )
						vcnt <= 0;
				else
						vcnt <= vcnt + 1;
    else
				vcnt <= vcnt;

/////////////////////
// vga timing gen
/////////////////////
always @(posedge clk25m)
		begin
				// Vsync
				if ((vcnt >= (VVALID + VBPORCH)) && (vcnt < (VVALID + VBPORCH + VPULSE)))
						VGA_VS <= 1'b0 ;
				else
						VGA_VS <= 1'b1 ;

				// Hsync
				if ((hcnt >= (HVALID + HBPORCH)) && (hcnt < (HVALID + HBPORCH + HPULSE)))
						VGA_HS <= 1'b0 ;
				else
						VGA_HS <= 1'b1 ;
		end


////////////////////////////////////////////////////////////////////////
// r,g,b data(SWが0設定時は右に青と緑グラデーション。下に赤グラデーション)
////////////////////////////////////////////////////////////////////////

/*
assign	VGA_R = hcnt[3:0];
assign	VGA_G = hcnt[7:4];
assign	VGA_B = vcnt[3:0];
*/

memory_map memory_map(addr, clk25m, 32'h00000000, 0, mem_out);

always @(posedge clk25m)
begin
	VGA_R = {mem_out[index], mem_out[index], mem_out[index]};
	VGA_G = {mem_out[index], mem_out[index], mem_out[index]};
	VGA_B = {mem_out[index], mem_out[index], mem_out[index]};
	if((hcnt < HVALID) && (vcnt < VVALID)) begin
		index = index - 1;
		if(index == 5'b00000) addr = addr + 1;
	end
	if(addr == 14'd9600) addr = 14'b00000000000000;
end

////////////////
// 7seg
////////////////

endmodule
