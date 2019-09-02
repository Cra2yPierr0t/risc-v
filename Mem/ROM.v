module ROM(address, out);
    input [31:0] address;
    output [31:0] out;

    reg [31:0] mem [63:0];

    assign out = mem[address[31:2]];
    
    integer i;
    initial begin
        for(i = 0; i < 64; i = i + 1)
            mem[i] = 32'h00000000;

        mem[0] = 32'b00000010101010101010000010110111;
        mem[1] = 32'b00000000000000000000000100010111;
    end
endmodule
