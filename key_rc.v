module key_rc(
    input wire [79:0] key_in,
    output reg [4:0] current_round_constant,
    output reg [79:0] key_out,
    input wire clk,
    input wire rst  // Make this active-high and synchronous
);

    reg [4:0] round_constants [0:24];
    reg [4:0] round_count;
    reg [79:0] current_key;

    // Initialize round constants
    initial begin
        round_constants[0]  = 5'h01; round_constants[1]  = 5'h02; round_constants[2]  = 5'h04;
        round_constants[3]  = 5'h09; round_constants[4]  = 5'h12; round_constants[5]  = 5'h05;
        round_constants[6]  = 5'h0B; round_constants[7]  = 5'h16; round_constants[8]  = 5'h0C;
        round_constants[9]  = 5'h19; round_constants[10] = 5'h13; round_constants[11] = 5'h07;
        round_constants[12] = 5'h0F; round_constants[13] = 5'h1F; round_constants[14] = 5'h1E;
        round_constants[15] = 5'h1C; round_constants[16] = 5'h18; round_constants[17] = 5'h11;
        round_constants[18] = 5'h03; round_constants[19] = 5'h06; round_constants[20] = 5'h0D;
        round_constants[21] = 5'h1B; round_constants[22] = 5'h17; round_constants[23] = 5'h0E;
        round_constants[24] = 5'h1D;
    end

    always @(posedge clk) begin
        if (rst) begin
            current_key <= key_in;
            key_out <= key_in;
            round_count <= 0;
            current_round_constant <= 1;
        end else if (round_count < 25) begin
            current_key[4:0] <= current_key[4:0] ^ round_constants[round_count];
            key_out <= current_key;
            current_round_constant <= round_constants[round_count];
            round_count <= round_count + 1;
        end
    end

endmodule
