`ifndef PIPE_DRIVER_SV
	`define PIPE_DRIVER_SV
	class pipe_driver extends  /* base class*/;
	

		`uvm_component_utils(pipe_driver)
	
		function new(string name = "pipe_driver", uvm_component parent=null);
			super.new(name, parent);
		endfunction : new
	
	endclass : pipe_driver
`endif