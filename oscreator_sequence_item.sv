`ifndef OSCREATOR_SEQUENCE_ITEM_SV
	`define OSCREATOR_SEQUENCE_ITEM_SV
	class oscreator_sequence_item extends uvm_sequence_item;
	
		//input sginals from state machine
		logic i_enable;
		logic i_LTSSM_stateChange;
		logic i_reset_TS_count;
		logic [10:0] i_OSreqNum;
		logic [1:0] i_OScreatorTypes;
		logic [7:0] i_OScreatorSymbol0;
		logic [7:0] i_OScreatorSymbol1;
		logic [7:0] i_OScreatorSymbol2;
		logic [7:0] i_OScreatorSymbol3;
		logic [7:0] i_OScreatorSymbol4;
		logic [7:0] i_OScreatorSymbol5;
		logic [7:0] i_OScreatorSymbol6;
		logic [7:0] i_OScreatorSymbol7;
		logic [7:0] i_OScreatorSymbol8;
		logic [7:0] i_OScreatorSymbol9;
		logic [7:0] i_OScreatorSymbol10;
		logic [7:0] i_OScreatorSymbol11;
		logic [7:0] i_OScreatorSymbol12;
		logic [7:0] i_OScreatorSymbol13;
		logic [7:0] i_OScreatorSymbol14;
		logic [7:0] i_OScreatorSymbol15;

		//output signal to state machine
		logic o_OScreator_Ack;

		//input signals from transmitter

		logic i_Tx_OSbufferFull;

		//output signals to transmitter

		logic [15:0] o_OScreator_Data;
		logic o_OScreator_Valid;


		`uvm_object_utils(oscreator_sequence_item)
	
		function new(string name = "oscreator_sequence_item");
			super.new(name);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new
	

		function void display_in(input string name="",input Block block);
			if (block == FSM) begin
				`uvm_info(name,$sformatf("\nFSM - OScreator transaction input data :\no_OScreator_Ack = %0b",
				o_OScreator_Ack	),UVM_MEDIUM)
			end else if (block == TX) begin
				`uvm_info(name,$sformatf("\nTX - OScreator input data :\no_OScreator_Data = %0h, o_OScreator_Valid = %0b",
				o_OScreator_Data,o_OScreator_Valid),UVM_MEDIUM)
			end
		endfunction : display_in

		function void display_out(inputs string name="",input Block block);
			if (block == FSM) begin
				`uvm_info(name,
                    $sformatf("\nFSM - OS_Creator transaction Output Data:\ni_LTSSM_stateChange = %0b, i_OScreatorSymbol0 = %0h, i_OScreatorSymbol1 = %0h, \ni_OScreatorSymbol2 = %0h, i_OScreatorSymbol3 = %0h, i_OScreatorSymbol4 = %0h, \ni_OScreatorSymbol5 = %0h, i_OScreatorSymbol6 = %0h, i_OScreatorSymbol7 = %0h, \ni_OScreatorSymbol8 = %0h, i_OScreatorSymbol9 = %0h, i_OScreatorSymbol10 = %0h, \ni_OScreatorSymbol11 = %0h, i_OScreatorSymbol12 = %0h, i_OScreatorSymbol13 = %0h, \ni_OScreatorSymbol14 = %0h, i_OScreatorSymbol15 = %0h, i_OScreatorTypes = %0h, \ni_OSreqNum = %0h, i_enable = %0b, i_reset_TS_count = %0b",
                    i_LTSSM_stateChange, i_OScreatorSymbol0, i_OScreatorSymbol1, i_OScreatorSymbol2, i_OScreatorSymbol3, i_OScreatorSymbol4,
                    i_OScreatorSymbol5, i_OScreatorSymbol6, i_OScreatorSymbol7, i_OScreatorSymbol8, i_OScreatorSymbol9, i_OScreatorSymbol10, i_OScreatorSymbol11,
                    i_OScreatorSymbol12, i_OScreatorSymbol13, i_OScreatorSymbol14, i_OScreatorSymbol15, i_OScreatorTypes, i_OSreqNum, i_enable, i_reset_TS_count),
                    UVM_MEDIUM)
			end else if (block == TX) begin
				`uvm_info(name,
                    $sformatf("\nTx - OS_Creator Data:\ni_Tx_OSbufferFull = %0b",
                    i_Tx_OSbufferFull),
                    UVM_MEDIUM)
			end
		endfunction : display_out
	endclass : oscreator_sequence_item
`endif