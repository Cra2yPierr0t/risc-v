module uart_v2(CLK50M, RX, TX, rx_data);
    input CLK50M;
    input RX;
    output TX;
    output [7:0] rx_data;

    wire clk;

    reg TX = 1'b1;

    reg [1:0] state = 2'b00;
    reg [7:0] rx_data = 8'b00000000;
    reg [3:0] rx_index = 4'b0000;

    reg [7:0] tx_data = 8'b10000110;
    reg [2:0] tx_index = 3'b000;

    clk_gen clk_gen(CLK50M, clk);

    //busy -> receve -> send -> busy
    //busy -> send -> busy
    
    always @(posedge clk) begin
        if(state == 2'b00) begin            //busy
            TX <= 1'b1;
            rx_data <= rx_data;
            tx_data <= tx_data;
            if(RX == 1'b0) begin
                state <= 1'b01;
                rx_index <= 3'b000;
            end
        end else if(state == 2'b01) begin   //receve
            case(rx_index) 
                4'b0000:begin
                    rx_data[7] <= RX;
                    rx_index <= rx_index + 4'b1;
                end
                4'b0001:begin
                    rx_data[6] <= RX;
                    rx_index <= rx_index + 4'b1;
                end
                4'b0010:begin
                    rx_data[5] <= RX;
                    rx_index <= rx_index + 4'b1;
                end
                4'b0011:begin
                    rx_data[4] <= RX;
                    rx_index <= rx_index + 4'b1;
                end
                4'b0100:begin
                    rx_data[3] <= RX;
                    rx_index <= rx_index + 4'b1;
                end
                4'b0101:begin
                    rx_data[2] <= RX;
                    rx_index <= rx_index + 4'b1;
                end
                4'b0110:begin
                    rx_data[1] <= RX;
                    rx_index <= rx_index + 4'b1;
                end
                4'b0111:begin
                    rx_data[0] <= RX;
                    rx_index <= rx_index + 4'b1;
					 end
				    4'b1000:begin
					     rx_index <= 4'b0000;
					     tx_data <= rx_data;
						  TX <= 1'b0;
						  state <= 2'b10;
                end
            endcase
        end else if(state == 2'b10) begin       //send
            case(tx_index)
                3'b000:begin
                    TX <= tx_data[7];
                    tx_index <= tx_index + 3'b1;
                end
                3'b001:begin
                    TX <= tx_data[6];
                    tx_index <= tx_index + 3'b1;
                end
                3'b010:begin
                    TX <= tx_data[5];
                    tx_index <= tx_index + 3'b1;
                end
                3'b011:begin
                    TX <= tx_data[4];
                    tx_index <= tx_index + 3'b1;
                end
                3'b100:begin
                    TX <= tx_data[3];
                    tx_index <= tx_index + 3'b1;
                end
                3'b101:begin
                    TX <= tx_data[2];
                    tx_index <= tx_index + 3'b1;
                end
                3'b110:begin
                    TX <= tx_data[1];
                    tx_index <= tx_index + 3'b1;
                end
                3'b111:begin
                    TX <= tx_data[0];
                    tx_index <= tx_index + 3'b1;
                    state <= 2'b00;
                end
            endcase
        end else begin
            TX <= 1'b1;
            rx_data <= rx_data;
        end
    end
endmodule
