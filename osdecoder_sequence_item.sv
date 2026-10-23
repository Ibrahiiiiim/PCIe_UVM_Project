`ifndef OSDECODER_SEQUENCE_ITEM_SV
	`define OSDECODER_SEQUENCE_ITEM_SV
	class osdecoder_sequence_item extends uvm_sequence_item;
	

		typedef enum {Detect_Quiet, Detect_Active, Polling_Active, Polling_configuration,
        Config_Linkwidth_start, Config_Linkwidth_Accept, Config_Lanenum_wait, Config_Lanenum_Accept,
        Config_complete, Config_idle, L0} state;
		
		//Rx inputs
		logic [15:0] i_Rx_Data;
		logic [1:0] i_Rx_DataK;
		logic [1:0] i_Rx_valid;
		logic [1:0] i_Rx_COM_Indicator;
		//LTSSM inputs 
		logic [4:0] i_LTSSM_state;
		logic i_LTSSM_stateChange;
		logic i_LTSSM_UpDown;
		//LTSSM outputs
		randc logic [1:0] o_OSdecoder_Ack;
		logic [7:0] o_OSdecoder_Lane,o_OSdecoder_Link;
		
		`uvm_object_utils(osdecoder_sequence_item)
	
		function new(string name = "osdecoder_sequence_item");
			super.new(name);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new

		function void display_in(input string name="",input Block block);
			if (block==FSM) begin
				`uvm_info(name,$sformatf("\nFSM - OSdecoder transaction input data:\n o_OSdecoder_Lane = %0d ,o_OSdecoder_Link = %d ,o_OSdecoder_Ack = %0b ",
				o_OSdecoder_Lane,o_OSdecoder_Link,o_OSdecoder_Ack),UVM_MEDIUM)
			end
		endfunction : display_in

		function void display_out(input string name="",input Block block = 0);
			if (block==FSM) begin
				`uvm_info(name,$sformatf("\nFSM - OSdecoder transaction output data:\n i_LTSSM_UpDown = %0b ,i_LTSSM_state = %0d ,current_state = %0p i_LTSSM_stateChange = %0b ",
				i_LTSSM_UpDown,i_LTSSM_state,state'(i_LTSSM_state),i_LTSSM_stateChange),UVM_MEDIUM)
			end else if(block == Rx) begin
            `uvm_info(name, $sformatf("\nRx - OS_Decoder transaction Data:\ni_Rx_Data = %0d, i_Rx_valid = %0b, i_Rx_DataK = %0b, i_Rx_COM_Indicator = %0b",
             i_Rx_Data, i_Rx_valid, i_Rx_DataK, i_Rx_COM_Indicator),
             UVM_MEDIUM)
        end
		endfunction : display_out
	
	endclass : osdecoder_sequence_item
`endif