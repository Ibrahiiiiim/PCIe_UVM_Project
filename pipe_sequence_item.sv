`ifndef PIPE_SEQUENCE_ITEM_SV
	`define PIPE_SEQUENCE_ITEM_SV
	class pipe_sequence_item extends uvm_sequence_item;

		 typedef enum {Detect_Quiet, Detect_Active, Polling_Active, Polling_configuration,
    	Config_Linkwidth_start, Config_Linkwidth_Accept, Config_Lanenum_wait, Config_Lanenum_Accept,
    	Config_complete, Config_idle, L0} state;
		
		//ltssm input
		logic [4:0] i_LTSSMState;
		//ltssm outputs 
		logic o_LTSSM_UpLink;
		logic o_LTSSM_RxElecIdle;
		logic o_LTSSM_LaneDetected;

		//phy outputs
		logic o_TxDetectRx_loopback;
		logic o_TxElecIdle;
		logic o_TxCompliance;
		logic o_RxPolarity;
		logic [1:0] o_PowerDown;
		logic [1:0] o_Rate;

		//phy inputs
		logic i_PhyStatus;
		logic i_RxElecIdle;
		logic [2:0] i_RxStatus;

		`uvm_object_utils(pipe_sequence_item)
		
		function new(string name = "pipe_sequence_item");
			super.new(name);
			`uvm_info(name,"constructor",UVM_HIGH)
		endfunction : new

		function void display_in(input string name="",input Block block);
			if (block == FSM) begin
				`uvm_info(name,$sformatf("\nPIPE - FSM Transaction input data :\n o_LTSSM_LaneDetected = %0b ,o_LTSSM_UpLink = %0b ,o_LTSSM_RxElecIdle = %0b",
					o_LTSSM_LaneDetected,o_LTSSM_Uplink,o_LTSSM_RxElecIdel),UVM_MEDIUM)
			end
			`uvm_info(name, $sformatf("\nPHY - PIPE Transaction Data:\no_TxDetectRx_Loopback = %0b, o_TxElecIdle = %0b, o_TxCompliance = %0b, o_RxPolarity = %0b, \no_PowerDown = %0d, o_Rate = %0b",
             o_TxDetectRx_Loopback, o_TxElecIdle, o_TxCompliance, o_RxPolarity, o_PowerDown, o_Rate),
             UVM_MEDIUM)
		endfunction : display_in

		function void display_out(input string name="",input int block=0);
			if (block==FSM) begin
				`uvm_info(name,$sformatf("\nFSM - PIPE Transaction output data:\ni_LTSSMState = %0b,current state=%0p",
					i_LTSSMState,state'(i_LTSSMState)),UVM_MEDIUM)
			end
			else if(block == PHY) begin
            	`uvm_info(name, $sformatf("\nPIPE - PHY Transaction Data:\ni_PhyStatus = %0b, i_RxElecIdle = %0b, i_RXstatus = %0b",
             	i_PhyStatus, i_RxElecIdle, i_RXstatus),UVM_MEDIUM)
        	end
		endfunction : display_out

	endclass : pipe_sequence_item
`endif