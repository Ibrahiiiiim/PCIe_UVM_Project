`ifndef PIPE_AGENT_SV
	`define PIPE_AGENT_SV
	class pipe_agent#(Block block) extends uvm_agent;
	
		virtual pipe_if vif;

		pipe_agent_config config;

		pipe_driver#(block) driver;

		pipe_monitor#(block) monitor;

		pipe_sequencer sequencer;

		uvm_analysis_export#(pipe_sequence_item) pipe_analysis_export;

		`uvm_component_param_utils(pipe_agent#(block))
	
		function new(string name = "pipe_agent", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_name(),"constructor",UVM_HIGH)
			pipe_analysis_export=new("pipe_analysis_export",this);
		endfunction : new
	
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info(get_type_name(),"build phase",UVM_HIGH)
			config = pipe_agent_config::type_id::create("config");
			if (!uvm_config_db#(pipe_agent_config)::get(this, "", "pipe_config",config )) begin
				`uvm_error("NOCONFIG",{"configuration object must be set for: ",get_full_name(),".config"})
			end
			if (config.is_active==UVM_ACTIVE) begin
				uvm_config_db#(virtual pipe_if)::set(this, "driver", "pipe_vif",config.vif );
				driver = pipe_driver#(block)::type_id::create("driver",this);
				sequencer = pipe_sequencer::type_id::create("sequencer",this);
			end
			
			uvm_config_db#(virtual pipe_if)::set(this,"monitor","pipe_vif",config.vif);
			monitor = pipe_monitor#(block)::type_id::create("monitor",this);

		endfunction : build_phase

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info(get_type_name(),"build phase",UVM_HIGH)

			if (config.is_active==UVM_ACTIVE) begin
				driver.seq_item_port.connect(sequencer.seq_item_export);
			end
			monitor.pipe_analysis_port.connect(pipe_analysis_export);
		endfunction : connect_phase
	endclass : pipe_agent
`endif