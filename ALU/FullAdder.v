module FullAdder(A, B, C, Sum, Carry);
    input A, B, C;
    output Sum, Carry;

    wire Sum1, Carry1, Carry2;

    HalfAdder ha1(A, B, Sum1, Carry1);
    HalfAdder ha2(Sum1, C, Sum, Carry2);

    assign Carry = Carry1 | Carry2;
endmodule
