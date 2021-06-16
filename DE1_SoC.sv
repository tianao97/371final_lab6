// Cameron McCarty, Tianao Shi
// 6/6/21
// EE371-LAB6 top level module

//This module implements a Tic-Tac-Toe game on the DE1_SoC
//It connects all the submodules together 
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
   logic game_finished, purple_win, gold_win; 
   logic [3:0] count, purp_wins, gold_wins;
   logic [8:0] square, purp_state, gold_state;
	logic [9:0] x;
	logic [8:0] y;
	logic [7:0] r, g, b;
   logic [1:0] player;
	
    //Inputs

    assign reset = SW[0];

    n8_driver driver( .clk(CLOCK_50), .data_in(N8_DATA_IN), .latch(N8_LATCH), .pulse(N8_PULSE), .up(up1),
                      .down(down1), .select(select1), .start(start1));
    //Assign intermediate logic (as suggested by padlet)
    assign up = up1;
    assign down = down1;
    assign select = select1;
    assign game_reset = start1;

    n8_to_key n8_decoder (.clk(CLOCK_50), .reset(reset), .up(up), .down(down), .select(select), .count(count), .square(square));

    //Control Path
	// GameControl module will output the values of each of the squares from past game inputs. 
    GameControl controller (.clk(CLOCK_50), .reset(reset | game_reset), .game_finished(game_finished), .square(square), .purp_state(purp_state), .gold_state(gold_state), .player(player));
    win_logic win (.purp_state(purp_state), .gold_state(gold_state), .game_finished(game_finished), .purple_win(purple_win), .gold_win(gold_win));

    //Data Path

    // Add point when a new game has started from a purp win
	GeneralRegister purp_wins_count (.clk(CLOCK_50), .load('0), .shr('0), .shl(0), .inc(game_reset & purp_win), .dec('0), .logshift('0), .loop('0), .min('0), .max('hf), .in('0), .out(purp_wins));
    // Add point when a new game has started from a gold win
	GeneralRegister gold_wins_count (.clk(CLOCK_50), .load('0), .shr('0), .shl(0), .inc(game_reset & gold_win), .dec('0), .logshift('0), .loop('0), .min('0), .max('hf), .in('0), .out(gold_wins));
	
   // Display module will output the rgb values for each pixel
   Display disp (.clk(CLOCK_50), .x(x), .y(y), .purp(purp_state), .gold(gold_state), .r(r), .g(g), .b(b));
	
	video_driver #(.WIDTH(640), .HEIGHT(480))
		v1 (.CLOCK_50, .reset, .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);

	//hex5 display the value of count 
    HexDecDigit selecter (.digit(count), .hex(HEX5)); // HEX5
	 //hex0 display when purp_wins is high
    HexDecDigit purp_disp (.digit(purp_wins), .hex(HEX0)); // HEX0 PURPLE
	 //hex1 display when purp_wins is high
    HexDecDigit gold_disp (.digit(gold_wins), .hex(HEX1)); // HEX1 GOLD

	
    assign LEDR[0] = game_finished;
    assign LEDR[1] = purple_win;
    assign LEDR[2] = gold_win;
    assign LEDR[9:8] = player;


    //assign HEX0 = '1;
	//assign HEX1 = '1;
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


