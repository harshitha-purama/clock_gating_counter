# Clock Gating Counter Project

This repository contains the Verilog implementation and testbenches for a 4-bit ripple-carry counter, demonstrating the power-saving technique of clock gating.

## Project Overview

The project includes two main counter designs:
1.  **`counter_without_gating.v`**: A standard 4-bit counter where the clock is continuously supplied to its flip-flops.
2.  **`counter_with_gating.v`**: A 4-bit counter that incorporates a `clock_gating_cell.v` to selectively enable/disable the clock signal to its internal flip-flops, thereby reducing dynamic power consumption when the counter is idle.

The project aims to visually demonstrate the effect of clock gating on switching activity using waveform analysis.

## Files:

* `counter_without_gating.v`: The Verilog code for the basic 4-bit counter.
* `tb_counter_without_gating.v`: Testbench for the non-gated counter.
* `clock_gating_cell.v`: The Verilog module for the glitch-free clock gating cell.
* `counter_with_gating.v`: The Verilog code for the 4-bit counter utilizing clock gating.
* `tb_counter_with_gating.v`: Testbench for the clock-gated counter, including an `enable` signal.
* `.gitignore`: Specifies files (like simulation outputs) that should not be tracked by Git.

## How to Simulate and View Waveforms:

This project uses Icarus Verilog (`iverilog`) for compilation/simulation and GTKWave for waveform viewing.

### Prerequisites:
* Icarus Verilog (`iverilog` and `vvp`)
* GTKWave (installed via `brew install --HEAD randomplum/gtkwave/gtkwave` if on macOS 14+)

### Steps:

1.  **Navigate to the project directory:**
    ```bash
    cd projects/clock_gating_counter/
    ```

2.  **Simulate the Counter WITHOUT Gating:**
    ```bash
    iverilog -o counter_sim counter_without_gating.v tb_counter_without_gating.v
    vvp counter_sim
    ```
    This generates `counter_without_gating.vcd`.

3.  **Simulate the Counter WITH Gating:**
    ```bash
    iverilog -o gated_counter_sim clock_gating_cell.v counter_with_gating.v tb_counter_with_gating.v
    vvp gated_counter_sim
    ```
    This generates `counter_with_gating.vcd`.

4.  **View Waveforms in GTKWave:**
    Open either VCD file using GTKWave:
    ```bash
    gtkwave counter_without_gating.vcd
    # OR
    gtkwave counter_with_gating.vcd
    ```
    *In GTKWave, select signals (`clk`, `rst_n`, `enable`, `count_out`, and `gated_clk` from `UUT` for the gated counter) from the left panel and click the `+` (Append) button to display them.*

## Conclusion on Power Saving (Clock Gating):

Comparing the waveforms, it can be observed that the `gated_clk` signal to the flip-flops stops toggling when the `enable` signal is low. This significantly reduces dynamic power consumption by preventing unnecessary switching activity within the counter's registers and associated clock network when the counter is not active. This practical demonstration aligns with principles of low-power design, such as reducing the activity factor, as discussed in literature like "A Survey of Low-Voltage Low-Power Techniques and Challenges for CMOS Digital Circuits" by Hung, Shieh, and Tung.

