module controller(op, funct3, funct7, Regwswitch, Reg_load, do_store, ALUSrc, cal, mem_load, jump, addorjump, sltorsub, ex, ALUbnc, lui_ctrl, auipc_ctrl);
    input [6:0] op;
    input [2:0] funct3;
    input [6:0] funct7;
    output Regwswitch, Reg_load, do_store, ALUSrc, cal, mem_load, jump, addorjump, sltorsub, ex, ALUbnc, lui_ctrl, auipc_ctrl;

    wire [12:0] controls;

    assign {Regwswitch, do_store, ALUSrc, cal, mem_load, Reg_load, jump, addorjump, sltorsub, ex, ALUbnc, lui_ctrl, auipc_ctrl} = controls;
    assign controls = decode(op, funct3, funct7);

    function [12:0] decode(input [6:0] op, input [2:0] funct3, input [6:0] funct7);
    begin
        case(op)
        7'b0000011: decode = 13'b1001010100000;
        7'b0100011: decode = 13'b0101100100000;
        7'b0010011: case(funct7)
                    7'b0100000: decode = 13'b0000010101000;
                    default:    decode = 13'b0000010100000;
                    endcase
        7'b0110011: decode = ((funct7 == 7'b0100000) && (funct3 == 3'b101)) ? 13'b0010010101000 : 13'b0010010100000;
        7'b1101111: decode = 13'b0001011000000;
        7'b1100111: decode = 13'b0001011100000;
        7'b1100011: case(funct3)
                    3'b000: decode = 13'b0010000111100;
                    3'b001: decode = 13'b0010000111100;
                    3'b100: decode = 13'b0010000101100;
                    3'b101: decode = 13'b0010000101100;
                    3'b110: decode = 13'b0010000101100;
                    3'b111: decode = 13'b0010000101100;
                    endcase
        7'b0110111: decode = 13'b0001010000010;
        7'b0010111: decode = 13'b0001010000001;
        default:    decode = 13'b0000000000000;
        endcase
    end
    endfunction
endmodule

