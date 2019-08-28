module RAM(in, address, load, out, clock);
    input [31:0] in, address;
    input load, clock;
    output [31:0] out;

    reg [31:0] mem [63:0];

    always @(posedge clock) begin
        if(load) mem[address[31:2]] = in;
    end

    assign out = mem[address[31:2]];

    integer i;
    initial begin
        for(i = 0; i < 64; i = i + 1)
            mem[i] = 32'h00000000;
    end
endmodule
