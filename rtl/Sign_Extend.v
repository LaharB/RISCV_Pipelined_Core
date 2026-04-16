module Sign_Extend(
    input [31:0] Instr,
    input [1:0] ImmSrc,
    output reg [31:0] Imm_Ext
);
    // ==============================================================================================================
    // ImmSrc Encoding Truth Table (Immediate Extension)
    // ==============================================================================================================
    // ImmSrc | ImmExt                                                          | Type | Description
    // -------|-----------------------------------------------------------------|------|-----------------------------
    //   00   | {{20{Instr[31]}}, Instr[31:20]}                                 |  I   | 12-bit signed immediate
    //   01   | {{20{Instr[31]}}, Instr[31:25], Instr[11:7]}                    |  S   | 12-bit signed immediate
    //   10   | {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}    |  B   | 13-bit signed immediate
    //   11   | {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}  |  J   | 21-bit signed immediate
    // ==============================================================================================================

    always@(*)
        begin
            case(ImmSrc)
                2'b00 : Imm_Ext = {{20{Instr[31]}}, Instr[31:20]};
                2'b01 : Imm_Ext = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
                2'b10 : Imm_Ext = {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0};
                2'b11 : Imm_Ext = {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0};
            endcase
        end

endmodule