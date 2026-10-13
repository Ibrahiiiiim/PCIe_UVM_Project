`ifndef PIPE_AGENT_CONFIG_SV
	`define PIPE_AGENT_CONFIG_SV
	class pipe_agent_config extends uvm_object;
	
		virtual pipe_if vif;

		uvm_active_passive_enum is_active;

		`uvm_object_utils(pipe_agent_config)
	
		function new(string name = "pipe_agent_config");
			super.new(name);
			`uvm_info(get_type_name(),"constructor",UVM_HIGH)
		endfunction : new
	
	endclass : pipe_agent_config
`endif