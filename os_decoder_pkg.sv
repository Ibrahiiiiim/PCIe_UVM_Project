`ifndef OS_DECODER_PKG_SV
	`define OS_DECODER_PKG_SV
	`include "uvm_macros.svh"
	`include "os_decoder_if.sv"
	package os_decoder_pkg;
		import uvm_pkg::*;
		`include "osdecoder_sequence_item.sv"
		`include "osdecoder_agent_config.sv"
		`include "osdecoder_sequencer.sv"
		`include "osdecoder_driver.sv"
		`include "osdecoder_monitor.sv"
		
	endpackage : os_decoder_pkg
`endif