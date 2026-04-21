`include "Mux_2to1.v"
`include "PC_Adder.v"
`include "ALU.v"

module Execute_Stage(
    input clk, rst,
    input RegWriteE, 
    input MemWriteE, 
    input JumpE, 
    input BranchE,
    ALUSrcE,
    output [1:0] ResultSrcE,
    output [2:0] ALUControlE,
    
    output [31:0] RD1E, RD2E, ImmExtE 
    output [4:0] RdE,
    output [31:0] PCE, PCPlus4E,
    
);
    
endmodule