`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2025 22:07:00
// Design Name: 
// Module Name: rectangle_cipher_top
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
module rectangle_cipher_top (
    input wire clk,               // Clock signal
    input wire rst,               // Reset signal
    input wire [63:0] plaintext,  // 64-bit input state
    input wire [63:0] round_key,  // 64-bit round key
    output wire [63:0] state_out  // 64-bit output state after both transformations
);
    wire [63:0] after_add_round_key;  // Intermediate state after AddRoundKey
    // Instantiate AddRoundKey module
    add_round_key u1 (
        .clk(clk),
        .rst(rst),
        .state(plaintext),
        .round_key(round_key),
        .new_state(after_add_round_key)
    );
    // Instantiate SubColumn module
    sub_column u2 (
        .clk(clk),
        .rst(rst),
        .state(after_add_round_key),
        .new_state(state_out)
    );
endmodule
