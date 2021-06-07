module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS, N8_DATA_IN, N8_LATCH, N8_PULSE,);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
    input N8_DATA_IN,

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
    output N8_LATCH,
    output N8_PULSE,

	logic reset;
	logic [9:0] x;
	logic [8:0] y;
	logic [7:0] r, g, b;
	
    //Inputs
n8_driver driver( .clk(CLOCK_50), .data_in(N8_DATA_IN), .latch(N8_LATCH), .pulse(N8_PULSE), .up(up),
                  .down(down), .left(left), .right(right), .select(LEDR[9]), .start(LEDR[8]), .a(a), .b(b));

    assign reset = 0;
	
    n8_to_key n8_decoder (clk, reset, up, down, select, count, square);

    //Control Path
    GameControl controller (clk, reset, win, square, purp_state, gold_state);
	
    //Data Path
	Display disp (.clk(clk), .enable(enable), .data_in(data_in), .data_out(data_out));


	
	

    //Outputs
	video_driver #(.WIDTH(640), .HEIGHT(480))
		v1 (.CLOCK_50, .reset, .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);

    assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;

    /*always_ff @(posedge CLOCK_50) begin
		r <= SW[7:0];
		g <= x[7:0];
		b <= y[7:0];
	end */

	
endmodule
