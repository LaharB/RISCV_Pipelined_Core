`include "Register_File.v"
`include "Control_Unit.v"
`include "Extend.v"

module Decode_Stage(
    input clk, rst,

    //from Fetch Stage
    input [31:0] InstrD, PCD, PCPlus4D,

    //from Writeback Stage
    input RegWriteW, 
    input [5:0] RDW,
    input [31:0] ResultW,

    //going to Execute Stage
    output RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE,
    output [1:0] ResultSrcE,
    output [2:0] ALUControlE,
    
    output [31:0] RD1E, RD2E, ImmExtE 
    output [4:0] RdE,
    output [31:0] PCE, PCPlus4E,
);
    //wires
    wire RegWriteD, MemWriteD, ALUSrcD, BranchD, JumpD;
    wire [1:0] ImmSrcD, ResultSrcD; 
    wire [2:0] ALUControlD;
    wire [31:0] RD1D_wire, RD2D_wire, ImmExtD_wire;

    //DECODE Stage Registers
    reg RegWriteD_reg, MemWriteD_reg, ALUSrcD_reg, BranchD_reg, JumpD_reg;
    reg [1:0] ResultSrcD_reg; 
    reg [2:0] ALUControlD_reg;
    reg [31:0] RD1D_reg, RD2D_reg, ImmExtD_reg;
    reg [4:0] RdD_reg;  
    reg [31:0] PCD_reg, PCPlus4D_reg;

    //Control_Unit module
    Control_Unit Control_Unit(
        .Op(InstrD[6:0]), 
        .funct7(InstrD[31:25]),
        .funct3(InstrD[14:12]),
        .RegWrite(RegWriteD), 
        .MemWrite(MemWriteD), 
        .ALUSrc(ALUSrcD),
        .Branch(BranchD),
        .Jump(JumpD),
        .ImmSrc(ImmSrcD),
        .ResultSrc(ResultSrcD), 
        .ALUControl(ALUControlD)
    );

    //Register_File module
    Register_File Register_File(
        .clk(clk), 
        .rst(rst), 
        .WE3(RegWriteW),
        .A1(InstrD[19:15]), 
        .A2(InstrD[24:20]), 
        .A3(RDW),
        .WD3(ResultW),
        .RD1(RD1D_wire), 
        .RD2(RD2D_wire)
    );

    //Extend module
    Extend Extend(
        .Instr(InstrD[31:7]),
        .ImmSrc(ImmSrcD),
        .Imm_Ext(ImmExtD_wire)
    );

    //storing the values to DECODE Stage Registers
    always@(posedge clk or negedge rst) begin
        if(!rst)
            begin
                RegWriteD_reg <= 1'b0; 
                MemWriteD_reg <= 1'b0; 
                ALUSrcD_reg <= 1'b0; 
                ResultSrcD_reg <= 2'b00;
                BranchD_reg <= 1'b0; 
                JumpD_reg <= 1'b0;
                ALUControlD_reg <= 3'b000;
                RD1D_reg <= 32'h0000_0000; 
                RD2D_reg <= 32'h0000_0000, 
                ImmExtD_reg <= 32'h0000_0000;
                RdD_reg <= 5'h00;  
                PCD_reg <= 32'h0000_0000; 
                PCPlus4D_reg <= 32'h0000_0000;
            end 
        else
            begin
                RegWriteD_reg <= RegWriteD; 
                MemWriteD_reg <= MemWriteD; 
                ALUSrcD_reg <= ALUSrcD; 
                ResultSrcD_reg <= 'ResultSrcD;
                BranchD_reg <= BranchD; 
                JumpD_reg <= JumpD;
                ALUControlD_reg <= ALUControlD;
                RD1D_reg <= RD1D_wire; 
                RD2D_reg <= RD2D_wire, 
                ImmExtD_reg <= ImmExtD_wire;
                RdD_reg <= InstrD[11:7];  
                PCD_reg <= PCD; 
                PCPlus4D_reg <= PCPlus4D;
            end

    end

    //passing the values from  DECODE Stage Registers to EXECUTE Stage
    assign RegWriteE = RegWriteD_reg ; 
    assign MemWriteE = MemWriteD_reg; 
    assign JumpE = JumpD_reg; 
    assign BranchE = BranchD_reg;  
    assign ALUSrcE = ALUSrcD_reg;
    assign ResultSrcE = ResultSrcD_reg; 
    assign ALUControlE = ALUControlD_reg; 
    assign RD1E = RD1D_reg; 
    assign RD2E = RD1D_reg; 
    assign ImmExtE = ImmExtD_reg; 
    assign RdE = RdD_reg;
    assign PCE = PCD_reg; 
    assign PCPlus4E =PCPlus4D_reg;
    
endmodule