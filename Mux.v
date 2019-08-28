module Mux(A, B, sel, out);
    input A, B, sel;
    output out;

    assign out = (A & ~sel) | (B & sel);
endmodule
