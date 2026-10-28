# Simulator
SIM = icarus

# HDL configuration
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(PWD)/counter.sv
COCOTB_TOPLEVEL = counter

# Python test module
COCOTB_TEST_MODULES = test_counter

# Simulation time units
COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 1ps

# Enable waveform generation
WAVES = 1

# Cocotb simulator integration
include $(shell cocotb-config --makefiles)/Makefile.sim