`ifndef PCIE_PKG_SV
	`define PCIE_PKG_SV
	`include"uvm_macros.svh"
	`include "pcie_ltssm_pkg.sv"
	`include "pcie_tx_pkg.sv"
	`include "pipe_pkg.sv"
	`include "timer_pkg.sv"
	`include "os_decoder_pkg.sv"
	package pcie_pkg;
		import uvm_pkg::*;
		import pcie_ltssm_pkg::*;
		import pcie_tx_pkg::*;
		import pipe_pkg::*;
		import timer_pkg::*;
		import os_decoder_pkg::*;
		
		
		
	endpackage : pcie_pkg
`endif