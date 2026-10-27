`ifndef OSCREATOR_AGENT_SV
	`define OSCREATOR_AGENT_SV
	class oscreator_agent#(Block block) extends uvm_agent;

		virtual os_creator_if vif;
	
		oscreator_sequencer sequencer;
		oscreator_monitor#(block) monitor;
		oscreator_driver#(block) driver;

		oscreator_agent_config config;

		uvm_analysis_export#(oscreator_sequence_item) oscreator_analysis_export;

		`uvm_component_param_utils(oscreator_agent#(block))
	
		function new(string name = "oscreator_agent", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
			oscreator_analysis_export = new("oscreator_analysis_export",this);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info(get_type_item(),"build_phase",UVM_HIGH)

			config = oscreator_agent_config::type_id::create("item");
			if (!uvm_config_db#(oscreator_agent_config)::get(this, "", "oscreator_config",config )) begin
	            `uvm_error("NOCONFIG", {"Configuration Object must be set for: ", get_full_name(), ".config"})
			end
			if (config.is_active == UVM_ACTIVE) begin
				uvm_config_db#(virtual os_creator_if)::set(this, "driver", "os_creator_vif",config.vif);
				driver = oscreator_driver#(block)::type_id::create("driver",this);
				sequencer = oscreator_sequencer::type_id::create("sequencer",this);
			end

				uvm_config_db#(virtual os_creator_if)::set(this, "monitor", "os_creator_vif",config.vif);

				monitor = oscreator_monitor#(block)::type_id::create("monitor",this);

		endfunction : build_phase

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info(get_type_item(),"connect_phase",UVM_HIGH)

			if (config.is_active == UVM_ACTIVE) begin
				driver.seq_item_port.connect(sequencer.seq_item_export);
			end
			monitor.oscreator_analysis_port.connect(oscreator_analysis_export);
		endfunction : connect_phase

	
	endclass : oscreator_agent
`endif