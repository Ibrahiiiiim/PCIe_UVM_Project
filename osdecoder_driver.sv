`ifndef OSDECODER_DRIVER_SV
	`define OSDECODER_DRIVER_SV
	class osdecoder_driver#(Block block) extends uvm_driver;
	
		`uvm_component_param_utils(osdecoder_driver#(block))
	
		function new(string name = "osdecoder_driver", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new
	
	endclass : osdecoder_driver
`endif