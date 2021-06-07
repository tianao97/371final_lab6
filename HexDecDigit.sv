// Cameron McCarty
// 6/6/21
// EE371-LAB6-Hex display for one digit in hexidecimal

//This module will create the hex code for the ones place of a four bit hexidecimal number.
module HexDecDigit (digit, hex);
	input logic [3:0] digit;
	// digit: value to be displayed. Can be up to four bit
	output logic [6:0] hex;
	// hex: patern for that digit on a hex display

 
 	// Assigning hex codes based off of ones place digit
	always_comb begin
		case (digit)
			0: hex = 7'b1000000; // 0
			1: hex = 7'b1111001; // 1
			2: hex = 7'b0100100; // 2
			3: hex = 7'b0110000; // 3
			4: hex = 7'b0011001; // 4
			5: hex = 7'b0010010; // 5
			6: hex = 7'b0000010; // 6
			7: hex = 7'b1111000; // 7
			8: hex = 7'b0000000; // 8
			9: hex = 7'b0010000; // 9
			10: hex = 7'b0001000; // A
			11: hex = 7'b0000011; // B
			12: hex = 7'b1000110; // C
			13: hex = 7'b0100001; // D
			14: hex = 7'b0000110; // E
			15: hex = 7'b0001110; // F
			default: hex = 7'bX;
		endcase
	end
endmodule 

module HexDecDigit_testbench();
	logic [3:0] digit;
	logic [6:0] hex;

	HexDecDigit dut (digit, hex);

	//Testing 0-15 as inputs
	integer i;
	initial begin
			for(i=0; i<16; i++) begin
				{digit} = i; #10;
			end
	end
	endmodule 
