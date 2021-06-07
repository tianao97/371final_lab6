// Cameron McCarty
// 6/6/21
// EE371-LAB4 Multi Purpose register

// The register module is capable of loading, shifting right, incramenting, decramenting, and looping. All with custom minimums and maximums to the value
// Carefull this register can load in, or shift to, values outside of its max or min, max and min are just limits to the counters. Added in lab 6 is, that the
// increment will lock, meaning that each pulse will only increment by one no matter the width.
module GeneralRegister #(parameter depth = 5) (clk, load, shr, shl, inc, dec, logshift, loop, min, max, in, out);
	input logic clk, load, shr, shl, inc, dec, logshift, loop;
	input logic [depth - 1:0] min, max, in;
	// load: load the current input into the register, make sure to load at beggining to initialize register						(priority over shr, shl, inc, and dec)
	// shr: shift the current value to the right, ie index 2 will go to index 1 															(priority over shl, inc, and dec)
	// shl: shift the current value to the left, ie index 1 will go to index 2																(priority over inc and dec)
	// inc: increment the value, one count is made per each clock cycle this is high. 													(priority over dec)
	// dec: decrement the value, one count is made per each clock cycle this is high. 													(lowest priority)
	// logshift: when true will use a logical shift, adding in 0s, when false will use an arithmetic shift keeping the sign
	// loop: when in loop mode, the counter will loop from max around to min on inc, or from min to max on dec
	// min: minimun number the counter can reach
	// max: maximum number the counter can reach
	// in: input value, the value to be saved when loaded in
	output logic [depth - 1:0] out;
	// out: The current value stored
	
	// State variables
	logic [depth - 1:0] valued, valueq;
    logic lock;
	//	valueq: current value stored
	// valued: value to be stored on next clock cycle
	
	// Output logic
	assign out = valueq;

	// Next State logic
	always_comb begin
		if(loop & ~(shr | shl) & (inc | dec)) begin//loop mode with no shift
			if(inc & (valueq == max)) // inc at max
				valued = min;
			else if(inc & ~lock) // normal inc
				valued = valueq + 1;
			else if (dec & (valueq == min)) // dec at min
				valued = max;
			else if (dec) // normal dec
				valued = valueq - 1;
			else //default case
				valued = valueq;
		end else if(~(shr | shl) & (inc | dec)) begin//end at max mode with no shift
			if(inc & (valueq == max)) // inc at max
				valued = max;
			else if(inc & ~lock) // normal inc
				valued = valueq + 1;
			else if (dec & (valueq == min)) // dec at min
				valued = valueq;
			else if (dec) // normal dec
				valued = valueq - 1;
			else //default case
				valued = valueq;
		end else if(shr) begin // shift right
			if(logshift)
				valued = valueq >> 1;
			else 
				valued = valueq >>> 1;
		end else if(shl) begin // shift left
			if(logshift)
				valued = valueq << 1;
			else 
				valued = valueq <<< 1;
		end else begin // hold value
			valued = valueq;
		end
	end
	
	//DFF
	always_ff @(posedge clk) begin
		if (load)
			valueq = in;
		else
			valueq <= valued;
	end

    //Lock
    always @(posedge clk) begin
        if(inc) lock <= 1;
        else lock <= 0;    
    end
endmodule 


module GeneralRegister_testbench();
	logic clk, reset, load, shr, shl, inc, dec, logshift, loop;
	logic [5 - 1:0] min, max, in;
	logic [5 - 1:0] out;
	logic [5 - 1:0] test; //A dummy variable used to see when each test case is done in modelsim
	logic [6:0] ctrl; //A variable used to control the many controlinput signals easily
	
	assign loop     = ctrl[0];
	assign logshift = ctrl[1];
	assign dec      = ctrl[2];
	assign inc      = ctrl[3];
	assign shl      = ctrl[4];
	assign shr      = ctrl[5];
	assign load     = ctrl[6] | reset;
	

	GeneralRegister dut (clk, load, shr, shl, inc, dec, logshift, loop, min, max, in, out);

	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
	end


	initial begin
		// all operations tested at depth of 5
		//not tested is the arithmetic shift
		
		/*#######################################################*/
		
									/* TEST 1 - inc to max then dec to min*/
		reset <= 0; min <= 2; max <= 5; in <= 3; ctrl <= 7'b0000000; test <= 3;//initialize
		reset <= 1; repeat(1) @(posedge clk); // Always reset FSMs at start
		reset <= 0; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0001000; repeat(1) @(posedge clk); // count 1
		ctrl <= 7'b0000000; test <= 4; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0001000; repeat(1) @(posedge clk); // count 1
		ctrl <= 7'b0000000; test <= 5; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0001000; repeat(1) @(posedge clk); // hit max
		ctrl <= 7'b0000000; test <= 5; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0000100; repeat(1) @(posedge clk); // dec 1
		test <= 4; repeat(1) @(posedge clk); // dec 1
		test <= 3; repeat(1) @(posedge clk); // dec 1
		test <= 2; repeat(1) @(posedge clk); // dec 1
		test <= 2; repeat(1) @(posedge clk); // hit min
		
		/*#######################################################*/
		
									/* TEST 2 - inc past max, then dec past min in loop mode*/
		reset <= 0; min <= 2; max <= 5; in <= 3; ctrl <= 7'b0000001; test <= 3;//initialize
		reset <= 1; repeat(1) @(posedge clk); // Always reset FSMs at start
		reset <= 0; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0001001; repeat(1) @(posedge clk); // count 1
		ctrl <= 7'b0000001; test <= 4; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0001001; repeat(1) @(posedge clk); // count 1
		ctrl <= 7'b0000001; test <= 5; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0001001; repeat(1) @(posedge clk); // pass max
		ctrl <= 7'b0000001; test <= 2; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0001001; repeat(1) @(posedge clk); // count 1
		ctrl <= 7'b0000001; test <= 3; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0000101; repeat(1) @(posedge clk); // dec 1
		test <= 2; repeat(1) @(posedge clk); // pass min
		test <= 5; repeat(1) @(posedge clk); // dec 1
		test <= 4; repeat(1) @(posedge clk); // dec 1
		
		/*#######################################################*/
		
								/* TEST 2 - logical shift right*/
		reset <= 0; min <= 0; max <= 0; in <= 5'b10101; ctrl <= 7'b0000000; test <= 5'b10101;//initialize
		reset <= 1; repeat(1) @(posedge clk); // Always reset FSMs at start
		reset <= 0; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0100000; repeat(1) @(posedge clk); // shr
		ctrl <= 7'b0000000; test <= 5'b01010; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0100000; repeat(1) @(posedge clk); // shr
		ctrl <= 7'b0000000; test <= 5'b00101; repeat(1) @(posedge clk);

		
		/*#######################################################*/
		
								/* TEST 2 - logical shift left*/
		reset <= 0; min <= 0; max <= 0; in <= 5'b10101; ctrl <= 7'b0000000; test <= 5'b10101;//initialize
		reset <= 1; repeat(1) @(posedge clk); // Always reset FSMs at start
		reset <= 0; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0010000; repeat(1) @(posedge clk); // shl
		ctrl <= 7'b0000000; test <= 5'b01010; repeat(1) @(posedge clk);
		
		ctrl <= 7'b0010000; repeat(1) @(posedge clk); // shl
		ctrl <= 7'b0000000; test <= 5'b10100; repeat(1) @(posedge clk);

		
		/*#######################################################*/
		
		

			
		//repeat(7) @(posedge clk); // End test with some space
		$stop; // End the simulation.
	end 
endmodule
