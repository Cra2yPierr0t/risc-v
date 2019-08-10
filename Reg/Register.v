module Register(in, load, out, reset, clock);
    input [31:0] in;
    input load, reset, clock;
    output [31:0] out;
    
    reg [31:0] out;

    always @(posedge clock, posedge reset) begin
        if(reset) begin
            out <= 32'h00000000;
        end else if(load) begin
            out <= in;
        end else begin
            out <= out;
        end
    end
endmodule
