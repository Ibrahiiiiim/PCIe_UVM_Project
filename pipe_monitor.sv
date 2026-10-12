`ifndef PIPE_MONITOR_SV
	`define PIPE_MONITOR_SV
	class pipe_monitor#(Block block) extends uvm_monitor;
	
		pipe_sequence_item item;

		virtual pipe_if vif;

		uvm_analysis_port#(pipe_sequence_item) pipe_analysis_port;

		`uvm_component_param_utils(pipe_monitor#(monitor))
	
		function new(string name = "pipe_monitor", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_name(),"constructor",UVM_HIGH)
		endfunction : new
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			item = pipe_sequence_item ::type_id::create("item");
			`uvm_info(get_type_name(),"build_phase",UVM_HIGH)
			if (!uvm_config_db#(virtual pipe_if)::get(this,"","vif",vif)) begin
				`uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
			end
			pipe_analysis_port = new("pipe_analysis_port",this);
		endfunction : build_phase	


		task run_phase(uvm_phase phase);
			//static int first_flag = 1'b1;
			`uvm_info(get_type_name(),"run phase",UVM_HIGH)
			forever begin
				//if (!first_flag) begin
					vif.monitor(item,block);
					pipe_analysis_port.write(item);
				//end else begin
					//@(vif.pipe_cb);
					//first_flag=0;
				end
			end
		endtask : run_phase

	endclass : pipe_monitor
`endif