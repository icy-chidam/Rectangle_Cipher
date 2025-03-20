`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2025 20:46:01
// Design Name: 
// Module Name: add_round_key
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
module add_round_key (
    input wire clk,               // Clock signal
    input wire rst,               // Reset signal (optional)
    input wire [63:0] state,      // Current state input
    input wire [63:0] round_key,  // Round key input
    output reg [63:0] new_state   // Output stored in a register
);

    always @(*) begin
        if (rst) 
            new_state <= 64'b0;  // Reset state to 0
        else 
            new_state <= state ^ round_key;  // XOR operation on clock edge
    end
endmodule

