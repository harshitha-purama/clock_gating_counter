// File: counter_without_gating.v
// Simple 4-bit ripple-carry counter without clock gating

module counter_without_gating (
    input wire clk,
    input wire rst_n, // Active-low reset
    output reg [3:0] count_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_out <= 4'b0000; // Reset to 0
        end else begin
            count_out <= count_out + 1; // Increment count
        end
    end

endmodule
