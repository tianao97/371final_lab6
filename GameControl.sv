// Cameron McCarty, Tianao Shi
// 6/6/21
// EE371-LAB6 Control path

//This module will output the values of each of the squares from past game inputs. 
module GameControl(
	input logic clk, reset,
	input logic game_finished,
    //game_finished: win has been achieve, when high will lock the game 
    input logic [8:0] square,
    //Square: Input pattern for the game. Defines the key pressed for the current player.
	output logic [8:0] purp_state, gold_state
    //purp_state: current pattern of purple squares on the game board
    //gold_state: current pattern of gold squares on the game board
	);
    
    enum {purp_move, gold_move, win} moveq, moved;
    //Move dff: q indicates wich player the current move belongs to, d denotes the next player, win is
    // used to hold the game after victory
    logic [8:0] purpq, purpd, goldq, goldd;
    //purp dff: q denotes the current pattern of purple squares, d denotes next clk cycle pattern
    //gold dff: q denotes the current pattern of gold squares, d denotes next clk cycle pattern


	//Output logic
    assign purp_state = purpq;
    assign gold_state = goldq;

	// Next State logic
	always_comb begin
		case (moveq)
			purp_move:
                if(game_finished) begin // Hold on win
                    moved = win;
                    purpd = purpq;
                    goldd = goldq;
                end else if(square == '0) begin // No input (wait)
					moved = moveq;
                    purpd = purpq;
                    goldd = goldq;
				end else begin // Any input for purple
					moved = gold_move;
                    purpd = purpq | square; // Add input into game state
                    goldd = goldq;
				end
			gold_move:
				if(game_finished) begin // Hold on win
                    moved = win;
                    purpd = purpq;
                    goldd = goldq;
                end else if(square == '0) begin // No input (wait)
					moved = moveq;
                    purpd = purpq;
                    goldd = goldq;
				end else begin // Any input for gold
					moved = purp_move;
                    purpd = purpq;
                    goldd = goldq | square;// Add input into game state
				end
			win:
                begin// Always lock on win (until reset)
					moved = moveq;
                    purpd = purpq;
                    goldd = goldq;
                end
			default://Default should only happen under error, will keep state (game will freeze) reset to fix
				begin
					moved = moveq;
                    purpd = purpq;
                    goldd = goldq;
				end
			endcase
	end

	// Dffs
	always_ff @(posedge clk) begin
		if (reset) begin
			moveq <= purp_move;
            purpq <= '0;
            goldq <= '0;
		end else begin
			moveq <= moved;
            purpq <= purpd;
            goldq <= goldd;
		end
	end
endmodule






module  GameControl_testbench();
	logic clk, reset;
	logic game_finished;
    logic [8:0] square;
    logic [8:0] purp_state, gold_state;
	logic test; //A dummy variable used to see when each test case is done in modelsim.

	GameControl dut (clk, reset, game_finished, square, purp_state, gold_state);

	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
	end


	initial begin	
		/*#######################################################*
		
									/* TEST 1 - s0 loop, to s1, less than loop, then greater than loop, then to s2, then done loop, then to s0 * 
		reset <= 0; on <= 0; finished <= 0; less <= 0; great <= 0; test <= 0;//initialize
		reset <= 1; repeat(2) @(posedge clk); // Always reset FSMs at start
		reset <= 0; repeat(1) @(posedge clk);
		
		repeat(3) @(posedge clk); // pre start loop
		
		on <= 1; less <= 1; repeat(3) @(posedge clk); //move to S1 and less loop
		great <= 1; less <= 0; repeat(3) @(posedge clk); // try greater loop
		finished <= 1; repeat(3) @(posedge clk); // move to S2 and the done loop
		on <= 0; repeat(3) @(posedge clk); //move to S0 again

		//repeat(7) @(posedge clk); // End test with some space
		$stop; // End the simulation.*/
	end 
endmodule
