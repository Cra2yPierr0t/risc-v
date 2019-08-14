module CPU(instruction, pc, alu_out, ram_out, mem_load, r2_out_change, reset, clock);
    input [31:0] instruction, ram_out;
    input reset, clock;
    output [31:0] pc, alu_out, r2_out_change;
    output mem_load;

    wire [31:0] r1_out, Extended_data, alu_out, ram_out_change, wd3, r2_out, SrcB, sign_out;
    wire [11:0] sign_in;
    wire [6:0] op;
    wire [2:0] ctrl;
    wire Regwswitch, Reg_load, do_store, ALU_Src, cal, mem_load;

    controller controller(op, Regwswitch, Reg_load, do_store, ALU_Src, cal, mem_load);

    PC PC(32'h00000000, 1'b0, pc, reset, clock);

    assign wd3 = Regwswitch ? ram_out_change : alu_out;
    assign sign_in = do_store ? { instruction[31:25], instruction[11:7] } : instruction[31:20];

    SignExtender SignExtender(sign_in, sign_out);

    Regfile Regfile(instruction[11:7], Reg_load, wd3, instruction[19:15], instruction[24:20], r1_out, r2_out, reset, clock); 

    Store_Length_Changer Store_Length_Changer(r2_out, instruction[14:12], r2_out_change);
    Load_Length_Changer Load_Length_Changer(ram_out, instruction[14:12], ram_out_change);

    assign SrcB = ALU_Src ? r2_out : sign_out;
    assign ctrl = cal ? 3'b000 : instruction[14:12];

    ALU ALU(r1_out, SrcB, ctrl, alu_out);
endmodule




