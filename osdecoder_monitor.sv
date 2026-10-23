`ifndef OSDECODER_MONITOR_SV
	`define OSDECODER_MONITOR_SV
	class osdecoder_monitor#(Block block) extends uvm_monitor;
	
		`uvm_component_param_utils(osdecoder_monitor#(block))
	
		function new(string name = "osdecoder_monitor", uvm_component parent=null);
			super.new(name, parent);
		endfunction : new
	
	endclass : osdecoder_monitor
`endif