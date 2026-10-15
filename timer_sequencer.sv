`ifndef TIMER_SEQUENCER_SV
	`define TIMER_SEQUENCER_SV
	class timer_sequencer extends uvm_sequencer#(timer_sequence_item);
	
		`uvm_component_utils(timer_sequencer)
	
	
		function new(string name = "timer_sequencer", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_name(),"constructor",UVM_HIGH)
		endfunction : new
	
	endclass : timer_sequencer
`endif