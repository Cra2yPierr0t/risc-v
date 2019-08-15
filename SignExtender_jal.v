module SignExtender_jal(in, out);
    input [19:0] in;
    output [31:0] out;

    assign out = { in[19] ? 12'hfff : 12'h000, in[19], in[7:0], in[8], in[18:9], 1'b0 };
endmodule
