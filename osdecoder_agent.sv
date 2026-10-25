`ifndef OSDECODER_AGENT_SV
	`define OSDECODER_AGENT_SV
	class osdecoder_agent#(Block block) extends uvm_agent;

		virtual os_decoder_if vif;
	
		osdecoder_sequencer sequencer;
		osdecoder_monitor#(block) monitor;
		osdecoder_driver#(block) driver;

		osdecoder_agent_config config;

		uvm_analysis_export#(osdecoder_sequence_item) osdecoder_analysis_export;

		`uvm_component_param_utils(osdecoder_agent#(block))
	
		function new(string name = "osdecoder_agent", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
			osdecoder_analysis_export = new("osdecoder_analysis_export",this);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info(get_type_item(),"build_phase",UVM_HIGH)

			config = osdecoder_agent_config::type_id::create("item");
			if (!uvm_config_db#(osdecoder_agent_config)::get(this, "", "osdecoder_config",config )) begin
	            `uvm_error("NOCONFIG", {"Configuration Object must be set for: ", get_full_name(), ".config"})
			end
			if (config.is_active == UVM_ACTIVE) begin
				uvm_config_db#(virtual os_decoder_if)::set(this, "driver", "os_decoder_vif",config.vif);
				driver = osdecoder_driver#(block)::type_id::create("driver",this);
				sequencer = osdecoder_sequencer::type_id::create("sequencer",this);
			end

				uvm_config_db#(virtual os_decoder_if)::set(this, "monitor", "os_decoder_vif",config.vif);

				monitor = osdecoder_monitor#(block)::type_id::create("monitor",this);

		endfunction : build_phase

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info(get_type_item(),"connect_phase",UVM_HIGH)

			if (config.is_active == UVM_ACTIVE) begin
				driver.seq_item_port.connect(sequencer.seq_item_export);
			end
			monitor.osdecoder_analysis_port.connect(osdecoder_analysis_export);
		endfunction : connect_phase

	
	endclass : osdecoder_agent
`endif