`ifndef TIMER_DRIVER_SV
	`define TIMER_DRIVER_SV
	class timer_driver extends uvm_driver#(timer_sequence_item);
	
		virtual timer_if vif;

		`uvm_component_utils(timer_driver)
	
		function new(string name = "timer_driver", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_name(),"constructor",UVM_HIGH)
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info(get_type_name(),"build phase",UVM_HIGH)
			if (!uvm_config_db#(virtual timer_if)::get(this, "", "timer_vif",vif )) begin
				`uvm_error("NOVIF",{"virtual interface must be set for :",get_full_name(),".vif"})
			end
		endfunction : build_phase

		task run_phase(uvm_phase phase);
		`uvm_info(get_type_name(),"run phase",UVM_HIGH)
			forever begin
				seq_item_port.get_next_item(req);
				vif.driver(req);
				seq_item_port.item_done();
			end
		endtask : run_phase
	
	endclass : timer_driver
`endif