module uart(CLK50M, BUTTON, TX, RX, state);
    input CLK50M;
    input BUTTON;
    input TX;
	output RX;
	output [1:0] state;
	 
	wire clk;
		
	reg RX = 1;
    reg [9:0] tx_data = 10'h3ff;
    reg [0:9] rx_data = 10'b0001100011;
    reg [3:0] bit_index = 4'b0;
    reg [1:0] state = 0;
	reg button = 0;
	 
    clk_gen clk_gen(CLK50M, clk);
	 
    //busy -> receve -> send -> busy
    //busy -> send -> busy

    always @(posedge clk) begin
        if(state == 0) begin //busy

        if(state == 1) begin //receve
        if(state == 2) begin //send
    end
endmodule
