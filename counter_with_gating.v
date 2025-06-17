// File: counter_with_gating.v
// 4-bit ripple-carry counter with clock gating

module counter_with_gating (
    input wire clk,       // Original clock input
    input wire rst_n,     // Active-low reset
    input wire enable,    // Counter enable (when high, counter increments)
    output reg [3:0] count_out
);

    wire gated_clk; // Wire for the output of the clock gating cell

    // Instantiate the clock gating cell
    clock_gating_cell CGC (
        .clk_in(clk),
        .enable(enable),
        .clk_out(gated_clk)
    );

    // Counter logic, now driven by the gated clock
    always @(posedge gated_clk or negedge rst_n) begin
        if (!rst_n) begin
            count_out <= 4'b0000; // Reset to 0
        end else begin
            count_out <= count_out + 1; // Increment count
        end
    end

endmodule

