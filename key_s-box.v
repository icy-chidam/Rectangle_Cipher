module sbox_layer(
    input wire [79:0] key_in,
    input wire clk,
    input wire rst,
    output reg [79:0] key_out,
    output reg [4:0] round_count
);
    reg [79:0] current_key;
    reg [3:0] sbox [15:0];

    initial begin
        sbox[4'h0] = 4'h6; sbox[4'h1] = 4'h5; sbox[4'h2] = 4'hC; sbox[4'h3] = 4'hA;
        sbox[4'h4] = 4'h1; sbox[4'h5] = 4'hE; sbox[4'h6] = 4'h7; sbox[4'h7] = 4'h9;
        sbox[4'h8] = 4'hB; sbox[4'h9] = 4'h0; sbox[4'hA] = 4'h3; sbox[4'hB] = 4'hD;
        sbox[4'hC] = 4'h8; sbox[4'hD] = 4'hF; sbox[4'hE] = 4'h4; sbox[4'hF] = 4'h2;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_key <= key_in;
            round_count <= 0;
            key_out <= key_in;
        end else if (round_count < 25) begin
            // S-box substitution (4 columns)
            {current_key[48], current_key[32], current_key[16], current_key[0]} <= sbox[{key_out[48], key_out[32], key_out[16], key_out[0]}];
            {current_key[49], current_key[33], current_key[17], current_key[1]} <= sbox[{key_out[49], key_out[33], key_out[17], key_out[1]}];
            {current_key[50], current_key[34], current_key[18], current_key[2]} <= sbox[{key_out[50], key_out[34], key_out[18], key_out[2]}];
            {current_key[51], current_key[35], current_key[19], current_key[3]} <= sbox[{key_out[51], key_out[35], key_out[19], key_out[3]}];

            key_out <= current_key;
            round_count <= round_count + 1;
        end
    end
endmodule
