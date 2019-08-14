module controller(op, Regwswitch, Reg_load, do_store, ALUSrc, cal, mem_load);
    input [6:0] op;
    output Regwswitch, Reg_load, do_store, ALUSrc, cal, mem_load;

    wire [5:0] controls;

    assign {Regwswitch, do_store, ALUSrc, cal, mem_load, Reg_load} = controls;
    assign controls = decode(op);

    function [5:0] decode(input [6:0] op);
    begin
        case(op)
        7'b0000011: decode = 6'b100101;
        7'b0100011: decode = 6'b010110;
        7'b0010011: decode = 6'b000001;
        7'b0110011: decode = 6'b001001;
        endcase
    end
    endfunction
endmodule

