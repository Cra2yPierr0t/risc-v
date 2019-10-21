module uart_v4(CLK50M, RX, TX, rx_data);
    input CLK50M;
    input RX;
    output TX;
    output [7:0] rx_data;

    wire clk;

    reg TX = 1'b1;
    reg [1:0] state = 2'b00;
    reg [7:0] tx_data = 8'b01100001;
    reg [7:0] rx_data = 8'b00000000;

    reg [3:0] tx_counter = 4'b0000;
    reg [3:0] rx_counter = 4'b0000;

    clk_gen clk_gen(CLK50M, clk);

    //busy -> receive -> send -> busy
    //busy -> send -> busy

    always @(posedge clk) begin
        if(state == 2'b00) begin            //busy
            TX <= 1'b1;
            rx_data <= rx_data;
            tx_data <= tx_data;
            if(RX == 1'b0) begin            //if get start bit, go receive state
                state <= 2'b01;
            end
        end else if(state == 2'b01) begin   //receive
            if(rx_counter < 8) begin
                rx_data[rx_counter] <= RX;
                rx_counter <= rx_counter + 4'b1;
            end else begin
                rx_counter <= 4'b0;
                tx_data <= rx_data;
                TX <= 1'b0;
                state <= 2'b10;             //go send state
            end
        end else if(state == 2'b10) begin   //send
            if(tx_counter < 8) begin
                TX <= tx_data[tx_counter];
                tx_counter <= tx_counter + 4'b1;
            end else begin
                tx_counter <= 4'b0;
                TX <= 1'b1;
                state <= 2'b00;             //go busy state
            end
        end
    end
endmodule
