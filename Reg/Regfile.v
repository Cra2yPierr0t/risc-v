module Regfile(w_address, load, w_in, r1_address, r2_address, r1_out, r2_out, reset, clock);
    input [31:0] w_in;
    input load, reset, clock;
    input [4:0] w_address, r1_address, r2_address;
    output [31:0] r1_out, r2_out;

    wire [31:0] load_x;
    wire [31:0] out_x [31:0];

    assign r1_out = out_x[r1_address];
    assign r2_out = out_x[r2_address];

    DMux32 DMux32(load, w_address, load_x);

    //Register x[31:0](in, load_x[31:0], out_x[31:0], reset, clock);

    Register x0(w_in, load_x[0], out_x[0], reset, clock);
    Register x1(w_in, load_x[1], out_x[1], reset, clock);
    Register x2(w_in, load_x[2], out_x[2], reset, clock);
    Register x3(w_in, load_x[3], out_x[3], reset, clock);
    Register x4(w_in, load_x[4], out_x[4], reset, clock);
    Register x5(w_in, load_x[5], out_x[5], reset, clock);
    Register x6(w_in, load_x[6], out_x[6], reset, clock);
    Register x7(w_in, load_x[7], out_x[7], reset, clock);
    Register x8(w_in, load_x[8], out_x[8], reset, clock);
    Register x9(w_in, load_x[9], out_x[9], reset, clock);
    Register x10(w_in, load_x[10], out_x[10], reset, clock);
    Register x11(w_in, load_x[11], out_x[11], reset, clock);
    Register x12(w_in, load_x[12], out_x[12], reset, clock);
    Register x13(w_in, load_x[13], out_x[13], reset, clock);
    Register x14(w_in, load_x[14], out_x[14], reset, clock);
    Register x15(w_in, load_x[15], out_x[15], reset, clock);
    Register x16(w_in, load_x[16], out_x[16], reset, clock);
    Register x17(w_in, load_x[17], out_x[17], reset, clock);
    Register x18(w_in, load_x[18], out_x[18], reset, clock);
    Register x19(w_in, load_x[19], out_x[19], reset, clock);
    Register x20(w_in, load_x[20], out_x[20], reset, clock);
    Register x21(w_in, load_x[21], out_x[21], reset, clock);
    Register x22(w_in, load_x[22], out_x[22], reset, clock);
    Register x23(w_in, load_x[23], out_x[23], reset, clock);
    Register x24(w_in, load_x[24], out_x[24], reset, clock);
    Register x25(w_in, load_x[25], out_x[25], reset, clock);
    Register x26(w_in, load_x[26], out_x[26], reset, clock);
    Register x27(w_in, load_x[27], out_x[27], reset, clock);
    Register x28(w_in, load_x[28], out_x[28], reset, clock);
    Register x29(w_in, load_x[29], out_x[29], reset, clock);
    Register x30(w_in, load_x[30], out_x[30], reset, clock);
    Register x31(w_in, load_x[31], out_x[31], reset, clock);
endmodule
