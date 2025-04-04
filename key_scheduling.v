module key_schedule (
    input wire clk,                  // Clock signal
    input wire rst,                  // Reset signal
    input wire [79:0] initial_key,    // Initial 80-bit key
    output reg [79:0] round_key,      // Output only the current round key
    output reg [4:0] round_count      // Output the current round number (0 to 24)
);

    reg [3:0] sbox [0:15];  // S-box lookup table
    reg [4:0] round_constants [0:24]; // Round constants
    reg [79:0] current_key;

    initial begin
        // Initialize S-box
        sbox[4'h0] = 4'h6; sbox[4'h1] = 4'h5; sbox[4'h2] = 4'hC; sbox[4'h3] = 4'hA;
        sbox[4'h4] = 4'h1; sbox[4'h5] = 4'hE; sbox[4'h6] = 4'h7; sbox[4'h7] = 4'h9;
        sbox[4'h8] = 4'hB; sbox[4'h9] = 4'h0; sbox[4'hA] = 4'h3; sbox[4'hB] = 4'hD;
        sbox[4'hC] = 4'h8; sbox[4'hD] = 4'hF; sbox[4'hE] = 4'h4; sbox[4'hF] = 4'h2;

        // Initialize Round Constants
        round_constants[0]  = 5'h01; round_constants[1]  = 5'h03; round_constants[2]  = 5'h07;
        round_constants[3]  = 5'h0F; round_constants[4]  = 5'h1F; round_constants[5]  = 5'h1E;
        round_constants[6]  = 5'h1C; round_constants[7]  = 5'h18; round_constants[8]  = 5'h10;
        round_constants[9]  = 5'h11; round_constants[10] = 5'h13; round_constants[11] = 5'h17;
        round_constants[12] = 5'h0E; round_constants[13] = 5'h1D; round_constants[14] = 5'h1B;
        round_constants[15] = 5'h17; round_constants[16] = 5'h0D; round_constants[17] = 5'h1A;
        round_constants[18] = 5'h15; round_constants[19] = 5'h0B; round_constants[20] = 5'h16;
        round_constants[21] = 5'h0C; round_constants[22] = 5'h09; round_constants[23] = 5'h12;
        round_constants[24] = 5'h14;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_key <= initial_key;  // Load the initial key
            round_key   <= initial_key;  // Output the initial key
            round_count <= 0;            // Reset round counter
        end else if (round_count < 25) begin
            // Step 1: Apply S-box to selected bits
            current_key[3:0]   <= sbox[current_key[3:0]];
            current_key[19:16] <= sbox[current_key[19:16]];
            current_key[35:32] <= sbox[current_key[35:32]];
            current_key[51:48] <= sbox[current_key[51:48]];

            // Step 2: Apply Feistel transformation
            current_key <= {
                {current_key[7:0], current_key[15:8]} ^ current_key[31:16],
                current_key[47:32],
                current_key[63:48],
                current_key[79:64] ^ {current_key[51:48], current_key[63:52]},
                current_key[15:0]
            };

            // Step 3: XOR with round constant
            current_key[4:0] <= current_key[4:0] ^ round_constants[round_count];

            // Update round key output
            round_key <= current_key;

            // Increment round count
            round_count <= round_count + 1;
            
        end
    end
endmodule
