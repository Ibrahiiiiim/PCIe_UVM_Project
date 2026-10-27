`ifndef OSCREATOR_AGENT_CONFIG_SV
	`define OSCREATOR_AGENT_CONFIG_SV
	class oscreator_agent_config extends uvm_object;
	
		virtual os_creator_if vif;

		uvm_active_passive_enum is_active;

		`uvm_object_utils(oscreator_agent_config)
	
		function new(string name = "oscreator_agent_config");
			super.new(name);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new
	
	endclass : oscreator_agent_config
`endif