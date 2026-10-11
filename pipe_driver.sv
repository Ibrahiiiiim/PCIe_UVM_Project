`ifndef PIPE_DRIVER_SV
	`define PIPE_DRIVER_SV
	class pipe_driver#(Block block) extends uvm_driver#(pipe_sequence_item);
	
		virtual pipe_if vif;

		`uvm_component_param_utils(pipe_driver#(block))
	
		function new(string name = "pipe_driver", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_name(),"constructor",UVM_HIGH)

		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info(get_type_name(),"build_phase",UVM_HIGH)
			if (!uvm_config_db#(virtual pipe_if)::get(this, "", "vif",vif )) begin
				`uvm_error("NOVIF",{"virtual interface must be set for :",get_full_name(),".vif"})
			end
		endfunction : build_phase

		task run_phase(uvm_phase phase);
			`uvm_info(get_type_name(),"run_phase",UVM_HIGH)
			forever begin
				seq_item_port.get_next_item(req);
				vif.drive(req,block);
				seq_item_port.item_done();
			end
		endtask : run_phase
	
	endclass : pipe_driver
`endif
