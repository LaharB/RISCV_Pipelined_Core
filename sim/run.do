vlib work
vlog ../tb/tb_Pipelined_top.v
vsim -debugDB -voptargs="+acc" work.tb
# add wave -r *
do wave.do
run -all
view schematic
add schematic /tb/DUT