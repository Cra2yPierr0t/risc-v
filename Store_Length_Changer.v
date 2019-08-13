module Store_Length_Changer(in, ctrl, out);
    input [31:0] in;
    input [2:0] ctrl;
    output [31:0] out;

    assign out = changer(ctrl);

    function [31:0] changer(input [2:0] ctrl);
        begin
            case(ctrl)
            3'b000: changer = { (in[31:0] == 0) ? 24'h000000 : 24'hffffff , in[7:0] };
            3'b001: changer = { (in[31:0] == 0) ? 16'h0000 : 16'hffff , in[15:0] };
            3'b010: changer = in;
            endcase
        end
    endfunction
endmodule
