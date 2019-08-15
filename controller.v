module controller(op, Regwswitch, Reg_load, do_store, ALUSrc, cal, mem_load, jump, addorjump);
    input [6:0] op;
    output Regwswitch, Reg_load, do_store, ALUSrc, cal, mem_load, jump, addorjump;

    wire [7:0] controls;

    assign {Regwswitch, do_store, ALUSrc, cal, mem_load, Reg_load, jump, addorjump} = controls;
    assign controls = decode(op);

    function [7:0] decode(input [6:0] op);
    begin
        case(op)
        7'b0000011: decode = 8'b10010101;
        7'b0100011: decode = 8'b01011001;
        7'b0010011: decode = 8'b00000101;
        7'b0110011: decode = 8'b00100101;
        7'b1101111: decode = 8'b00010110;
        7'b1100111: decode = 8'b00010111;
        default:    decode = 8'b00000000;
        endcase
    end
    endfunction
endmodule

