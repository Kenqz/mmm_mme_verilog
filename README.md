# Icarus Verilog README

## Overview

This README provides information on two Verilog modules: `mme.v` and `mmm.v`. These modules implement Montgomery Modular Exponentiation and Montgomery Modular Multiplication, respectively, using the Icarus Verilog simulation tool.

### Modules

1. **mme.v**: Implements Montgomery Modular Exponentiation.
2. **mmm.v**: Implements Montgomery Modular Multiplication.

## Prerequisites

To simulate and test these Verilog modules, you need the following software:

- Icarus Verilog: A Verilog simulation and synthesis tool.
- A text editor to view and edit the Verilog files.

## Installation

1. **Install Icarus Verilog**:

   Follow the instructions on the [Icarus Verilog GitHub page](https://github.com/steveicarus/iverilog) to install the tool on your system.

2. **Download the Verilog Files**:

   Ensure that `mme.v` and `mmm.v` are downloaded and located in the same directory.

## File Descriptions

### mme.v (Montgomery Modular Exponentiation)

- **Purpose**: This module performs Montgomery Modular Exponentiation, a method used in cryptographic algorithms to compute modular exponentiation efficiently.
- **Inputs**:
  - `clk`: Clock signal.
  - `rst`: Reset signal.
  - `base`: Base input for the exponentiation.
  - `exp`: Exponent input.
  - `modulus`: Modulus for the operation.
- **Outputs**:
  - `result`: Result of the exponentiation.

### mmm.v (Montgomery Modular Multiplication)

- **Purpose**: This module performs Montgomery Modular Multiplication, which allows multiplication of two numbers under a modulus efficiently.
- **Inputs**:
  - `clk`: Clock signal.
  - `rst`: Reset signal.
  - `a`: First operand.
  - `b`: Second operand.
  - `modulus`: Modulus for the operation.
- **Outputs**:
  - `result`: Result of the multiplication.

## Usage

### Simulation

To simulate the modules, follow these steps:

1. **Compile the Verilog Files**:

   ```sh
   iverilog -o mme_tb.vvp mme.v mme_tb.v
   iverilog -o mmm_tb.vvp mmm.v mmm_tb.v
