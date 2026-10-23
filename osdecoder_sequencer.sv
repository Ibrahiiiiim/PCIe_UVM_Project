`ifndef OSDECODER_SEQUENCER_SV
	`define OSDECODER_SEQUENCER_SV
	class osdecoder_sequencer extends uvm_sequencer#(osdecoder_sequence_item);
	
		`uvm_component_utils(osdecoder_sequencer)
	
	
		function new(string name = "osdecoder_sequencer", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new
	
	endclass : osdecoder_sequencer
`endif