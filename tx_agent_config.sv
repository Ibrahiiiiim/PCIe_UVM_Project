`ifndef TX_AGENT_CONFIG_SV
	`define TX_AGENT_CONFIG_SV
	class tx_agent_config extends uvm_object;
	
		virtual tx_if vif;

		uvm_active_passive_enum is_active;

		`uvm_object_utils(tx_agent_config)
	
		function new(string name = "tx_agent_config");
			super.new(name);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new
	
	endclass : tx_agent_config
`endif