`timescale 1ns / 1ps
module key_rc_tb;

    // Inputs
    reg [79:0] key_in;
    reg clk;
    reg rst;

    // Outputs
    wire [4:0] current_round_constant;
    wire [79:0] key_out;

    // Instantiate the Unit Under Test (UUT)
    key_rc uut (
        .key_in(key_in),
        .current_round_constant(current_round_constant),
        .key_out(key_out),
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 1;
        rst = 1;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Stimulus
    initial begin
        $display("Time | Round Constant | Key Out");
        $monitor("%4t | %02h | %h", $time, current_round_constant, key_out);

        // Initialize inputs
        key_in = 80'h000000000000000f000f; // Some example 80-bit key
        

        #0;
        rst = 0;  // Deassert reset after 1 cycle

        // Wait enough cycles for 25 rounds
        #300;

        $finish;
    end

endmodule
