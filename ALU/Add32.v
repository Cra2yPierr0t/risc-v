module Add32(A, B, Sum);
    input [31:0] A, B;
    output [31:0] Sum;

    wire [31:0] Carry;

    HalfAdder ha(A[0], B[0], Sum[0], Carry[0]);
    FullAdder fa1(A[1], B[1], Carry[0], Sum[1], Carry[1]);
    FullAdder fa2(A[2], B[2], Carry[1], Sum[2], Carry[2]);
    FullAdder fa3(A[3], B[3], Carry[2], Sum[3], Carry[3]);
    FullAdder fa4(A[4], B[4], Carry[3], Sum[4], Carry[4]);
    FullAdder fa5(A[5], B[5], Carry[4], Sum[5], Carry[5]);
    FullAdder fa6(A[6], B[6], Carry[5], Sum[6], Carry[6]);
    FullAdder fa7(A[7], B[7], Carry[6], Sum[7], Carry[7]);
    FullAdder fa8(A[8], B[8], Carry[7], Sum[8], Carry[8]);
    FullAdder fa9(A[9], B[9], Carry[8], Sum[9], Carry[9]);
    FullAdder fa10(A[10], B[10], Carry[9], Sum[10], Carry[10]);
    FullAdder fa11(A[11], B[11], Carry[10], Sum[11], Carry[11]);
    FullAdder fa12(A[12], B[12], Carry[11], Sum[12], Carry[12]);
    FullAdder fa13(A[13], B[13], Carry[12], Sum[13], Carry[13]);
    FullAdder fa14(A[14], B[14], Carry[13], Sum[14], Carry[14]);
    FullAdder fa15(A[15], B[15], Carry[14], Sum[15], Carry[15]);
    FullAdder fa16(A[16], B[16], Carry[15], Sum[16], Carry[16]);
    FullAdder fa17(A[17], B[17], Carry[16], Sum[17], Carry[17]);
    FullAdder fa18(A[18], B[18], Carry[17], Sum[18], Carry[18]);
    FullAdder fa19(A[19], B[19], Carry[18], Sum[19], Carry[19]);
    FullAdder fa20(A[20], B[20], Carry[19], Sum[20], Carry[20]);
    FullAdder fa21(A[21], B[21], Carry[20], Sum[21], Carry[21]);
    FullAdder fa22(A[22], B[22], Carry[21], Sum[22], Carry[22]);
    FullAdder fa23(A[23], B[23], Carry[22], Sum[23], Carry[23]);
    FullAdder fa24(A[24], B[24], Carry[23], Sum[24], Carry[24]);
    FullAdder fa25(A[25], B[25], Carry[24], Sum[25], Carry[25]);
    FullAdder fa26(A[26], B[26], Carry[25], Sum[26], Carry[26]);
    FullAdder fa27(A[27], B[27], Carry[26], Sum[27], Carry[27]);
    FullAdder fa28(A[28], B[28], Carry[27], Sum[28], Carry[28]);
    FullAdder fa29(A[29], B[29], Carry[28], Sum[29], Carry[29]);
    FullAdder fa30(A[30], B[30], Carry[29], Sum[30], Carry[30]);
    FullAdder fa31(A[31], B[31], Carry[30], Sum[31], Carry[31]);
endmodule
