`ifndef TIMER_SEQUENCE_ITEM_SV
	`define TIMER_SEQUENCE_ITEM_SV 
	class timer_sequence_item extends uvm_sequence_item;
	
		
		logic [22:0]i_time_out_value;
		logic i_start;

		
		logic o_time_out;

		`uvm_object_utils(timer_sequence_item)
	
		function new(string name = "timer_sequence_item");
			super.new(name);
			`uvm_info(get_type_name(),"constructor",UVM_HIGH)
		endfunction : new

		function void display_in(input string name="");
			`uvm_info(name,$sformatf("\nFSM - TIMER input data :\no_time_out = %0b",o_time_out),UVM_MEDIUM)
		endfunction : display_in

		function void display_out();
			`uvm_info(name,$sformatf("\nFSM - TIMER output data :\ni_time_out_value = %0d , i_start = %0b",
			i_time_out_value,i_start),UVM_MEDIUM)
		endfunction : display_out
	
	endclass : timer_sequence_item
`endif