`include "Main_Decoder.v"
`include "ALU_Decoder.v"

module Control_Unit(
    input [6:0] Op, funct7,
    input [2:0] funct3,
    //input Zero, //input zero flag comes from ALU in Execute Stage  
    output RegWrite, MemWrite, ALUSrc, Branch, Jump,
    output [1:0] ImmSrc, ResultSrc, 
    output [2:0] ALUControl
);

    wire [1:0] ALUOp;

    Main_Decoder Main_Decoder(
        .op(Op),
        //.zero(Zero), 
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc), 
        .ResultSrc(ResultSrc), 
        .PCSrc(PCSrc),
        .ImmSrc(ImmSrc), 
        .ALUOp(ALUOp) 
    );

    ALU_Decoder ALU_Decoder(
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7), 
        .op(Op),
        .ALUControl(ALUControl)
    );
    
endmodule