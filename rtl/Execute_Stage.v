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
    output PCSrcE,
    output [31:0] PCTargetE   
);
    //wires
    wire SrcB_wire, ZeroE, CarryE, OverflowE, NegativeE;
    wire [31:0] ALUResultE_wire;
    wire and_to_or_wire; 

    //EXECUTE Stage Registers
    reg RegWriteE_reg, WriteMemE_reg;
    reg [1:0] ResultSrcE_reg;
    reg [31:0] ALUResultE_reg, RD2E_reg, PCPlus4E_reg;
    reg [4:0] WriteDataE_reg; //to store RD2E value 

    //Mux_2to1 module
    Mux_2to1 Mux_SrcBE(
        .a(RD2E), 
        .b(ImmExtE),
        .sel(ALUSrcE),
        .y(SrcB_wire)
    );

    //PC_Adder module
    PC_Adder PCTargetE(
        .a(PCE), 
        .b(ImmExtE),
        .c(PCTargetE)
    );

    //ALU module 
    ALU ALU(
        .SrcA(RD1E),
        .SrcB(SrcB_wire),
	    .ALUControl(ALUControlE), 
	    .Carry(CarryE), 
        .Overflow(OverflowE), 
        .Zero(ZeroE), 
        .Negative(NegativeE),
	    .result(ALUResultE_wire)
    );

    //Storing values inside EXECUTE Registers
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            RegWriteE_reg <= 1'b0; 
            WriteMemE_reg <= 1'b0;
            ResultSrcE_reg <= 2'b00;
            ALUResultE_reg <= 32'h0000_0000; 
            RD2E_reg <= 32'h0000_0000; 
            PCPlus4E_reg <= 32'h0000_0000;
            RdE_reg <= 5'h00;
        end 
        else begin
            RegWriteE_reg <= RegWriteE; 
            WriteMemE_reg <= WriteMemE;
            ResultSrcE_reg <= ResultSrcE;
            ALUResultE_reg <= ALUResultE; 
            WriteDataE_reg <= RD2E; 
            PCPlus4E_reg <= PCPlus4E;
            RdE_reg <= RdE;
        end
    end
    
    reg RegWriteE_reg, WriteMemE_reg;
    reg [1:0] ResultSrcE_reg;
    reg [31:0] ALUResultE_reg, RD2E_reg, PCPlus4E_reg,
    reg [4:0] RdE_reg,

    //and gate 
    assign and_to_or_wire = ZeroE & BranchE;

    //or gate
    assign PCSrcE = JumpE | and_to_or_wire; 

    //Passing values from EXECUTE Registers to WRITEBACK Stage
    assign RegWriteM = RegWriteE_reg;
    assign WriteMemM = WriteMemE_reg;
    assign ResultSrcM = ResultSrcE_reg;
    assign ALUResultM = ALUResultE_reg;
    assign WriteDataM = WriteDataE_reg;
    assign PCPlus4M = PCPlus4E_reg;
    assign RdM = RdE_reg;
  
endmodule