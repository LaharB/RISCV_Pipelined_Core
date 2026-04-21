`include "Fetch_Stage.v";
`include "Decode_Stage.v";
`include "Execute_Stage.v";
`include "Memory_Stage.v";
`include "Writeback_Stage.v";

module Pipelined_top(
    input clk, rst,      
);
    //wires    


    //Fetch_Stage module 
    Fetch_Stage Fetch_Stage(
        .clk(),
        .rst(),
        .PCSrcE(),
        .PCTargetE(),
        .InstrD(),
        .PCD(), 
        .PCPlus4D()
    );

    //Decode_Stage module 
    Decode_Stage Decode_Stage(
        .clk(), 
        .rst(),
        .InstrD(), 
        .PCD(), 
        .PCPlus4D(),
        .RegWriteW(), 
        .RDW(),
        .ResultW()
        .RegWriteE(), 
        .MemWriteE(), 
        .JumpE(), 
        .BranchE(), 
        .ALUSrcE(),
        .ResultSrc()E,
        .ALUControlE(),
        .RD1E(), 
        .RD2E(), 
        .ImmExtE() 
        .RdE(),
        .PCE(), 
        .PCPlus4E()
    );

    //Execute_Stage module
    Execute_Stage Execute_Stage(
        .clk(), 
        .rst(),
        .RegWriteE(), 
        .MemWriteE(), 
        .JumpE(), 
        .BranchE(), 
        .ALUSrcE(),
        .ResultSrcE(),
        .ALUControlE(),
        .RD1E(), 
        .RD2E(), 
        .ImmExtE(),
        .RdE(),
        .PCE(), 
        .PCPlus4E(),
        RegWriteM(), 
        WriteMemM(),
        ResultSrcM(),
        ALUResultM(), 
        WriteDataM(), 
        PCPlus4M(),
        RdM(),
        PCSrcE(),
        PCTargetE()
    );

    //Memory_Stage module
    Memory_Stage Memory_Stage(
        .clk(), 
        .rst(),
        .RegWriteM(), 
        .MemWriteM(),
        .ResultSrcM(),
        .ALUResultM(), 
        .WriteDataM(), 
        .PCPlus4M(),
        .RdM(), 
        .RegWriteW(),
        .ResultSrcW(),
        .ALUResultW(), 
        .ReadDataW(), 
        .PCPlus4W(),
        .RdW()
    );

    //Writeback module 
    Writeback_Stage Writeback_Stage(
        .ResultSrcW(),
        .ALUResultW(), 
        .ReadDataW(), 
        .PCPlus4W(),
        .ResultW()
    );


endmodule