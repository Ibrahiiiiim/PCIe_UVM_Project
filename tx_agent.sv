`ifndef TX_AGENT_SV
	`define TX_AGENT_SV
	class tx_agent#(Block block) extends uvm_agent;

		virtual tx_if vif;
	
		tx_sequencer sequencer;
		tx_monitor#(block) monitor;
		tx_driver#(block) driver;

		tx_agent_config config;

		uvm_analysis_export#(tx_sequence_item) tx_analysis_export;

		`uvm_component_param_utils(tx_agent#(block))
	
		function new(string name = "tx_agent", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
			tx_analysis_export = new("tx_analysis_export",this);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info(get_type_item(),"build_phase",UVM_HIGH)

			config = tx_agent_config::type_id::create("item");
			if (!uvm_config_db#(tx_agent_config)::get(this, "", "tx_config",config )) begin
	            `uvm_error("NOCONFIG", {"Configuration Object must be set for: ", get_full_name(), ".config"})
			end
			if (config.is_active == UVM_ACTIVE) begin
				uvm_config_db#(virtual tx_if)::set(this, "driver", "tx_vif",config.vif);
				driver = tx_driver#(block)::type_id::create("driver",this);
				sequencer = tx_sequencer::type_id::create("sequencer",this);
			end

				uvm_config_db#(virtual tx_if)::set(this, "monitor", "tx_vif",config.vif);

				monitor = tx_monitor#(block)::type_id::create("monitor",this);

		endfunction : build_phase

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info(get_type_item(),"connect_phase",UVM_HIGH)

			if (config.is_active == UVM_ACTIVE) begin
				driver.seq_item_port.connect(sequencer.seq_item_export);
			end
			monitor.tx_analysis_port.connect(tx_analysis_export);
		endfunction : connect_phase

	
	endclass : tx_agent
`endif