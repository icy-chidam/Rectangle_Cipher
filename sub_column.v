`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2025 20:48:01
// Design Name: 
// Module Name: sub_column
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
module sub_column (
    input wire clk,               // Clock signal
    input wire rst,               // Reset signal
    input wire [63:0] state,      // 64-bit input state
    output reg [63:0] new_state   // 64-bit output state (stored in a register)
);
    // S-box function for 4-bit substitution
    function [3:0] sbox;
        input [3:0] in;
        begin
            case (in)
                4'h0: sbox = 4'h6;  4'h1: sbox = 4'h5;  4'h2: sbox = 4'hC;  4'h3: sbox = 4'hA;
                4'h4: sbox = 4'h1;  4'h5: sbox = 4'hE;  4'h6: sbox = 4'h7;  4'h7: sbox = 4'h9;
                4'h8: sbox = 4'hB;  4'h9: sbox = 4'h0;  4'hA: sbox = 4'h3;  4'hB: sbox = 4'hD;
                4'hC: sbox = 4'h8;  4'hD: sbox = 4'hF;  4'hE: sbox = 4'h4;  4'hF: sbox = 4'h2;
            endcase
        end
    endfunction
    integer i;

    // Sequential process (runs on every clock edge)
    always @(*) begin
        if (rst)
            new_state <= 64'b0;  // Reset output state to zero
        else begin
            for (i = 0; i < 16; i = i + 1) begin
                new_state[(i * 4) +: 4] <= sbox(state[(i * 4) +: 4]); // Apply S-box column-wise
            end
        end
    end
endmodule

