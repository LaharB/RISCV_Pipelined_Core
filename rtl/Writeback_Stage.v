`include "Mux_3to1.v"

module Writeback_Stage(
    //coming to MEMORY Stage
    input [1:0] ResultSrcW,
    input [31:0] ALUResultW, ReadDataW, PCPlus4W,

    //going to DECODE and EXECUTE Stages
    output [31:0] ResultW
);

    //Mux_3x1 module
    Mux_3to1 Mux_3to1(
        .a(ALUResultW), 
        .b(ReadDataW), 
        .c(PCPlus4W),
        .sel(ResultSrcW),
        .y(RdW)
    );

endmodule