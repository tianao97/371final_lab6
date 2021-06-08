# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./win_logic.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute. 
#vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench
vsim -voptargs="+acc" -t 1ps -lib work win_logic_testbench

#Load memory
#mem load -infile my_array.txt -format bin


# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do wave.do


# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End