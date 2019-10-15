module uart_v2(CLK50M, RX, TX, rx_data);
    input CLK50M;
    input RX;
    output TX;
    output [7:0] rx_data;

    wire clk;

    reg TX = 1'b1;

    reg [1:0] state = 2'b00;
    reg [7:0] rx_data = 8'b00000000;
    reg [2:0] rx_index = 3'b000;

    reg [7:0] tx_data = 8'b01100001;
    reg [2:0] tx_index = 3'b000;

    clk_gen clk_gen(CLK50M, clk);

    //busy -> receve -> send -> busy
    //busy -> send -> busy
    
    always @(posedge clk) begin
        if(state == 2'b00) begin            //busy
            TX <= 1'b1;
            if(RX == 1'b0) begin
                state <= 1'b1;
            end
        end else if(state == 2'b01) begin   //send
            case(rx_index) 
                3'd0:begin
                    rx_data[7] <= RX;
                    rx_index <= rx_index + 3'b1;
                end
                3'd1:begin
                    rx_data[6] <= RX;
                    rx_index <= rx_index + 3'b1;
                end
                3'd2:begin
                    rx_data[5] <= RX;
                    rx_index <= rx_index + 3'b1;
                end
                3'd3:begin
                    rx_data[4] <= RX;
                    rx_index <= rx_index + 3'b1;
                end
                3'd4:begin
                    rx_data[3] <= RX;
                    rx_index <= rx_index + 3'b1;
                end
                3'd5:begin
                    rx_data[2] <= RX;
                    rx_index <= rx_index + 3'b1;
                end
                3'd6:begin
                    rx_data[1] <= RX;
                    rx_index <= rx_index + 3'b1;
                end
                3'd7:begin
                    rx_data[0] <= RX;
                    rx_index <= rx_index + 3'b1;
                    TX <= 1'b0;
                    state <= 2'b10;
                end
            endcase
        end else if(state == 2'b10) begin
            case(tx_index)
                3'd0:begin
                    TX <= tx_data[7];
                    tx_index <= tx_index + 3'b1;
                end
                3'd1:begin
                    TX <= tx_data[6];
                    tx_index <= tx_index + 3'b1;
                end
                3'd2:begin
                    TX <= tx_data[5];
                    tx_index <= tx_index + 3'b1;
                end
                3'd3:begin
                    TX <= tx_data[4];
                    tx_index <= tx_index + 3'b1;
                end
                3'd4:begin
                    TX <= tx_data[3];
                    tx_index <= tx_index + 3'b1;
                end
                3'd5:begin
                    TX <= tx_data[2];
                    tx_index <= tx_index + 3'b1;
                end
                3'd6:begin
                    TX <= tx_data[1];
                    tx_index <= tx_index + 3'b1;
                end
                3'd7:begin
                    TX <= tx_data[0];
                    tx_index <= tx_index + 3'b1;
                    state <= 2'b00;
                end
            endcase
        end
    end
endmodule
