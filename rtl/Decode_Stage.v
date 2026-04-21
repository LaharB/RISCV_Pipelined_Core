`include "Register_File.v"
`include "Control_Unit.v"
`include "Extend.v"

module Decode_Stage(
    input clk, rst,

    //from Decode Stage
    input [31:0] InstrD, PCD, PCPlus4D,

    //from Writeback Stage
    input RegWriteW, 
    input [5:0] RDW,
    input [31:0] ResultW,

    //going to Execute Stage
    output RegWriteE, MemWriteE, JumpE, BranchE, , ALUSrcE,
    output [1:0] ResultSrcE,
    output [2:0] ALUControlE,
    
    output [31:0] RD1E, RD2E, ImmExtE
    //output [4:0] RS1E, RS2E, //signals for hazard unit 
    output [4:0] RdE,
    output [31:0] PCE, PCPlus4E,
);
    //wire
    wire RegWrite, MemWrite, ALUSrc, ResultSrc, Jump
    wire [1:0] 




    //Control_Unit module
    Control_Unit Control_Unit(
        .Op(InstrD[6:0]), 
        .funct7(InstrD[31:25]),
        .funct3(InstrD[14:12]),
        //.Zero(), 
        .RegWrite(), 
        .MemWrite(), 
        .ALUSrc(), 
        .ResultSrc(), 
        .PCSrc(),
        .ImmSrc(),
        .ALUControl()
    );

    //Register_File module
    Register_File Register_File(
        .A1(), 
        .A2(), 
        .A3(),
        .WD3(),
        .RD1(), 
        .RD2()
    );

    //Extend module
    Extend Extend(
        .Instr(),
        .ImmSrc(),
        .Imm_Ext()
    );

    //passing the values to DECODE Stage Registers




    //passignt he values from  DECODE to EXECUTE Stage


    
endmodule