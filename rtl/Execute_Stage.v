`include "Mux_2to1.v"
`include "PC_Adder.v"
`include "ALU.v"

module Execute_Stage(
    input clk, rst,
    
    //from Decode Stage
    input RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE,
    input [1:0] ResultSrcE,
    input  [2:0] ALUControlE,
    input  [31:0] RD1E, RD2E, ImmExtE 
    input [4:0] RdE,
    input [31:0] PCE, PCPlus4E,

    //going to Memory Stage
    output RegWriteM, WriteMemM,
    output [1:0] ResultSrcM,
    output [31:0] ALUResultM, WriteDataM, PCPlus4M,
    output [4:0] RdM,

    //going to Execute Stage
    output [31:0] PCTargetE   
);
    //wires

    wire 


    //and gate 
    assign 

    //or gate
    aasign 

    //Mux_2to1 module
    Mux_2to1 Mux_SrcBE(
        .a(), 
        .b(),
        .sel(),
        .y()
    );

    //PC_Adder module
    PC_Adder PCTargetE(
        .a(), 
        .b(),
        .c()
    );

    //



    
endmodule