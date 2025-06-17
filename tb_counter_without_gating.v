// File: tb_counter_without_gating.v
// Testbench for counter_without_gating module

`timescale 1ns/1ps // Define time units for simulation

module tb_counter_without_gating;

    // Testbench signals
    reg clk;
    reg rst_n;
    wire [3:0] count_out;

    // Instantiate the Unit Under Test (UUT)
    counter_without_gating UUT (
        .clk(clk),
        .rst_n(rst_n),
        .count_out(count_out)
    );

    // Clock generation
    always #5 clk = ~clk; // Clock period of 10ns (5ns high, 5ns low)

    // Initial block for stimulus
    initial begin
        // Initialize signals
        clk = 1'b0;
        rst_n = 1'b0; // Assert reset

        // Dump waveforms to VCD file
        $dumpfile("counter_without_gating.vcd");
        $dumpvars(0, tb_counter_without_gating);

        // Apply reset
        #10 rst_n = 1'b1; // De-assert reset after 10ns

        // Run simulation for a period
        #1000 $finish; // Simulate for 1000ns then finish
    end

    // Optional: Monitor signals (for text output in terminal)
    // always @(posedge clk) begin
    //     $display("Time: %0t, Count: %d", $time, count_out);
    // end

endmodule
