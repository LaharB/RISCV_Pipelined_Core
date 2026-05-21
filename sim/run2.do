vlib work
vlog ../tb/tb_Pipelined_top.v
vsim -debugDB -voptargs="+acc" work.tb
# add wave -r *
do wave_HazardUnit_temp.do
run -all
view schematic
add schematic /tb/DUT