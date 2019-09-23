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
module vga_test_v2(
	input           	CLK,			// 50MHz
	input							RESETn,		// -n プッシュボタン　押すとL。
	input button,
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
reg [13:0] 	rdaddr = 13'b0000000000000;
reg [13:0]  wraddr = 13'b0000000000000;
reg [4:0]	index = 5'b11111;
reg [4:0]   vram_index = 5'b00000;
wire [31:0]	mem_out;
reg [9:0]   cursor = 10'b0000000000;
reg [15:0]  vram[31:0];
reg [31:0]  data;
reg wflag = 0;
reg wflag_2 = 0;
reg wren = 0;
wire buffer;
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

memory_map_v2 memory_map_v2(clk25m, data, rdaddr, wraddr, wren, mem_out);
always @(posedge BUTTON)
begin
    vram[0] = 16'b0000000000000000;
    vram[1] = 16'b0011111111100000;
    vram[2] = 16'b0000000111100000;
    vram[3] = 16'b0000000011100000;
    vram[4] = 16'b0000000011100000;
    vram[5] = 16'b0000001111100000;
    vram[6] = 16'b0000011111000000;
    vram[7] = 16'b0000011000000000;
    vram[8] = 16'b0000011000000000;
    vram[9] = 16'b0000011000000000;
    vram[10] = 16'b0000011000000000;
    vram[11] = 16'b0000011000000000;
    vram[12] = 16'b0000011000000000;
    vram[13] = 16'b0000011000000000;
    vram[14] = 16'b0000011000000000;
    vram[15] = 16'b0000011000000000;
    vram[16] = 16'b0000011000000000;
    vram[17] = 16'b0000011111111000;
    vram[18] = 16'b0000011000011000;
    vram[19] = 16'b0000011000111100;
    vram[20] = 16'b0000011001111110;
    vram[21] = 16'b0000011000000000;
    vram[22] = 16'b0000011000000000;
    vram[23] = 16'b0000011000000000;
    vram[24] = 16'b0000011000000000;
    vram[25] = 16'b0000011000000000;
    vram[26] = 16'b0000011000000000;
    vram[27] = 16'b0000111100000000;
    vram[28] = 16'b0001111111000000;
    vram[29] = 16'b0111111111110000;
    vram[30] = 16'b0000000000000000;
    vram[31] = 16'b0000000000000000;
end

assign BUTTON = ~button;
assign buffer = ~button;

always @(posedge clk25m or posedge BUTTON)
begin
		wflag = buffer;
    if((wflag == 1) || (wflag_2 == 1)) begin
			if(vram_index == 5'b11111) begin
				wflag_2 = 0;
				wraddr = wraddr - 619;
			end
		  wflag_2 = 1;
        wren = 1;
        data = {16'b0000000000000000, vram[vram_index]};
        wraddr = wraddr + 20;
        vram_index <= vram_index + 1;
    end else begin
        wren = 1;
end


always @(posedge clk25m)
begin
	VGA_R = {mem_out[index], mem_out[index], mem_out[index]};
	VGA_G = {mem_out[index], mem_out[index], mem_out[index]};
	VGA_B = {mem_out[index], mem_out[index], mem_out[index]};
	if((hcnt < HVALID) && (vcnt < VVALID)) begin
		index = index - 1;
		if(index == 5'b00000) rdaddr = rdaddr + 1;
	end
	if(rdaddr == 14'd9600) rdaddr = 14'b00000000000000;
end

////////////////
// 7seg
////////////////

endmodule
