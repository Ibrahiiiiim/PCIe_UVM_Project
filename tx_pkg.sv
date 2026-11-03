`ifndef TX_PKG_SV
	`define TX_PKG_SV
	`include "uvm_macros.svh"
	`include "tx_if.sv"
	package tx_pkg;
		import uvm_pkg::*;
		`include "tx_sequence_item.sv"
		`include "tx_agent_config.sv"
		`include "tx_sequencer.sv"
		`include "tx_monitor.sv"
		`include "tx_driver.sv"
		`include "tx_agent.sv"
		
	endpackage : tx_pkg
`endif