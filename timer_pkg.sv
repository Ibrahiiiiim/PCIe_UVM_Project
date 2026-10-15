`ifndef TIMER_PKG_SV
	`define TIMER_PKG_SV
	`include "uvm_macros.svh"
	`include "timer_if.sv"
	package timer_pkg;
		import uvm_pkg::*;
		`include "timer_sequence_item.sv"
		`include "timer_agent_config.sv"
		`include "timer_sequencer.sv"
		`include "timer_driver.sv"
		`include "timer_monitor.sv"
		`include "timer_agent.sv"
		
	endpackage : timer_pkg
`endif