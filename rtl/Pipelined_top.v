`include "Fetch_Stage.v"
`include "Decode_Stage.v"
`include "Execute_Stage.v"
`include "Memory_Stage.v"
`include "Writeback_Stage.v"
`include "Instruction_Memory.v"
`include "Mux_2to1.v"
`include "PC.v"
`include "PC_Adder.v"
`include "Register_File.v"
`include "Control_Unit.v"
`include "Extend.v"
`include "ALU.v"
`include "Data_Memory.v"
`include "Mux_3to1.v"
`include "Hazard_Unit.v"

module Pipelined_top(
    input clk, rst      
);
    //wires    
    wire PCSrcE_wire, RegWriteW_wire, RegWriteE_wire, MemWriteE_wire, JumpE_wire, BranchE_wire, ALUSrcE_wire, RegWriteM_wire, MemWriteM_wire; 
    wire [1:0] ResultSrcE_wire, ResultSrcM_wire, ResultSrcW_wire;
    wire [2:0] ALUControlE_wire;
    wire [31:0] PCTargetE_wire, InstrD_wire, PCD_wire, PCPlus4D_wire, ResultW_wire, RD1E_wire, RD2E_wire, ImmExtE_wire, PCE_wire, PCPlus4E_wire, ALUResultM_wire, WriteDataM_wire, PCPlus4M_wire, ALUResultW_wire, ReadDataW_wire, PCPlus4W_wire;
    wire [4:0] RdW_wire, RdE_wire, RdM_wire;

    //wires for Hazard Unit
    
    wire [4:0]

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
        .ResultW(ResultW_wire),
        .RegWriteE(RegWriteE_wire), 
        .MemWriteE(MemWriteE_wire), 
        .JumpE(JumpE_wire), 
        .BranchE(BranchE_wire), 
        .ALUSrcE(ALUSrcE_wire),
        .ResultSrcE(ResultSrcE_wire),
        .ALUControlE(ALUControlE_wire),
        .RD1E(RD1E_wire), 
        .RD2E(RD2E_wire), 
        .ImmExtE(ImmExtE_wire),
        .RdE(RdE_wire),
        .PCE(PCE_wire), 
        .PCPlus4E(PCPlus4E_wire)
    );

    //Execute_Stage module
    Execute_Stage Execute_Stage(
        .clk(clk), 
        .rst(rst),
        .RegWriteE(RegWriteE_wire), 
        .MemWriteE(MemWriteE_wire), 
        .JumpE(JumpE_wire), 
        .BranchE(BranchE_wire), 
        .ALUSrcE(ALUSrcE_wire),
        .ResultSrcE(ResultSrcE_wire),
        .ALUControlE(ALUControlE_wire),
        .RD1E(RD1E_wire), 
        .RD2E(RD2E_wire), 
        .ImmExtE(ImmExtE_wire),
        .RdE(RdE_wire),
        .PCE(PCE_wire), 
        .PCPlus4E(PCPlus4E_wire),
        .RegWriteM(RegWriteM_wire), 
        .MemWriteM(MemWriteM_wire),
        .ResultSrcM(ResultSrcM_wire),
        .ALUResultM(ALUResultM_wire), 
        .WriteDataM(WriteDataM_wire), 
        .PCPlus4M(PCPlus4M_wire),
        .RdM(RdM_wire),
        .PCSrcE(PCSrcE_wire),
        .PCTargetE(PCTargetE_wire)
    );

    //Memory_Stage module
    Memory_Stage Memory_Stage(
        .clk(clk), 
        .rst(rst),
        .RegWriteM(RegWriteM_wire), 
        .MemWriteM(MemWriteM_wire),
        .ResultSrcM(ResultSrcM_wire),
        .ALUResultM(ALUResultM_wire), 
        .WriteDataM(WriteDataM_wire), 
        .PCPlus4M(PCPlus4M_wire),
        .RdM(RdM_wire), 
        .RegWriteW(RegWriteW_wire),
        .ResultSrcW(ResultSrcW_wire),
        .ALUResultW(ALUResultW_wire), 
        .ReadDataW(ReadDataW_wire), 
        .PCPlus4W(PCPlus4W_wire),
        .RdW(RdW_wire)
    );

    //Writeback module 
    Writeback_Stage Writeback_Stage(
        .ResultSrcW(ResultSrcW_wire),
        .ALUResultW(ALUResultW_wire), 
        .ReadDataW(ReadDataW_wire), 
        .PCPlus4W(PCPlus4W_wire),
        .ResultW(ResultW_wire)
    );

    //Hazard_Unit module


endmodule