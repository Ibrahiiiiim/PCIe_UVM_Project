`ifndef TIMER_IF_SV
	`define TIMER_IF_SV
	interface timer_if (input logic i_clk,ref logic i_resetn );
		//fsm inputs
		logic [22:0]i_time_out_value;
		logic i_start;

		//fsm outputs
		logic o_time_out;

		clocking timer_cb;
			default input #1step output #1step;
			input i_time_out_value,i_start;
			inout o_time_out,i_resetn;
		endclocking

		function void display_in(input string name ="");
			`uvm_info(name,$sformatf("\nFSM - TIMER Interface input data:\no_time_out = %0b ",o_time_out),UVM_MEDIUM)
		endfunction : display_in

		function void display_out(input string name = "");
			`uvm_info(name,$sformatf("\nFSM - TIMER Interface output data:\ni_time_out_value = %0d,i_start = %0b ",i_time_out_value,o_time_out),UVM_MEDIUM)		
		endfunction : display_out

		task driver();
			
		endtask : driver

		task automatic monitor();
			
		endtask : monitor
	endinterface : timer_if
`endif