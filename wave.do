onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /win_logic_testbench/purp_state
add wave -noupdate /win_logic_testbench/gold_state
add wave -noupdate /win_logic_testbench/game_finished
add wave -noupdate /win_logic_testbench/purple_win
add wave -noupdate /win_logic_testbench/gold_win
add wave -noupdate /win_logic_testbench/i
add wave -noupdate /win_logic_testbench/k
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
WaveRestoreZoom {4211 ps} {5168 ps}
