module Computer(reset, clock);
    input reset, clock;

    wire [31:0] instruction, pc, ram_addr, ram_out, ram_data;
    wire mem_load;

    CPU CPU(instruction, pc, ram_addr, ram_out, mem_load, ram_data, reset, clock);
    ROM ROM(pc, instruction);
    RAM(ram_data, ram_addr, mem_load, ram_out, clock);
endmodule
