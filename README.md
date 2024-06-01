
# Single Cycle MIPS Processor in Verilog

This project implements a single-cycle MIPS processor in Verilog. The processor is capable of executing MIPS instructions in a single clock cycle.

## Overview

The single-cycle MIPS processor consists of several key components:

- **Instruction Memory (IM):** Stores the MIPS instructions.
- **Data Memory (DM):** Stores data accessed by the processor.
- **MIPS Core (M):** Central processing unit executing instructions fetched from the instruction memory.
  
The processor fetches instructions from the instruction memory, decodes and executes them, and accesses data memory as required.

## Project Structure

- **`singleCyclePro.v`:** Top-level module integrating the instruction memory, data memory, and MIPS core.
- **`instr_memory.v`:** Instruction memory module responsible for storing and fetching instructions.
- **`data_memory.v`:** Data memory module for storing and retrieving data.
- **`mips.v`:** MIPS core module performing instruction execution and data manipulation.

## Usage

To use the single-cycle MIPS processor:

1. Ensure Verilog simulation and synthesis tools are installed.
2. Simulate or synthesize the `singleCyclePro` module using your preferred Verilog toolchain.
