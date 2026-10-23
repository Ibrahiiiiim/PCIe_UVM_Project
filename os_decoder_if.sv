`ifndef OS_DECODER_IF_SV
	`define OS_DECODER_IF_SV
	interface os_decoder_if (input logic i_clk,ref logic i_resetn);
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
		logic [1:0] o_OSdecoder_Ack;
		logic [7:0] o_OSdecoder_Lane,o_OSdecoder_Link;

		clocking cb @(posedge i_clk);
			default input #1step output #1step;
			input i_LTSSM_state,i_LTSSM_stateChange,i_LTSSM_UpDown,i_Rx_Data,i_Rx_DataK,i_Rx_valid,i_Rx_COM_Indicator;
			inout o_OSdecoder_Ack,o_OSdecoder_Lane,o_OSdecoder_Link;
		endclocking

		function void display_in(input string name="",input Block block);
			if (block==FSM) begin
				`uvm_info(name,$sformatf("\nFSM - OSdecoder interface input data:\n o_OSdecoder_Lane = %0d ,o_OSdecoder_Link = %d ,o_OSdecoder_Ack = %0b ",
				o_OSdecoder_Lane,o_OSdecoder_Link,o_OSdecoder_Ack),UVM_MEDIUM)
			end
		endfunction : display_in

		function void display_out(input string name="",input Block block);
			if (block==FSM) begin
				`uvm_info(name,$sformatf("\nFSM - OSdecoder interface output data:\n i_LTSSM_UpDown = %0b ,i_LTSSM_state = %0d ,current_state = %0p i_LTSSM_stateChange = %0b ",
				i_LTSSM_UpDown,i_LTSSM_state,state'(i_LTSSM_state),i_LTSSM_stateChange),UVM_MEDIUM)
			end else if(block == Rx) begin
            `uvm_info(name, $sformatf("\nRx - OS_Decoder Interface Data:\ni_Rx_Data = %0d, i_Rx_valid = %0b, i_Rx_DataK = %0b, i_Rx_COM_Indicator = %0b",
             i_Rx_Data, i_Rx_valid, i_Rx_DataK, i_Rx_COM_Indicator),
             UVM_MEDIUM)
        end
		endfunction : display_out

		task drive();
			
		endtask : drive

		task automatic monitor();
			
		endtask : monitor

	endinterface : os_decoder_if
`endif