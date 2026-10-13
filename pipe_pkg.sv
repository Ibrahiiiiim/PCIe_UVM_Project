`ifndef PIPE_PKG_SV
	`define PIPE_PKG_SV
	`include "uvm_macros.svh"
	`include "pipe_if.sv"
	package pipe_pkg;
		import uvm_pkg::*;
		`include "pipe_sequence_item.sv"
		`include "pipe_driver.sv"
		`include "pipe_monitor.sv"
		`include "pipe_sequencer.sv"
		`include "pipe_agent.sv"
		
	endpackage : pipe_pkg
`endif