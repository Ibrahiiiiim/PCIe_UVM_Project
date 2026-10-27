`ifndef OSCREATOR_SEQUENCER_SV
	`define OSCREATOR_SEQUENCER_SV
	class oscreator_sequencer extends uvm_sequencer#(oscreator_sequence_item);
	
		`uvm_component_utils(oscreator_sequencer)
	
	
		function new(string name = "oscreator_sequencer", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new
	
	endclass : oscreator_sequencer
`endif