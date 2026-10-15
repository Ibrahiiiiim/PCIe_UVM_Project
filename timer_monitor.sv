`ifndef TIMER_MONITOR_SV
	`define TIMER_MONITOR_SV
	class timer_monitor extends uvm_monitor;
	
		virtual timer_if vif;

		timer_sequence_item item;

		uvm_analysis_port#(timer_sequence_item) timer_analysis_port;

		`uvm_component_utils(timer_monitor)
	
		function new(string name = "timer_monitor", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_name(),"constructor",UVM_HIGH)
			timer_analysis_export = new("timer_analysis_export",this);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			`uvm_info(get_type_name(),"constructor",UVM_HIGH)

			item = timer_sequence_item::type_id::create("item");

			if (!uvm_config_db#(virtual timer_if)::get(this, "", "timer_vif",vif )) begin
				`uvm_error("NOVIF",{"virtual interface must be set for :",get_full_name(),".vif"})
			end
		endfunction : build_phase

		task run_phase(uvm_phase phase);
			//static int first_flag = 1'b1;
			`uvm_info(get_type_name(),"run phase",UVM_HIGH)

			forever begin
				//if (!first_flag) begin
				vif.monitor(item);
				timer_analysis_port.write(item);
				//end else begin
				//@(vif.timer_cb);
				//first_flag=0;		
			end
		endtask : run_phase
	
	endclass : timer_monitor
`endif