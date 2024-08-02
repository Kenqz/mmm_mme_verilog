onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix unsigned /mmm_tb/test_no
add wave -noupdate -format Logic -radix binary /mmm_tb/clk
add wave -noupdate -format Logic -radix binary /mmm_tb/rn
add wave -noupdate -format Logic -radix binary /mmm_tb/start
add wave -noupdate -format Literal -radix hexadecimal /mmm_tb/a
add wave -noupdate -format Literal -radix hexadecimal /mmm_tb/b
add wave -noupdate -format Literal -radix hexadecimal /mmm_tb/n
add wave -noupdate -format Logic -radix binary /mmm_tb/ready
add wave -noupdate -format Literal -radix hexadecimal /mmm_tb/y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 75
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {10 ns}
