vlib work
vmap work work
vlog -work work ../vlog/*.v
vsim -voptargs="+acc" -t ns work.mmm_tb
do mmm_wave.do
run -all
