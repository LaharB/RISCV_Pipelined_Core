onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Global Signals} /tb/DUT/clk
add wave -noupdate -expand -group {Global Signals} /tb/DUT/rst
add wave -noupdate -expand -group {FETCH Stage} /tb/DUT/Fetch_Stage/PCSrcE
add wave -noupdate -expand -group {FETCH Stage} /tb/DUT/Fetch_Stage/PCTargetE
add wave -noupdate -expand -group {FETCH Stage} /tb/DUT/Fetch_Stage/PCD
add wave -noupdate -expand -group {FETCH Stage} /tb/DUT/Fetch_Stage/PCPlus4D
add wave -noupdate -expand -group {FETCH Stage} /tb/DUT/Fetch_Stage/InstrD
add wave -noupdate -expand -group {FETCH Stage} /tb/DUT/Fetch_Stage/Instruction_Mem/mem
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/PCE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/PCPlus4E
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/RdE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/ALUControlE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/ALUSrcE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/BranchE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/JumpE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/MemWriteE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/RegWriteE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/ResultSrcE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/RD1E
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/RD2E
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/ImmExtE
add wave -noupdate -expand -group {DECODE Stage} /tb/DUT/Decode_Stage/Register_File/Registers
add wave -noupdate -expand -group {EXECUTE Stage} /tb/DUT/Execute_Stage/PCPlus4M
add wave -noupdate -expand -group {EXECUTE Stage} /tb/DUT/Execute_Stage/RdM
add wave -noupdate -expand -group {EXECUTE Stage} /tb/DUT/Execute_Stage/MemWriteM
add wave -noupdate -expand -group {EXECUTE Stage} /tb/DUT/Execute_Stage/RegWriteM
add wave -noupdate -expand -group {EXECUTE Stage} /tb/DUT/Execute_Stage/ResultSrcM
add wave -noupdate -expand -group {EXECUTE Stage} /tb/DUT/Execute_Stage/ALUResultM
add wave -noupdate -expand -group {EXECUTE Stage} /tb/DUT/Execute_Stage/WriteDataM
add wave -noupdate -expand -group {MEMORY Stage} /tb/DUT/Memory_Stage/PCPlus4W
add wave -noupdate -expand -group {MEMORY Stage} /tb/DUT/Memory_Stage/ResultSrcW
add wave -noupdate -expand -group {MEMORY Stage} /tb/DUT/Memory_Stage/ALUResultW
add wave -noupdate -expand -group {MEMORY Stage} /tb/DUT/Memory_Stage/ReadDataW
add wave -noupdate -expand -group {MEMORY Stage} /tb/DUT/Memory_Stage/Data_Memory/mem
add wave -noupdate -expand -group {WRITEBACK Stage} /tb/DUT/RegWriteW_wire
add wave -noupdate -expand -group {WRITEBACK Stage} /tb/DUT/RdW_wire
add wave -noupdate -expand -group {WRITEBACK Stage} /tb/DUT/Writeback_Stage/ResultW
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {347354 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 108
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {659195 ps}
