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
            {r, g, b} <= 24'hB8860B; // gold
        else if((x > 0 & x < 213 & y > 0 & y < 160) & purp[0])
            {r, g, b} <= 24'h800080;// purple
        else if((x > 0 & x < 213 & y > 0 & y < 160) & !gold[1] & !purp[1])
            {r, g, b} <= 24'h000000;// default black
        // Square 2
        else if((x > 213 & x < 426 & y > 0 & y < 160) & gold[1])
            {r, g, b} <= 24'hF9C700; // gold
        else if((x >= 213 & x < 426 & y > 0 & y < 160) & purp[1])
            {r, g, b} <= 24'h6600CC;// purple
        else if((x >= 213 & x < 426 & y > 0 & y < 160) & !gold[1] & !purp[1])
            {r, g, b} <= 24'hFFFFFF;// default black
        // Square 3
        else if((x > 426 & x < 640 & y > 0 & y < 160) & gold[2])
            {r, g, b} <= 24'hF9C700; // gold
        else if((x > 426 & x < 640 & y > 0 & y < 160) & purp[2])
            {r, g, b} <= 24'h6600CC;// purple
        else if((x >= 213 & x < 426 & y > 0 & y < 160) & !gold[2] & !purp[2])
            {r, g, b} <= 24'hFFFFFF;// default black
        // Square 4
        else if((x > 0  & x < 213 & y > 160 & y < 320) & gold[3])
            {r, g, b} <= 24'hF9C700; // gold
        else if((x > 0  & x < 213 & y > 160 & y < 320) & purp[3])
            {r, g, b} <= 24'h6600CC;// purple
        else if((x >= 213 & x < 426 & y > 0 & y < 160) & !gold[3] & !purp[3])
            {r, g, b} <= 24'hFFFFFF;// default black
        // Square 5
        else if((x > 213 & x < 426 & y > 160 & y < 320) & gold[4])
            {r, g, b} <= 24'hF9C700; // gold
        else if((x > 213 & x < 426 & y > 160 & y < 320) & purp[4])
            {r, g, b} <= 24'h6600CC;// purple
        else if((x >= 213 & x < 426 & y > 0 & y < 160) & !gold[4] & !purp[4])
            {r, g, b} <= 24'hFFFFFF;// default black
        // Square 6
        else if((x > 426 & x < 640 & y > 160 & y < 320) & gold[5])
            {r, g, b} <= 24'hF9C700; // gold
        else if((x > 426 & x < 640 & y > 160 & y < 320) & purp[5])
            {r, g, b} <= 24'h6600CC;// purple
        else if((x >= 213 & x < 426 & y > 0 & y < 160) & !gold[5] & !purp[5])
            {r, g, b} <= 24'hFFFFFF;// default black
        // Square 7
        else if((x > 0 & x < 213 & y > 320 & y < 480) & gold[6])
            {r, g, b} <= 24'hF9C700; // gold
        else if((x > 0 & x < 213 & y > 320 & y < 480) & purp[6])
            {r, g, b} <= 24'h6600CC;// purple
        else if((x >= 213 & x < 426 & y > 0 & y < 160) & !gold[6] & !purp[6])
            {r, g, b} <= 24'hFFFFFF;// default black
        // Square 8
        else if((x > 213 & x < 426 & y > 320 & y < 480) & gold[7])
            {r, g, b} <= 24'hF9C700; // gold
        else if((x > 213 & x < 426 & y > 320 & y < 480) & purp[7])
            {r, g, b} <= 24'h6600CC;// purple
        else if((x >= 213 & x < 426 & y > 0 & y < 160) & !gold[7] & !purp[7])
            {r, g, b} <= 24'hFFFFFF;// default black
        // Square 9
        else if((x > 426 & x < 640 & y > 320 & y < 480) & gold[8])
            {r, g, b} <= 24'hF9C700; // gold
        else if((x > 426 & x < 640 & y > 320 & y < 480) & purp[8])
            {r, g, b} <= 24'h6600CC;// purple
        else if((x > 426 & x < 640 & y > 320 & y < 480) & !gold[8] & !purp[8])
            {r, g, b} <= 24'hFFFFFF;// default black    
        else
            {r, g, b} <= 24'hFFFFFF;// default black 
    end
endmodule

module  Display_testbench();
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
                                                                @(posedge clk);															
                                                                @(posedge clk);
                                                                @(posedge clk);
			$stop;						
		end
endmodule