`ifndef TX_PKG_SV
	`define TX_PKG_SV
	`include "uvm_macros.svh"
	`include "tx_if.sv"
	package tx_pkg;
		import uvm_pkg::*;
		`include "tx_sequence_item.sv"
		
	endpackage : tx_pkg
`endif