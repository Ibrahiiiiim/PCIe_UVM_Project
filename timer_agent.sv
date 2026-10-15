`ifndef TIMER_AGENT_SV
	`define TIMER_AGENT_SV
	class timer_agent extends uvm_agent;
	
		virtual timer_if vif;

		timer_agent_config config;

		timer_driver driver;

		timer_monitor monitor;

		timer_sequencer sequencer;

		uvm_analysis_export#(timer_sequence_item) timer_analysis_export;

		`uvm_component_utils(timer_agent)
	
		function new(string name = "timer_agent", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_name(),"constructor",UVM_HIGH)
			timer_analysis_export=new("timer_analysis_export",this);
		endfunction : new
	
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info(get_type_name(),"build phase",UVM_HIGH)
			config = timer_agent_config::type_id::create("config");
			if (!uvm_config_db#(timer_agent_config)::get(this, "", "timer_config",config )) begin
				`uvm_error("NOCONFIG",{"configuration object must be set for: ",get_full_name(),".config"})
			end
			if (config.is_active==UVM_ACTIVE) begin
				uvm_config_db#(virtual pipe_if)::set(this, "driver", "timer_vif",config.vif );
				driver = timer_driver::type_id::create("driver",this);
				sequencer = timer_sequencer::type_id::create("sequencer",this);
			end
			
			uvm_config_db#(virtual pipe_if)::set(this,"monitor","pipe_vif",config.vif);
			monitor = timer_monitor::type_id::create("monitor",this);

		endfunction : build_phase

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info(get_type_name(),"build phase",UVM_HIGH)

			if (config.is_active==UVM_ACTIVE) begin
				driver.seq_item_port.connect(sequencer.seq_item_export);
			end
			monitor.timer_analysis_port.connect(timer_analysis_export);
		endfunction : connect_phase
	endclass : timer_agent
`endif