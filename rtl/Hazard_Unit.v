module Hazard_Unit(
    input rst, RegWiteM, RegWriteM,
    input [4:0] RdM, RdW, Rs1E, Rs2E,
    output ForwardAE, ForwardBE
);

    assign ForwardAE = (!rst)? 2'b00 : 
                       ((RegWriteM == 1'b1) && (RdM != 5'h00) && (RdM == Rs1E)) ? 2'b10 : 
                       ((RegWriteW == 1'b1) && (RdW != 5'h00) && (RdW == Rs1E)) ? 2'b01 : 2'b00;

    assign ForwardBE = (!rst)? 2'b00 : 
                       ((RegWriteM == 1'b1) && (RdM != 5'h00) && (RdM == Rs2E)) ? 2'b10 : 
                       ((RegWriteW == 1'b1) && (RdW != 5'h00) && (RdW == Rs2E)) ? 2'b01 : 2'b00;
    
endmodule