// Cameron McCarty, Tianao Shi
// 6/6/21
// EE371-LAB6 Display organizer

//This module will output the rgb values for each pixel
module Display(
    input logic clk,
    input logic [9:0] x,
	 input logic [8:0] y,
    //x and y: coordinates for the current pixel
    input logic [8:0] purp, gold,
    //purp: current state of the purple squares
    //gold: current state of the gold squares
    output logic [7:0] r, g, b
    //r g b: RGB values for the current pixel
);
    // https://www.rapidtables.com/web/color/RGB_Color.html
    //9x9 squares 
    always_ff @(posedge clk) begin
        // Square 1
        if ((x > 0 & x < 213 & y > 0 & y < 160) & gold[0])
            {r, g, b} <= 24'hFFFF00; // gold
        else if((x > 0 & x < 213 & y > 0 & y < 160) & purp[0])
            {r, g, b} <= 24'hFF00FF;// purple
        else if((x > 0 & x < 213 & y > 0 & y < 160) & !gold[0] & !purp[0])
            {r, g, b} <= 24'hFFFFFFF;// default white
        // Square 2
        else if((x > 215 & x < 426 & y > 0 & y < 160) & gold[1])
            {r, g, b} <= 24'hFFFF00; // gold
        else if((x > 215 & x < 426 & y > 0 & y < 160) & purp[1])
            {r, g, b} <= 24'hFF00FF;// purple
        else if((x > 215 & x < 426 & y > 0 & y < 160) & !gold[1] & !purp[1])
            {r, g, b} <= 24'hFFFFFF;// default white
        // Square 3
        else if((x > 428 & x < 640 & y > 0 & y < 160) & gold[2])
            {r, g, b} <= 24'hFFFF00; // gold
        else if((x > 428 & x < 640 & y > 0 & y < 160) & purp[2])
            {r, g, b} <= 24'hFF00FF;// purple
        else if((x > 428 & x < 640 & y > 0 & y < 160) & !gold[2] & !purp[2])
            {r, g, b} <= 24'hFFFFFF;// default white
        // Square 4
        else if((x > 0 & x < 213 & y > 162 & y < 320) & gold[3])
            {r, g, b} <= 24'hFFFF00; // gold
        else if((x > 0  & x < 213 & y > 162 & y < 320) & purp[3])
            {r, g, b} <= 24'hFF00FF;// purple
        else if((x > 0 & x < 213 & y > 162 & y < 320) & !gold[3] & !purp[3])
            {r, g, b} <= 24'hFFFFFF;// default white
        // Square 5
        else if((x > 215 & x < 426 & y > 162 & y < 320) & gold[4])
            {r, g, b} <= 24'hFFFF00; // gold
        else if((x > 215 & x < 426 & y > 162 & y < 320) & purp[4])
            {r, g, b} <= 24'hFF00FF;// purple
        else if((x > 215 & x < 426 & y > 162 & y < 320) & !gold[4] & !purp[4])
            {r, g, b} <= 24'hFFFFFF;// default white
        // Square 6
        else if((x > 428 & x < 640 & y > 162 & y < 320) & gold[5])
            {r, g, b} <= 24'hFFFF00; // gold
        else if((x > 428 & x < 640 & y > 162 & y < 320) & purp[5])
            {r, g, b} <= 24'hFF00FF;// purple
        else if((x > 428 & x < 640 & y > 162 & y < 320) & !gold[5] & !purp[5])
            {r, g, b} <= 24'hFFFFFF;// default white
        // Square 7
        else if((x > 0 & x < 213 & y > 322 & y < 480) & gold[6])
            {r, g, b} <= 24'hFFFF00; // gold
        else if((x > 0 & x < 213 & y > 322 & y < 480) & purp[6])
            {r, g, b} <= 24'hFF00FF;// purple
        else if((x > 0 & x < 213 & y > 322 & y < 480) & !gold[6] & !purp[6])
            {r, g, b} <= 24'hFFFFFF;// default white
        // Square 8
        else if((x > 215 & x < 426 & y > 322 & y < 480) & gold[7])
            {r, g, b} <= 24'hFFFF00; // gold
        else if((x > 215 & x < 426 & y > 322 & y < 480) & purp[7])
            {r, g, b} <= 24'hFF00FF;// purple
        else if((x > 215 & x < 426 & y > 322 & y < 480) & !gold[7] & !purp[7])
            {r, g, b} <= 24'hFFFFFF;// default white
        // Square 9 /////
        else if((x > 428 & x < 640 & y > 322 & y < 480) & gold[8])
            {r, g, b} <= 24'hFFFF00; // gold
        else if((x > 428 & x < 640 & y > 322 & y < 480) & purp[8])
            {r, g, b} <= 24'hFF00FF;// purple
        else if((x > 428 & x < 640 & y > 322 & y < 480) & !gold[8] & !purp[8])
            {r, g, b} <= 24'hFFFFFF;// default white
        else
            {r, g, b} <= 24'h000000;// default black background (color of the lines in between cells)
    end
endmodule

//This testbench tests the case when the square 1, 2, 3 to be purple and gold 
module Display_testbench();
        logic clk;
        logic [9:0] x;
        logic [8:0] y;
        logic [8:0] purp, gold;
        logic [7:0] r, g, b;
		
		Display dut (.clk, .x, .y, .purp, .gold, .r, .g, .b);
		
		parameter clock_period = 100;
		
		initial begin
			clk <= 0;
			forever #(clock_period /2) clk <= ~clk;
			
		end 
		
		initial begin
		x <= 200; y <= 150;   purp <= 9'b000000001;                             										@(posedge clk);
      x <= 200; y <= 150;   gold <= 9'b000000001;                                                           @(posedge clk);
		x <= 250; y <= 150;   purp <= 9'b000000010;                             										@(posedge clk);
      x <= 250; y <= 150;   gold <= 9'b000000010;                                                           @(posedge clk);
		x <= 500; y <= 150;   purp <= 9'b000000100;                             										@(posedge clk);
      x <= 500; y <= 150;   gold <= 9'b000000100;                                                           @(posedge clk);
																																				@(posedge clk);
																																				@(posedge clk);
			$stop;						
		end
endmodule