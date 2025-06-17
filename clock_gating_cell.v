// File: clock_gating_cell.v
// Simple positive-edge triggered clock gating cell with latch
// This design helps prevent glitches on the gated clock.

module clock_gating_cell (
    input wire clk_in,    // Original clock input
    input wire enable,    // Enable signal (when high, clock passes)
    output wire clk_out   // Gated clock output
);

    reg latch_out; // Latch to hold the enable signal when clk_in is low

    // D-Latch for glitch-free gating
    // Latch_out captures 'enable' when clk_in is low (active high latch)
    always @(clk_in or enable) begin
        if (!clk_in) begin // When clk_in is low, latch_out tracks enable
            latch_out = enable;
        end
        // else latch_out holds its value when clk_in is high
    end

    // Gating logic: clk_out goes high only if clk_in is high AND latch_out is high
    // This ensures clk_out only rises cleanly when clk_in rises AND enable was stable high
    assign clk_out = clk_in & latch_out;

endmodule
