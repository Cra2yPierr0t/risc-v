module ALU(x, y, ctrl, ex, out);
    input [31:0] x, y;
    input [2:0] ctrl;
    input ex;
    output [31:0] out;

    assign out = calculate(ex, ctrl, x, y);

    function [31:0] calculate(input ex, input [2:0] ctrl, input [31:0] x, input [31:0] y);
        begin
            case(ctrl)
            3'b000:     calculate = ex ? x - y : x + y;
            3'b001:     calculate = x << y;
            3'b010:     calculate = (x < y);
            3'b011:     calculate = ($signed(x) < $signed(y));
            3'b100:     calculate = x ^ y;
            3'b101:     calculate = ex ? $signed(x) >>> $signed(y) : x >> y;
            3'b110:     calculate = x | y;
            3'b111:     calculate = x & y;
            default:    calculate = 32'hxxxxxxxx;
            endcase
        end
    endfunction
endmodule
