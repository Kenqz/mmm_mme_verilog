vlib work
vmap work work
vlog -work work ../vlog/*.v
vsim -voptargs="+acc" -t ns work.mme_tb
do mme_wave.do
run -all
