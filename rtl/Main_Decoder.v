module Main_Decoder(
    input [6:0] op,
    //input zero,
    output RegWrite, MemWrite, ALUSrc, Branch, Jump, //PCSrc,
    output [1:0] ImmSrc, ResultSrc, ALUOp    
    );
    
    /*
    -- Main decoder has been designed for 5 types of instructions : lw , sw , R-type, beq and addi
    i.e each I-type, S-type, R-type and B-type is demonstrated

    -- Note: We have assumed some "dont care" values as 0 for simplicity
    // =======================================================================================================
    // Modified Main Control Unit Truth Table (with Jump)
    // =======================================================================================================
    // Instruction | Opcode  | RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp | Jump
    // ------------|---------|----------|--------|--------|----------|-----------|--------|-------|------
    // lw          | 0000011 |    1     |   00   |   1    |    0     |    01     |   0    |  00   |  0
    // sw          | 0100011 |    0     |   01   |   1    |    1     |    xx     |   0    |  00   |  0
    // R-type      | 0110011 |    1     |   xx   |   0    |    0     |    00     |   0    |  10   |  0
    // beq         | 1100011 |    0     |   10   |   0    |    0     |    xx     |   1    |  01   |  0
    // I-type ALU  | 0010011 |    1     |   00   |   1    |    0     |    00     |   0    |  10   |  0
    // jal         | 1101111 |    1     |   11   |   x    |    0     |    10     |   0    |  xx   |  1
    // =======================================================================================================
    */
    assign RegWrite = ((op == 7'b0000011) || (op == 7'b0110011) || (op == 7'b0010011) || (op == 7'b1101111)) ? 1'b1 : 1'b0;

    assign ImmSrc = (op == 7'b0100011) ? 2'b01 : (op == 7'b1100011) ? 2'b10 : ((op == 7'b0010011) || (op == 7'b0000011)) ? 2'b00 : (op == 1101111) ? 2'b11 : 2'bxx;   

    assign ALUSrc = ((op == 7'b0000011) || (op == 7'b0100011) || (op == 7'b0010011)) ? 1'b1 : ((op == 7'b0110011) || (op == 7'b1100011) )? 1'b0 : 1bx;

    assign MemWrite = (op == 7'b0100011) ? 1'b1 : 1'b0;

    assign ResultSrc = (op == 7'b0000011) ? 2'b01 : ((op == 7'b0110011) || (op == 7'b0010011)) ? 2'b00 : (op == 7'b1101111) ? 2'10 : 2'bxx;

    assign Branch = (op == 7'b1100011) ? 1'b1 : 1'b0;

    assign ALUOp = ((op == 7'b0110011) || (op = 7'b0010011)) ? 2'b10 : (op == 7'b1100011) ? 2'b01 : ((op == 7'b0000011) || (op == 7'b0100011)) ? 2'b00 : 2'bxx;

    assign Jump = (op == 7'b1101111) ? 1'b1 : 1'b0; 

    //assign PCSrc = zero & Branch; 
  
endmodule