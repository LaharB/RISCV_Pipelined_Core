module PC(
    input clk, rst,
    //comign from Hazard Unit - Stalling 
    input en,
    input [31:0] PC_Next,
    output reg [31:0] PC
);

    always@(posedge clk)
        begin
            if(!rst)
                PC <= 32'h0000_0000; 
            else if(!en) //active low enable 
                PC <= PC_Next;    
        end
    
endmodule