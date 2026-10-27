`ifndef OS_CREATOR_IF_SV
	`define OS_CREATOR_IF_SV
	interface os_creator_if (input logic i_clk,ref logic i_resetn);
		
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


		clocking os_creator_cb @(posedge i_clk);
			default input #1step output #1step;
			inout o_OScreator_Ack,o_OScreator_Data,o_OScreator_Valid;
			input i_enable,i_LTSSM_stateChange,i_reset_TS_count,i_OSreqNum,i_OScreatorTypes,
			i_OScreatorSymbol0,i_OScreatorSymbol1,i_OScreatorSymbol2,i_OScreatorSymbol3,i_OScreatorSymbol4,
			i_OScreatorSymbol5,i_OScreatorSymbol6,i_OScreatorSymbol7,i_OScreatorSymbol8,i_OScreatorSymbol9,
			i_OScreatorSymbol10,i_OScreatorSymbol11,i_OScreatorSymbol12,
			i_OScreatorSymbol13,i_OScreatorSymbol14,i_OScreatorSymbol15,i_Tx_OSbufferFull;
		endclocking

		function void display_in(input string name="",input Block block);
			if (block == FSM) begin
				`uvm_info(name,$sformatf("\nFSM - OScreator interface input data :\no_OScreator_Ack = %0b",
				o_OScreator_Ack	),UVM_MEDIUM)
			end else if (block == TX) begin
				`uvm_info(name,$sformatf("\nTX - OScreator interface input data :\no_OScreator_Data = %0h, o_OScreator_Valid = %0b",
				o_OScreator_Data,o_OScreator_Valid),UVM_MEDIUM)
			end
		endfunction : display_in

		function void display_out(inputs string name="",input Block block);
			if (block == FSM) begin
				`uvm_info(name,
                    $sformatf("\nFSM - OS_Creator Interface Output Data:\ni_LTSSM_stateChange = %0b, i_OScreatorSymbol0 = %0h, i_OScreatorSymbol1 = %0h, \ni_OScreatorSymbol2 = %0h, i_OScreatorSymbol3 = %0h, i_OScreatorSymbol4 = %0h, \ni_OScreatorSymbol5 = %0h, i_OScreatorSymbol6 = %0h, i_OScreatorSymbol7 = %0h, \ni_OScreatorSymbol8 = %0h, i_OScreatorSymbol9 = %0h, i_OScreatorSymbol10 = %0h, \ni_OScreatorSymbol11 = %0h, i_OScreatorSymbol12 = %0h, i_OScreatorSymbol13 = %0h, \ni_OScreatorSymbol14 = %0h, i_OScreatorSymbol15 = %0h, i_OScreatorTypes = %0h, \ni_OSreqNum = %0h, i_enable = %0b, i_reset_TS_count = %0b",
                    i_LTSSM_stateChange, i_OScreatorSymbol0, i_OScreatorSymbol1, i_OScreatorSymbol2, i_OScreatorSymbol3, i_OScreatorSymbol4,
                    i_OScreatorSymbol5, i_OScreatorSymbol6, i_OScreatorSymbol7, i_OScreatorSymbol8, i_OScreatorSymbol9, i_OScreatorSymbol10, i_OScreatorSymbol11,
                    i_OScreatorSymbol12, i_OScreatorSymbol13, i_OScreatorSymbol14, i_OScreatorSymbol15, i_OScreatorTypes, i_OSreqNum, i_enable, i_reset_TS_count),
                    UVM_MEDIUM)
			end else if (block == TX) begin
				`uvm_info(name,
                    $sformatf("\nTx - OS_Creator Interface Data:\ni_Tx_OSbufferFull = %0b",
                    i_Tx_OSbufferFull),
                    UVM_MEDIUM)
			end
		endfunction : display_out

		task drive(input oscreator_sequence_item s1,input Block block);
			@(os_creator_cb);
			if (block == FSM) begin
				os_creator_cb.o_OScreator_Ack <= s1.o_OScreator_Ack;
				#1step;
				`ifdef DEBUG
				display_in("FSM/OScreator driver",block);
				`endif
			end else if (block == TX) begin
				os_creator_cb.o_OScreator_Data <= s1.o_OScreator_Data;
				os_creator_cb.o_OScreator_Valid <= s1.o_OScreator_Valid;
				#1step;
				`ifdef DEBUG
				display_in("TX/OScreator driver",block);
				`endif
			end
		endtask : drive

		task automatic monitor(input oscreator_sequence_item s1,input Block block);
			@(os_creator_cb);
			if (block == FSM) begin
				s1.o_OScreator_Ack = os_creator_cb.o_OScreator_Ack;
				s1.i_OScreatorSymbol0 = os_creator_cb.i_OScreatorSymbol0;
				s1.i_OScreatorSymbol1 = os_creator_cb.i_OScreatorSymbol1;
				s1.i_OScreatorSymbol2 = os_creator_cb.i_OScreatorSymbol2;
				s1.i_OScreatorSymbol3 = os_creator_cb.i_OScreatorSymbol3;
				s1.i_OScreatorSymbol4 = os_creator_cb.i_OScreatorSymbol4;
				s1.i_OScreatorSymbol5 = os_creator_cb.i_OScreatorSymbol5;
				s1.i_OScreatorSymbol6 = os_creator_cb.i_OScreatorSymbol6;
				s1.i_OScreatorSymbol7 = os_creator_cb.i_OScreatorSymbol7;
				s1.i_OScreatorSymbol8 = os_creator_cb.i_OScreatorSymbol8;
				s1.i_OScreatorSymbol9 = os_creator_cb.i_OScreatorSymbol9;
				s1.i_OScreatorSymbol10 = os_creator_cb.i_OScreatorSymbol10;
				s1.i_OScreatorSymbol11 = os_creator_cb.i_OScreatorSymbol11;
				s1.i_OScreatorSymbol12 = os_creator_cb.i_OScreatorSymbol12;
				s1.i_OScreatorSymbol13 = os_creator_cb.i_OScreatorSymbol13;
				s1.i_OScreatorSymbol14 = os_creator_cb.i_OScreatorSymbol14;
				s1.i_OScreatorSymbol15 = os_creator_cb.i_OScreatorSymbol15;
				s1.i_enable = os_creator_cb.i_enable;
				s1.i_LTSSM_stateChange = os_creator_cb.i_LTSSM_stateChange;
				s1.i_reset_TS_count = os_creator_cb.i_reset_TS_count;
				s1.i_OSreqNum = os_creator_cb.i_OSreqNum;
				s1.i_OScreatorTypes = os_creator_cb.i_OScreatorTypes;
				`ifdef DEBUG
            	s1.display_in("FSM/OS_Creator Monitor", block);
            	s1.display_out("FSM/OS_Creator Monitor", block);
            	`endif
			end else if (block == TX) begin
				s1.o_OScreator_Data = os_creator_cb.o_OScreator_Data;
				s1.o_OScreator_Valid = os_creator_cb.o_OScreator_Valid;
				s1.i_Tx_OSbufferFull = os_creator_cb.i_Tx_OSbufferFull;
				`ifdef DEBUG
            	s1.display_in("Tx/OS_Creator Monitor", block);
            	s1.display_out("Tx/OS_Creator Monitor", block);
            	`endif
			end
		endtask : monitor

	endinterface : os_creator_if
`endif