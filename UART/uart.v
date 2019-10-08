module uart(CLK50M, RX, TX, b_state, r_state, s_state);
    input CLK50M;
    input RX;
	output TX;
	output b_state, r_state, s_state;

	wire clk;
	
	 reg TX = 1'b1;
	 reg b_state = 1'b0;
	 reg r_state = 1'b0;
	 reg s_state = 1'b0;
	
	 reg [1:0] state = 2'b00;
    reg [7:0] rx_data = 8'b00000000;
    reg [2:0] rx_index = 3'b000;

    reg [7:0] tx_data = 8'b00000000;
    reg [2:0] tx_index = 3'b000;
		
    clk_gen clk_gen(CLK50M, clk);
	 
    //busy -> receve -> send -> busy
    //busy -> send -> busy

    always @(posedge clk) begin
        if(state == 0) begin            //busy
            TX <= 1'b1;
				b_state <= 1'b1;
				r_state <= 1'b0;
				s_state <= 1'b0;
            if(RX == 1'b0) state <= 1;  //if(getting data begin) busy -> receve
        end

        if(state == 1) begin            //receve
				b_state <= 1'b0;
				r_state <= 1'b1;
				s_state <= 1'b0;
				
            tx_data[rx_index] <= RX;
            if(rx_index == 7) begin 
                rx_index <= 0;
                state <= 2;             //if(getting data end) receve -> send
                TX <= 1'b0;             //send start bit
            end else begin 
                rx_index <= rx_index + 1;
            end
        end

        if(state == 2) begin            //send
				b_state <= 1'b0;
				r_state <= 1'b0;
				s_state <= 1'b1;
            TX <= tx_data[tx_index];
            if(tx_index == 7) begin
                tx_index <= 0;
                state <= 0;             //if(sending data end) send -> busy
                //TX <= 1'b1;             //send end bit
            end else begin
                tx_index <= tx_index + 1;
            end
        end
    end
endmodule
