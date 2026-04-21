`include "Fetch_Stage.v";
`include "Decode_Stage.v";
`include "Execute_Stage.v";
`include "Memory_Stage.v";
`include "Writeback_Stage.v";

module Pipelined_top(
    input clk, rst,      
);
    //wires    
    wire PCSrcE_wire, RegWriteW_wire, RegWriteE_wire, MemWriteE_wire, JumpE_wire,
    wire [31:0] PCTargetE_wire, InstrD_wire, PCD_wire, PCPlus4D_wire, ResultW_wire,
    wire [4:0] RdW_wire, 

    //Fetch_Stage module 
    Fetch_Stage Fetch_Stage(
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE_wire),
        .PCTargetE(PCTargetE_wire),
        .InstrD(InstrD_wire),
        .PCD(PCD_wire), 
        .PCPlus4D(PCPlus4D_wire)
    );

    //Decode_Stage module 
    Decode_Stage Decode_Stage(
        .clk(clk), 
        .rst(rst),
        .InstrD(InstrD_wire), 
        .PCD(PCD_wire), 
        .PCPlus4D(PCPlus4D_wire),
        .RegWriteW(RegWriteW_wire), 
        .RdW(RdW_wire),
        .ResultW(ResultW_wire)
        .RegWriteE(RegWriteE_wire), 
        .MemWriteE(MemWriteE_wire), 
        .JumpE(JumpE_wire), 
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
        .clk(clk), 
        .rst(rst),
        .RegWriteE(RegWriteE_wire), 
        .MemWriteE(MemWriteE_wire), 
        .JumpE(JumpE_wire), 
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
        .RegWriteM(), 
        .WriteMemM(),
        .ResultSrcM(),
        .ALUResultM(), 
        .WriteDataM(), 
        .PCPlus4M(),
        .RdM(),
        .PCSrcE(PCSrcE_wire),
        .PCTargetE(PCTargetE_wire)
    );

    //Memory_Stage module
    Memory_Stage Memory_Stage(
        .clk(clk), 
        .rst(rst),
        .RegWriteM(), 
        .MemWriteM(),
        .ResultSrcM(),
        .ALUResultM(), 
        .WriteDataM(), 
        .PCPlus4M(),
        .RdM(), 
        .RegWriteW(RegWriteW_wire),
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
        .ResultW(ResultW_wire)
    );


endmodule