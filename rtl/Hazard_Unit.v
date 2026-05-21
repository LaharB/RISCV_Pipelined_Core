module Hazard_Unit(
    input rst, RegWriteW, RegWriteM,
    input [1:0] ResultSrcE,
    input [4:0] RdE, RdM, RdW, Rs1E, Rs2E,
    input [4:0] Rs1D, Rs2D,
    //for forwarding
    output [1:0] ForwardAE, ForwardBE,
    //for stalling
    output StallF, StallD, FlushE
);

/*
 * ==================================================================================================================
 * | Mux control   | Source   | Explanation                                                                         |
 * |===============|==========|=====================================================================================|
 * | ForwardA = 00 | ID/EX    | The first ALU operand comes from the register file.                                 |
 * | ForwardA = 10 | EX/MEM   | The first ALU operand is forwarded from the prior ALU result.                       |
 * | ForwardA = 01 | MEM/WB   | The first ALU operand is forwarded from data memory or an earlier ALU result.       |
 * |---------------|----------|-------------------------------------------------------------------------------------|
 * | ForwardB = 00 | ID/EX    | The second ALU operand comes from the register file.                                |
 * | ForwardB = 10 | EX/MEM   | The second ALU operand is forwarded from the prior ALU result.                      |
 * | ForwardB = 01 | MEM/WB   | The second ALU operand is forwarded from data memory or an earlier ALU result.      |
 * ==================================================================================================================
 */
    //forwarding
    assign ForwardAE = (!rst)? 2'b00 : 
                       ((RegWriteM == 1'b1) && (RdM != 5'h00) && (RdM == Rs1E)) ? 2'b10 : 
                       ((RegWriteW == 1'b1) && (RdW != 5'h00) && (RdW == Rs1E)) ? 2'b01 : 2'b00;

    assign ForwardBE = (!rst)? 2'b00 : 
                       ((RegWriteM == 1'b1) && (RdM != 5'h00) && (RdM == Rs2E)) ? 2'b10 : 
                       ((RegWriteW == 1'b1) && (RdW != 5'h00) && (RdW == Rs2E)) ? 2'b01 : 2'b00;
    
    //stalling for lw 
    assign StallF = (!rst) ? 1'b0 : 
                    ((ResultSrcE[0] == 1'b1) && ((Rs1D == RdE) || (Rs2D == RdE))) ? 1'b1 : 1'b0;
    assign StallD = (!rst) ? 1'b0 : 
                    ((ResultSrcE[0] == 1'b1) && ((Rs1D == RdE) || (Rs2D == RdE))) ? 1'b1 : 1'b0;
    assign FlushE = (!rst) ? 1'b0 : 
                    ((ResultSrcE[0] == 1'b1) && ((Rs1D == RdE) || (Rs2D == RdE))) ? 1'b1 : 1'b0;

endmodule