`timescale 1ns/1ps
`include "../rtl/Pipelined_top.v"

module tb();

    reg clk, rst;

    Pipelined_top DUT(
        .clk(clk),
        .rst(rst)
    );

    initial clk = 0;
    //clk generation
    always #50 clk = ~clk; //100ns -> 10Mhz

    //stimulus
    initial begin
        rst = 1'b0;
        #200;
        rst = 1'b1;
        #1000;
        rst = 1'b0;
        #100;
        $finish;
    end

    // initial begin
    //     $dumpfile("dump.vcd");
    //     $dumpvars;
    // end

endmodule 