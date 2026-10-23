`ifndef OSDECODER_AGENT_CONFIG_SV
	`define OSDECODER_AGENT_CONFIG_SV
	class osdecoder_agent_config extends uvm_object;
	
		virtual os_decoder_if vif;

		uvm_active_passive_enum is_active;

		`uvm_object_utils(osdecoder_agent_config)
	
		function new(string name = "osdecoder_agent_config");
			super.new(name);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new
	
	endclass : osdecoder_agent_config
`endif