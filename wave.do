onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /GameControl_testbench/clk
add wave -noupdate /GameControl_testbench/reset
add wave -noupdate /GameControl_testbench/game_finished
add wave -noupdate /GameControl_testbench/square
add wave -noupdate /GameControl_testbench/purp_state
add wave -noupdate /GameControl_testbench/gold_state
add wave -noupdate /GameControl_testbench/dut/moveq
add wave -noupdate /GameControl_testbench/dut/moved
add wave -noupdate /GameControl_testbench/test
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1068 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 248
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {241 ps} {1198 ps}
