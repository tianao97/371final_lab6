// Cameron McCarty, Tianao Shi
// 6/6/21
// EE371-LAB6 Winner logic moudle

//This module will output the winner of the game.
module win_logic (purp_state, gold_state, game_finished, purple_win, gold_win);
    input logic [8:0] purp_state, gold_state;  //current pattern of purple and gold squares on the game board

    output logic game_finished;  //signal if the game is already finished
    output logic purple_win, gold_win; //signal for who is the winner

    always_comb begin
        if ((purp_state & 9'b111000000) == 9'b111000000 | (purp_state & 9'b000111000) == 9'b000111000 | (purp_state & 9'b000000111) == 9'b000000111 | // Purple has won
            (purp_state & 9'b100100100) == 9'b100100100 | (purp_state & 9'b010010010) == 9'b010010010 | (purp_state & 9'b001001001) == 9'b001001001 |
            (purp_state & 9'b100010001) == 9'b100010001 | (purp_state & 9'b001010100) == 9'b001010100 ) begin
                purple_win = 1;
                gold_win = 0;
                game_finished = 1;
        end else if((gold_state & 9'b111000000) == 9'b111000000 | (gold_state & 9'b000111000) == 9'b000111000 | (gold_state & 9'b000000111) == 9'b000000111 | // Purple has won
            (gold_state & 9'b100100100) == 9'b100100100 | (gold_state & 9'b010010010) == 9'b010010010 | (gold_state & 9'b001001001) == 9'b001001001 |
            (gold_state & 9'b100010001) == 9'b100010001 | (gold_state & 9'b001010100) == 9'b001010100) begin
                purple_win = 0;
                gold_win = 1;
                game_finished = 1;
        end else if ((purp_state | gold_state) == 9'b111111111) begin // Game is a tie
                purple_win = 0;
                gold_win = 0;
                game_finished = 1;
        end else begin // nobody has won yet
                purple_win = 0;
                gold_win = 0;
                game_finished = 0;
        end
    end
endmodule


module win_logic_testbench();
		logic [8:0] purp_state, gold_state;
        logic game_finished;
        logic purple_win, gold_win;
		
        win_logic dut (.purp_state, .gold_state, .game_finished, .purple_win, .gold_win);	

		integer i;
        initial begin
                for(i=0; i<512; i++) begin
                    {purp_state} = i; #10;
                    {gold_state} = i; #10;
                end
        end
endmodule