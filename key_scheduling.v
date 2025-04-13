module key_schedule(
    input wire clk,
    input wire rst,
    input wire [79:0] initial_key,
    output reg [79:0] round_key,
    output reg [4:0] round_count,
    output reg [4:0] current_round_constant
);
    reg [79:0] current_key;

    wire [79:0] sbox_out;
    wire [79:0] feistel_out;
    wire [79:0] xor_out;

    wire [4:0] round_constants [0:24];
    assign round_constants[0]  = 5'h01; assign round_constants[1]  = 5'h02;
    assign round_constants[2]  = 5'h04; assign round_constants[3]  = 5'h09;
    assign round_constants[4]  = 5'h12; assign round_constants[5]  = 5'h05;
    assign round_constants[6]  = 5'h0B; assign round_constants[7]  = 5'h16;
    assign round_constants[8]  = 5'h0C; assign round_constants[9]  = 5'h19;
    assign round_constants[10] = 5'h13; assign round_constants[11] = 5'h07;
    assign round_constants[12] = 5'h0F; assign round_constants[13] = 5'h1F;
    assign round_constants[14] = 5'h1E; assign round_constants[15] = 5'h1C;
    assign round_constants[16] = 5'h18; assign round_constants[17] = 5'h11;
    assign round_constants[18] = 5'h03; assign round_constants[19] = 5'h06;
    assign round_constants[20] = 5'h0D; assign round_constants[21] = 5'h1B;
    assign round_constants[22] = 5'h17; assign round_constants[23] = 5'h0E;
    assign round_constants[24] = 5'h1D;

    sbox_layer u1(.key_in(current_key), .key_out(sbox_out));
    feistel_transform  u2(.key_in(sbox_out),   .key_out(feistel_out));
    round_constant_xor u3(.key_in(feistel_out), .round_constant(round_constants[round_count]), .key_out(xor_out));

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_key <= initial_key;
            round_key   <= initial_key;
            round_count <= 0;
        end else if (round_count < 25) begin
            current_key <= xor_out;
            round_key   <= xor_out;
            current_round_constant <= round_constants[round_count];
            round_count <= round_count + 1;
        end
    end
endmodule
