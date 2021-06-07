module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS, N8_DATA_IN, N8_LATCH, N8_PULSE,);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
    input logic N8_DATA_IN;

	input logic CLOCK_50;
	output logic [7:0] VGA_R;
	output logic [7:0] VGA_G;
	output logic [7:0] VGA_B;
	output logic VGA_BLANK_N;
	output logic VGA_CLK;
	output logic VGA_HS;
	output logic VGA_SYNC_N;
	output logic VGA_VS;
    output logic N8_LATCH;
    output logic N8_PULSE;

	logic reset, game_reset;
    logic up, down, select, up1, down1, select1, start1;
    logic game_finished, purple_win; 
    logic [3:0] count;
    logic [8:0] square, purp_state, gold_state;
	logic [9:0] x;
	logic [8:0] y;
	logic [7:0] r, g, b;
	
    //Inputs
    assign reset = SW[0];

    n8_driver driver( .clk(CLOCK_50), .data_in(N8_DATA_IN), .latch(N8_LATCH), .pulse(N8_PULSE), .up(up1),
                      .down(down1), .select(select1), .start(start1));
    //Assign intermediate logic (as suggested by padlet)
    assign up = up1;
    assign down = down1;
    assign slect = select1;
    assign game_reset = start1;

    n8_to_key n8_decoder (.clk(CLOCK_50), .reset(reset), .up(up), .down(down), .select(select), .count(count), .square(square));

    //Control Path
    GameControl controller (.clk(CLOCK_50), .reset(reset | game_reset), .game_finished(game_finished), .square(square), .purp_state(purp_state), .gold_state(gold_state));
    win_logic win (.purp_state(purp_state), .gold_state(gold_state), .game_finished(game_finished), .purple_win(purple_win), .gold_win(gold_win));
	
    //Data Path
    Display disp (.clk(CLOCK_50), .x(x), .y(y), .purp(purp_state), .gold(gold_state), .r(r), .g(g), .b(b));
	
    //Outputs
	video_driver #(.WIDTH(640), .HEIGHT(480))
		v1 (.CLOCK_50, .reset, .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);

    HexDecDigit selecter (.digit(count), .hex(HEX5)); // HEX5
	
    assign LEDR[0] = game_finished;
    assign LEDR[1] = purple_win;
    assign LEDR[2] = gold_win;

    assign LEDR[9] = up;
    assign LEDR[8] = down;
    assign LEDR[7] = select;
    assign LEDR[6] = game_reset;

    assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	//assign HEX5 = '1;

    /*always_ff @(posedge CLOCK_50) begin
		r <= SW[7:0];
		g <= x[7:0];
		b <= y[7:0];
	end */

	
endmodule
