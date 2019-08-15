module CPU(instruction, pc_out, alu_out, ram_out, mem_load, r2_out_change, reset, clock);
    input [31:0] instruction, ram_out;
    input reset, clock;
    output [31:0] pc_out, alu_out, r2_out_change;
    output mem_load;

    wire [31:0] r1_out, SrcA, Extended_data, alu_out, ram_out_change, wd3, r2_out, SrcB, sign_out, jaljalrimm, jal_imm, jalr_imm, uoo;
    wire [11:0] sign_in;
    wire [2:0] ctrl;
    wire Regwswitch, Reg_load, do_store, ALU_Src, cal, mem_load, jump, addorjump;

    controller controller(instruction[6:0], Regwswitch, Reg_load, do_store, ALU_Src, cal, mem_load, jump, addorjump);

    PC PC(pc_in, jump, pc_out, reset, clock);
    assign pc4plus = pc_out + 4;
    assign pc_in = jump ? alu_out : pc4plus;

    assign wd3pre = Regwswitch ? ram_out_change : alu_out;
    assign sign_in = do_store ? { instruction[31:25], instruction[11:7] } : instruction[31:20];

    SignExtender SignExtender_0(sign_in, sign_out);

    assign wd3 = jump ? pc4plus : wd3pre;
    Regfile Regfile(instruction[11:7], Reg_load, wd3, instruction[19:15], instruction[24:20], r1_out, r2_out, reset, clock); 

    Store_Length_Changer Store_Length_Changer(r2_out, instruction[14:12], r2_out_change);
    Load_Length_Changer Load_Length_Changer(ram_out, instruction[14:12], ram_out_change);

    assign uoo = ALU_Src ? r2_out : sign_out;
    assign ctrl = cal ? 3'b000 : instruction[14:12];
    
    SignExtender SignExtender_1(instruction[31:20], jalr_imm);
    SignExtender_jal SignExtender_jal(instruction[31:12], jal_imm);
    
    assign jaljalrimm = addorjump ? jalr_imm : jal_imm;
    
    assign SrcB = jump ? jaljalrimm : uoo;
    assign SrcA = addorjump ? rd1_out : pc_out;
    ALU ALU(SrcA, SrcB, ctrl, alu_out);
endmodule




