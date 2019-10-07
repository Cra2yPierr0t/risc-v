module clk_gen(clk_50m, clk_uart);
    input clk_50m;
    output clk_uart;

	 reg clk_uart = 0;
    reg [8:0] cnt = 8'b0;

    always @(posedge clk_50m)begin
        if(cnt == 433) begin
            cnt <= 8'b0;
            clk_uart <= ~clk_uart;
        end else begin
            cnt <= cnt + 1'b1;
        end
    end
endmodule
