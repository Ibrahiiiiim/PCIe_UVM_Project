`ifndef OS_CREATOR_PKG_SV
	`define OS_CREATOR_PKG_SV
	`include "uvm_macros.svh"
	`include "os_creator_if.sv"
	package os_creator_pkg;
		import uvm_pkg::*;
		`include "oscreator_sequence_item.sv"
		`include "oscreator_agent_config.sv"
		`include "oscreator_sequencer.sv"
		`include "oscreator_monitor.sv"
		`include "oscreator_driver.sv"
		`include "oscreator_agent.sv"
		
	endpackage : os_creator_pkg
`endif