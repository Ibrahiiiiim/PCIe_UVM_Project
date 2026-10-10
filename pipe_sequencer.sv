`ifndef PIPE_SEQUENCER_SV
	`define PIPE_SEQUENCER_SV
	class pipe_sequencer extends uvm_sequencer#(pipe_sequence_item);
	
		`uvm_component_utils(pipe_sequencer)
	
		function new(string name = "pipe_sequencer", uvm_component parent=null);
			super.new(name, parent);
		endfunction : new
	
	endclass : pipe_sequencer
`endif