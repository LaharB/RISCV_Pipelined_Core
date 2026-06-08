# RISC-V Pipelined Core Implementation

This project showcases the design and implementation of a RISC-V Pipelined Core processor with Hazard Unit using Verilog HDL.The RTL schematic has been designed and simulation has been performed using Siemens Questasim 10.7c.

It is the modification of the previously designed [RISC-V Single Cycle Core processor](https://github.com/LaharB/RISCV_Single_Cycle_Core) where the processor executes a complete instruction in one clock cycle *(The time period of the clock cycle is decided by the execution time of the slowest instruction which is generally the loadWord instruction.)*

It is based on the **RV32I Base Integer Instruction Set Architecture** where the processor processes 32-bit wide data and instructions.

---------------------------------------------------------------------------------------

## What is pipelining ?

- Pipelining is a technique used to improve processor throughput by dividing instruction execution into a sequence of distinct stages. This allows **multiple instructions to be processed simultaneously, ideally completing one instruction per clock cycle once the pipeline is full.**
- In Pipelined processor, each stage gets executed in one clock cycle whose time period is decided by the fastest instruction or shortest datapath.

----------------------------------

## RISC-V Pipelined Architecture Diagram

![alt text](docs/RISCV_Pipelined_Core_Architecture.png)

-------------------------------------

## The 5-Stage Datapath









Following are the types of Instructions supported by the design:

- R-type(add, sub, and, or)
- I-type(addi, subi, andi, ori, lw)
- S-type(sw)
- B-type(beq)
- J-type(jal)

Currently, the processor supports Data Hazards resolution using Forwarding/Bypassing and Stalling technique. 
The schematic design and simulation has been carried out by using the Siemens Questasim 10.7c Simulator.