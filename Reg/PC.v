module PC(in, out, reset, clock);
    input [31:0] in;
    input reset, clock;
    output [31:0] out;

    reg [31:0] out;

    always @(posedge clock, posedge reset) begin
        if(reset) begin
            out <= 32'h00000000;
        end else begin
            out <= in;
        end
    end
endmodule
