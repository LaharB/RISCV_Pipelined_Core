`include "Instruction_Memory.v"
`include "Mux_2to1.v"
`include "PC.v"
`include "PC_Adder.v"

module Fetch_Stage(
    input clk,rst,
    
    //coming from Execute stage
    input PCSrcE,
    input [31:0] PCTargetE, 
    
    //going to Decode stage
    output [31:0] InstrD, 
    output [31:0] PCD, PCPlus4D
);
    //wires
    wire [31:0] PCF_, PCF, PCPlus4F;
    wire [31:0] InstrF;

    //Fetch Stage Registers
    reg [31:0] InstrF_reg;
    reg [31:0] PCF_reg, PCPlus4F_reg;

    //Mux2x1 module
    Mux_2to1 Mux(
        .a(PCPlus4F), 
        .b(PCTargetE),
        .sel(PCSrcE),
        .y(PCF_) 
    );

    //PC module 
    PC PC(
        .clk(clk), 
        .rst(rst),
        .PC_Next(PCF_),
        .PC(PCF)
    );

    //Instruction Memory module
    Instruction_Memory Instruction_Mem(
        .rst(rst),
        .A(PCF), 
        .RD(InstrF) 
    );

    //PC_Adder module
    PC_Adder PCPlus4(
        .a(PCF), 
        .b(32'h0004),
        .c(PCPlus4F)
    );

    //storing the values to Fetch Stage Registers
    always@(posedge clk or negedge rst) begin
        if(!rst) //active low reset 
            begin
               InstrF_reg <= 32'h0000;
               PCF_reg <= 32'h0000;
               PCPlus4F_reg <= 32'h0004; 
            end
        else 
            begin
               InstrF_reg <= InstrF;
               PCF_reg <= PCF; 
               PCPlus4F_reg <= PCPlus4F; 
            end
    end    

    //Passing from FETCH Stage Registers to DECODE Stage
    assign InstrD = (!rst) ? 32'h0000_0000 : InstrF_reg;
    assign PCD = (!rst) ? 32'h0000_0000 : PCF_reg;
    assign PCPlus4D = (!rst) ? 32'h0000_0000 : PCPlus4F_reg;
    
endmodule 