module ROM(address, out);
    input [31:0] address;
    output [31:0] out;

    reg [31:0] mem [63:0];

    assign out = mem[address[31:2]];
    
    integer i;
    initial begin
        for(i = 0; i < 64; i = i + 1)
            mem[i] = 32'h00000000;

        mem[3] = 32'b00000000000100000000000010010011;
        mem[4] = 32'b00000000101100000000000100010011;
        mem[5] = 32'b00000000000000000000000110010011;
        mem[6] = 32'b00000000000100001000000010010011;
        mem[7] = 32'b00000000000100011000000110110011;
        mem[8] = 32'b11111110000100010000111011100011;
    end
endmodule
