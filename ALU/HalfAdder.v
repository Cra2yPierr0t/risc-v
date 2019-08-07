module HalfAdder(A, B, Sum, Carry);
    input A, B;
    output Sum, Carry;

    assign Carry = A & B;
    assign Sum = A ^ B;
endmodule
