# RISC-V Pipelined Core Implementation

This project showcases the design and implementation of a RISC-V Pipelined Core processor with Hazard Unit using Verilog HDL.The RTL schematic has been designed and simulation has been performed using Siemens Questasim 10.7c.

It is the modification of the previously designed [RISC-V Single Cycle Core processor](https://github.com/LaharB/RISCV_Single_Cycle_Core) where the processor executes a complete instruction in one clock cycle *(The time period of the clock cycle is decided by the execution time of the slowest instruction which is generally the loadWord instruction.)*

It is based on the **RV32I Base Integer Instruction Set Architecture** where the processor processes 32-bit wide data and instructions.

---------------------------------------------------------------------------------------

## What is pipelining ?

- Pipelining is a technique used to improve processor throughput by dividing instruction execution into a sequence of distinct stages. This allows **multiple instructions to be processed simultaneously, ideally completing one instruction per clock cycle once the pipeline is full.**
- In Pipelined processor, each stage gets executed in one clock cycle whose time period is decided by the fastest instruction or instruction having the shortest datapath.

----------------------------------

## RISC-V Pipelined Architecture Diagram

![alt text](docs/RISCV_Pipelined_Core_Architecture.png)

-------------------------------------

## The 5-Stage Datapath

The classic RISC-V pipeline is divided into five stages where each of these stages is completed within one clock cycle.Following points explain how data flows through these stages which is essential for a complete architectural overview.

1. **Instruction Fetch(IF):** The processor retrieves the next 32-bit instruction from the Instruction Memory using the current address stored in the Program Counter (PC). The PC is simultaneously updated to point to the next sequential instruction (PC + 4).
  
2. **Instruction Decode (ID):** The fetched instruction is parsed. The control unit extracts the opcode to generate necessary control signals. Simultaneously, the required source registers (rs1, rs2) are read from the Register File. Immediate generation logic also extends immediate values to 32 bits.
   
3. **Execute (EX):** The Arithmetic Logic Unit (ALU) performs the computation dictated by the instruction (e.g., addition, subtraction, bitwise operations). For memory access instructions, the ALU computes the effective memory address. For branch instructions, the branch condition is evaluated here.

4. **Memory Access (MEM):** This stage is active only for load and store instructions. Data is either read from or written to the Data Memory at the address calculated in the EX stage. Non-memory instructions simply pass their results through this stage.

5. **Write Back (WB):** The final operation result—either the output from the ALU or the data fetched from the Data Memory—is written back into the destination register (rd) in the Register File.
   
----------------------------------

## Supported Instructions 

Some modifications have been done in the Main Decoder and Immediate Extend logic (shown in the following truth tables respectively) to support **I-Type ALU** instructions as well as **J-Type instrcution(jal)**.

### Main Decoder truth table enhanced to support I-type ALU and jal

| Instruction | Opcode | RegWrite | ImmSrc | ALUSrc | MemWrite | ResultSrc | Branch | ALUOp | Jump |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| `lw` | 0000011 | 1 | 00 | 1 | 0 | 01 | 0 | 00 | 0 |
| `sw` | 0100011 | 0 | 01 | 1 | 1 | xx | 0 | 00 | 0 |
| `R-type` | 0110011 | 1 | xx | 0 | 0 | 00 | 0 | 10 | 0 |
| `beq` | 1100011 | 0 | 10 | 0 | 0 | xx | 1 | 01 | 0 |
| `I-type ALU` | 0010011 | 1 | 00 | 1 | 0 | 00 | 0 | 10 | 0 |
| `jal` | 1101111 | 1 | 11 | x | 0 | 10 | 0 | xx | 1 |

---

### ImmSrc encoding

| ImmSrc | ImmExt | Type | Description |
| :---: | :--- | :---: | :--- |
| 00 | `{{20{Instr[31]}}, Instr[31:20]}` | I | 12-bit signed immediate |
| 01 | `{{20{Instr[31]}}, Instr[31:25], Instr[11:7]}` | S | 12-bit signed immediate |
| 10 | `{{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}` | B | 13-bit signed immediate |
| 11 | `{{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}` | J | 21-bit signed immediate |

So now, following are the types of Instructions supported by the design:

- R-type(add, sub, and, or)
- I-type(addi, subi, andi, ori, lw)
- S-type(sw)
- B-type(beq)
- J-type(jal)
  
-------------------------------------------------------

## Pipeline Hazards and Resolutions



Currently, the processor supports Data Hazards resolution using Forwarding/Bypassing and Stalling technique. 
The schematic design and simulation has been carried out by using the Siemens Questasim 10.7c Simulator.