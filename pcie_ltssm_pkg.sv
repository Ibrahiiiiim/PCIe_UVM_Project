`ifndef PCIE_LTSSM_PKG_SV
	`define PCIE_LTSSM_PKG_SV
	`include "uvm_macros.svh"
	`include "pipe_pkg.sv"
	`include "timer_pkg.sv"
	`include "os_decoder_pkg.sv"
	`include "os_creator_pkg.sv"
	package pcie_ltssm_pkg;
		import uvm_pkg::*;
		import pipe_pkg::*;
		import timer_pkg::*;
		import os_decoder_pkg::*;
		import os_creator_pkg::*;
		
		
	endpackage : pcie_ltssm_pkg
`endif