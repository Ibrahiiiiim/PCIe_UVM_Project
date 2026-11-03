`ifndef TX_SEQUENCER_SV
	`define TX_SEQUENCER_SV
	class tx_sequencer extends uvm_sequencer#(tx_sequence_item);
	
		`uvm_component_utils(tx_sequencer)
	
	
		function new(string name = "tx_sequencer", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new
	
	endclass : tx_sequencer
`endif