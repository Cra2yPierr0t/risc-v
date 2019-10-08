module uart(CLK50M, BUTTON, RX, TX, state);
    input CLK50M;
    input BUTTON;
    input RX;
	output TX;
	output [1:0] state;

	wire clk;

    reg [7:0] rx_data = 8'b00000000;
    reg [2:0] rx_index = 3'b000;

    reg [7:0] tx_data = 8'b00000000;
    reg [2:0] rx_index = 3'b000;
		
    clk_gen clk_gen(CLK50M, clk);
	 
    //busy -> receve -> send -> busy
    //busy -> send -> busy

    always @(posedge clk) begin
        if(state == 0) begin            //busy
            TX <= 1'b1;
            if(RX == 1'b0) state <= 1;  //if(getting data begin) busy -> receve
        end

        if(state == 1) begin            //receve
                rx_data[rx_index] <= RX;
            if(rx_index == 8) begin 
                rx_index <= 0;
                state <= 2;             //if(getting data end) receve -> send
                TX <= 1'b0;             //send start bit
            end else begin 
                rx_index <= rx_index + 1;
            end
        end

        if(state == 2) begin            //send
            TX <= tx_data[tx_index];
            if(tx_index == 8) begin
                tx_index <= 0;
                state <= 0;             //if(sending data end) send -> busy
                TX <= 1'b1;             //send end bit
            end else begin
                tx_index <= tx_index + 1;
            end
        end
    end
endmodule
