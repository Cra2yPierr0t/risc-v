module SignExtender(in, out);
    input [11:0] in;
    output [31:0] out;

    assign out = { in[11] ? 20'hfffff : 20'h00000 , in[0], in[10:5], in[4:1], 1'b0 };
endmodule
