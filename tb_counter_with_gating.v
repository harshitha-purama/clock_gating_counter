// File: tb_counter_with_gating.v
// Testbench for counter_with_gating module (clock-gated)

`timescale 1ns/1ps // Define time units for simulation

module tb_counter_with_gating;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg enable; // New enable signal for clock gating
    wire [3:0] count_out;
    wire gated_clk_monitor; // To observe the gated clock

    // Instantiate the Unit Under Test (UUT)
    counter_with_gating UUT (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .count_out(count_out)
    );

    // Connect a wire to the internal gated_clk for monitoring
    // This requires an explicit connection because gated_clk is internal to counter_with_gating
    // For simplicity and direct observation in testbench, we will add a wire to UUT
    // This line is illustrative of how you'd connect to an internal wire for debugging.
    // For Icarus Verilog's $dumpvars, it will automatically dump internal signals
    // within the instantiated module if the dump level is set correctly ($dumpvars(0, tb_module))
    // So, this 'assign' line is not strictly necessary for viewing with $dumpvars(0),
    // but it shows how you might bring out an internal signal.
    // However, for clarity and proper analysis, we will rely on $dumpvars for UUT's internal signals.
    // Let's assume $dumpvars will pick up UUT's internal signals correctly.

    // Clock generation
    always #5 clk = ~clk; // Clock period of 10ns

    // Initial block for stimulus
    initial begin
        // Initialize signals
        clk = 1'b0;
        rst_n = 1'b0; // Assert reset
        enable = 1'b0; // Start with enable low (clock gated)

        // Dump waveforms to VCD file
        $dumpfile("counter_with_gating.vcd");
        $dumpvars(0, tb_counter_with_gating); // Dump all signals in testbench and instantiated modules

        // Apply reset
        #10 rst_n = 1'b1; // De-assert reset after 10ns

        // Phase 1: Enable counter for a while
        #20 enable = 1'b1; // Enable counting
        #100 // Let it count for 100ns

        // Phase 2: Disable counter (clock should be gated)
        #20 enable = 1'b0; // Disable counting (clock should stop toggling)
        #100 // Keep disabled for 100ns

        // Phase 3: Re-enable counter
        #20 enable = 1'b1; // Re-enable counting
        #100 // Let it count for 100ns

        // End simulation
        #50 $finish; // Simulate for total ~400ns then finish
    end

endmodule
