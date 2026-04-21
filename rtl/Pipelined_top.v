`include "Fetch_Stage.v";
`include "Decode_Stage.v";
`include "Execute_Stage.v";
`include "Memory_Stage.v";
`include "Writeback_Stage.v";

module Pipelined_top(
    input clk, rst,      
);
    //wires    
    

    //Fetch_Stage module 
    Fetch_Stage Fetch_Stage(
        .clk(),
        .rst(),
        .PCSrcE(),
        .PCTargetE(), 
        .InstrD(),
        .PCD(), 
        .PCPlus4D()
    );

    //Decode_Stage module 
    Decode_Stage Decode_Stage(

    );

    //Execute_Stage module
    Execute_Stage Execute_Stage(

    );

    //Memory_Stage module
    Memory_Stage Memory_Stage(

    );

    //Writeback module 
    Writeback_Stage Writeback_Stage(

    );


endmodule