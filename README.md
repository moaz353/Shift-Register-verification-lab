# Shift Register Verification Lab

A UVM-based functional verification environment for a shift register design.

## Overview

This lab implements a complete UVM testbench to verify a shift register (`shift_reg.v`) written in Verilog. The environment covers reset and normal operation scenarios with functional coverage collection.

## Project Structure

| File | Description |
|------|-------------|
| `shift_reg.v` | DUT — Verilog shift register design |
| `shift_reg_if.sv` | Interface |
| `top.sv` | Top-level testbench module |
| `shift_reg_test.sv` | UVM test |
| `shift_reg_env.sv` | UVM environment |
| `shift_reg_agent.sv` | UVM agent |
| `shift_reg_driver.sv` | UVM driver |
| `shift_reg_monitor.sv` | UVM monitor |
| `shift_reg_sequencer.sv` | UVM sequencer |
| `shift_reg_sequence.sv` | UVM sequence |
| `shift_reg_scoreboard.sv` | Scoreboard for result checking |
| `shift_reg_coverage_collector.sv` | Functional coverage |
| `shift_reg_config_obj.sv` | Configuration object |
| `main_sequence_item.sv` | Main transaction item |
| `rst_sequence_item.sv` | Reset transaction item |
| `shared_pkg.sv` | Shared package |
| `src_files.list` | Source file list |
| `run.tcl` | Simulation run script |
| `Reports/` | Simulation reports |
