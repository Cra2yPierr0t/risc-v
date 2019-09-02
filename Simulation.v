module Simulation();
    reg reset;
    reg clock;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,Computer);
    end

    Computer Computer(reset, clock);

    initial begin
        reset = 1'b1;
        clock = 1'b0;
    end

    always #1 begin
        clock = ~clock;
    end

    initial begin
        reset = 1'b1;
        #1
        reset = 1'b0;
        #700
        $finish;
    end
endmodule


