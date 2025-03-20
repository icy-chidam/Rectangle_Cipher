`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2025 16:20:00
// Design Name: 
// Module Name: permutation
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


module permutation (
    input  wire [63:0] in,       // 64-bit input
    output reg  [63:0] out,      // 64-bit output
    output reg  [63:0] shift_rows // 64-bit intermediate result
);
    
    always @(*) begin  // Combinational logic
       out[15:0]   = in[15:0];
       out[31:16] = {in[30:16], in[31]};  
       out[47:32] = {in[35:32], in[47:36]};  // 12-bit left shift
       out[63:48] = {in[50:48], in[63:51]};  // 13-bit left shift
        shift_rows  = out;
    end

endmodule
