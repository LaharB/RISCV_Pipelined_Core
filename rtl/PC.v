module PC(
    input clk, rst,
    //for Hazard Unit - Stalling 
    input en, //active low enable 
    input [31:0] PC_Next,
    output reg [31:0] PC
);

    always@(posedge clk)
        begin
            if(!rst)
                PC <= 32'h0000_0000; 
            else if(!en) 
                PC <= PC_Next;    
        end
    
endmodule