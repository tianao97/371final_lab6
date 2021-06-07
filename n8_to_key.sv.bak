// Cameron McCarty, Tianao Shi
// 6/6/21
// EE371-LAB6 controler decoder

//This module will take in the N8 controller input and allow the user to select a square
module n8_to_key (
    input clk, reset,
    input up, down, select,
    //up: moves the current square selected up by one index
    //down: moves the current square selected down by one index
    //select: singal for a square to be selected
    output logic [3:0] count,
    //count: the current square that the players cursor is on
    output logic [8:0] square
    //square: finalized move made by player
    );
    logic lock;

    //Move finalization
    always @(posedge clk) begin
        if(select & ~lock) begin
            if(count == 1)      square <= 9'b000000001;
            else if(count == 2) square <= 9'b000000010;
            else if(count == 3) square <= 9'b000000100;
            else if(count == 4) square <= 9'b000001000;
            else if(count == 5) square <= 9'b000010000;
            else if(count == 6) square <= 9'b000100000;
            else if(count == 7) square <= 9'b001000000;
            else if(count == 8) square <= 9'b010000000;
            else if(count == 9) square <= 9'b100000000;
        end else begin
            square <= 9'b0;
        end
    end

    // Counter
    always @(posedge clk) begin
        if(reset | select) begin 
            count <= 1;
        end else if (~lock & up & (count < 9)) begin // UP
            count <= count + 1;
        end else if (~lock & down & (count > 1)) begin// DOWN
            count <= count - 1;
        end else begin //no change
            count <= count;
        end 
    end

    always @(posedge clk) begin
        if(up | down | select) lock <= 1;
        else lock <= 0;    
    end
endmodule

module  n8_to_key_testbench();
        logic clk, reset;
        logic up, down, select;
		logic [3:0] count;
        logic [8:0] square;

		n8_to_key dut (.clk, .reset, .up, .down, .select, .count, .square);
		
		parameter clock_period = 100;
		
		initial begin
			clk <= 0;
			forever #(clock_period /2) clk <= ~clk;
			
		end 
		
		initial begin
        reset <= 0;                                                        @(posedge clk);
        reset <= 1;                                                        @(posedge clk);
        up <= 1;                                                        @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);																
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);
                                                                @(posedge clk);															
                                                                @(posedge clk);
                                                                @(posedge clk);
			$stop;						
		end
endmodule