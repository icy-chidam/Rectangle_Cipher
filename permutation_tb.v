`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2025 16:51:05
// Design Name: 
// Module Name: permutation_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module permutation_tb;

    // Testbench Signals
    reg  [63:0] in;        // Input to the DUT
    wire [63:0] out;       // Output from the DUT
    wire [63:0] shift_rows;// Intermediate Output

    // Instantiate the DUT (Device Under Test)
    permutation uut (
        .in(in),
        .out(out),
        .shift_rows(shift_rows)
    );

    // Test Sequence
    initial begin
        // Apply input patterns and observe output

        // Test Case 1: Random input
        in = 64'h1234_5678_9ABC_DEF0;
        #10;
        $display("Input: %h, Shifted Rows: %h, Output: %h", in, shift_rows, out);
        
        // Test Case 2: All 1s
        in = 64'hFFFF_FFFF_FFFF_FFFF;
        #10;
        $display("Input: %h, Shifted Rows: %h, Output: %h", in, shift_rows, out);

        // Test Case 3: All 0s
        in = 64'h0000_0000_0000_0000;
        #10;
        $display("Input: %h, Shifted Rows: %h, Output: %h", in, shift_rows, out);

        // Test Case 4: Alternating pattern
        in = 64'hA5A5_A5A5_5A5A_5A5A;
        #10;
        $display("Input: %h, Shifted Rows: %h, Output: %h", in, shift_rows, out);

        // Test Case 5: Incrementing sequence
        in = 64'h0123_4567_89AB_CDEF;
        #10;
        $display("Input: %h, Shifted Rows: %h, Output: %h", in, shift_rows, out);

        // Finish simulation
        $stop;
    end
endmodule

