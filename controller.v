module controller(op, funct3, funct7, Regwswitch, Reg_load, do_store, ALUSrc, cal, mem_load, jump, addorjump, sltorsub, ex, ALUbnc);
    input [6:0] op;
    input [2:0] funct3;
    input [6:0] funct7;
    output Regwswitch, Reg_load, do_store, ALUSrc, cal, mem_load, jump, addorjump, sltorsub, ex, ALUbnc;

    wire [10:0] controls;

    assign {Regwswitch, do_store, ALUSrc, cal, mem_load, Reg_load, jump, addorjump, sltorsub, ex, ALUbnc} = controls;
    assign controls = decode(op, funct3);

    function [10:0] decode(input [6:0] op, input [2:0] funct3, input [6:0] funct7);
    begin
        case(op)
        7'b0000011: decode = 11'b10010101000;
        7'b0100011: decode = 11'b01011001000;
        7'b0010011: case(funct7)
                    7'b0100000: decode = 11'b00000101010;
                    default:    decode = 11'b00000101000;
        7'b0110011: decode = ((funct7 == 7'b0100000) && (funct3 == 3'b101)) ? 11'b00100101010 : 11'b00100101000;
        7'b1101111: decode = 11'b00010110000;
        7'b1100111: decode = 11'b00010111000;
        7'b1100011: case(funct3)
                    3'b000: decode = 11'b00100001111;
                    3'b001: decode = 11'b00100001111;
                    3'b100: decode = 11'b00100001011;
                    3'b101: decode = 11'b00100001011;
                    3'b110: decode = 11'b00100001011;
                    3'b111: decode = 11'b00100001011;
                    endcase
        default:    decode = 11'b00000000000;
        endcase
    end
    endfunction
endmodule

