`include "Data_Memory.v"

module Memory_Stage(
    input clk, rst,

    //from EXECUTE stage 
    input RegWriteM, MemWriteM,
    input [1:0] ResultSrcM,
    input [31:0] ALUResultM, WriteDataM, PCPlus4M,
    input [4:0] RdM,

    //going to WRITEBACK Stage 
    output RegWriteW,
    output [1:0] ResultSrcW,
    output [31:0] ALUResultW, ReadDataW, PCPlus4W,
    output [4:0] RdW
);
    //wires
    wire [31:0] ReadDataM_wire;

    //MEMORY Stage Registers
    reg RegWriteM_reg;
    reg [1:0] ResultSrcM_reg;
    reg [31:0] ALUResultM_reg, ReadDataM_reg, PCPlus4M_reg;
    reg [4:0] RdM_reg;

    //Data_Memory module 
    Data_Memory Data_Memory(
        .clk(clk), 
        .rst(rst), 
        .WE(MemWriteM),
        .A(ALUResultM), 
        .WD(WriteDataM), 
        .RD(ReadDataM_wire)
    );

    //storing values in MEMORY Stage Registers
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            RegWriteM_reg <= 1'b0;
            ResultSrcM_reg <= 2'b00;
            ALUResultM_reg <= 32'h0000_0000; 
            ReadDataM_reg <= 32'h0000_0000; 
            PCPlus4M_reg <= 32'h0000_0000;
            RdM_reg <= 5'h00;
        end
        else begin
            RegWriteM_reg <= RegWriteM;
            ResultSrcM_reg <= ResultSrcM;
            ALUResultM_reg <= ALUResultM; 
            ReadDataM_reg <= ReadDataM_wire, 
            PCPlus4M_reg <= PCPlus4M;
            RdM_reg <= RdM;
        end
    end

    //assign values from MEMORY Stage Registers to WRITEBACK Stage 
    assign RegWriteW = RegWriteM_reg;
    assign ResultSrcW = ResultSrcM_reg;
    assign ALUResultW = ALUResultM_reg;
    assign ReadDataW = ReadDataM_reg;
    assign PCPlus4W = PCPlus4M_reg;
    assign RdW = RdM_reg;
    
endmodule