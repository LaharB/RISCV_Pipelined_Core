vlib wok
vlog ../tb/tb_Pipelined_top.v
vsim -debugDB -voptargs="+acc" work.tb
add wave -r *
# do wave.do
view schematic
add schematic /tb/DUT
run -all