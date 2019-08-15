module ROM(address, out);
    input [31:0] address;
    output [31:0] out;

    reg [31:0] mem [63:0];

    assign out = mem[address[31:2]];
    
    integer i;
    initial begin
        for(i = 0; i < 64; i = i + 1)
            mem[i] = 32'h00000000;

        mem[3] = 32'b01010101010100000000000010010011;
        mem[4] = 32'b00000000000100000010000000100011;
        mem[5] = 32'b00000000000000000010000100000011;
        mem[6] = 32'b00000000000000001110000100110011;
        mem[7] = 32'b00000000110000000000000111100111;
    end
endmodule
