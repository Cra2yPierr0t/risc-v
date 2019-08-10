module ALU(x, y, ctrl, out);
    input [31:0] x, y;
    input [2:0] ctrl;
    output [31:0] out;

    assign out = calculate(ctrl);

    function [31:0] calculate(input [2:0] ctrl);
        begin
            case(ctrl)
            3'b000:     calculate = x + y;
            3'b001:     calculate = x << y;
            3'b010:     calculate = (x < y);
            3'b011:     calculate = ($signed(x) < $signed(y));
            3'b100:     calculate = x ^ y;
            3'b101:     calculate = x >> y;
            3'b110:     calculate = x | y;
            3'b111:     calculate = x & y;
            default:    calculate = 32'hxxxxxxxx;
            endcase
        end
    endfunction
endmodule
