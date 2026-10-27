`include "pcie_tests_pkg.sv"
`define CYCLE 10
module testbench;
	import uvm_pkg::*;
	import pcie_tests_pkg::*;
	
	bit i_clk;

	always #(`CYCLE/2) i_clk <= ~i_clk;

	pcie_phy_if phy_if(i_clk);
	pcie_fsm_if fsm_if(i_clk,i_resetn);
	pipe_if pipe_if (i_clk);
	timer_if timer_if (i_clk,i_resetn);
	os_decoder_if osdecoder_if(i_clk,i_resetn);
	os_creator_if oscreator_if(i_clk,i_resetn);

	initial begin
		uvm_config_db#(virtual pipe_if)::set(null, "uvm_test_top", "pipe_vif",pipe_if );
		uvm_config_db#(virtual timer_if)::set(null, "uvm_test_top", "timer_vif",timer_if );
		uvm_config_db#(virtual os_decoder_if)::set(null, "uvm_test_top", "os_decoder_vif",osdecoder_if );
		uvm_config_db#(virtual os_decoder_if)::set(null, "uvm_test_top", "os_creator_vif",oscreator_if );
		run_test("");
	end

	pcie_LTSSM_pipeOperationBlock PIPE_DUT(
 		.i_PhyStatus          (phy_if.i_PhyStatus),
 		.i_RxElecIdle(phy_if.i_RxElecIdle),
 		.i_RXstatus           (phy_if.i_RXstatus),
 		.o_TxDetectRx_Loopback(phy_if.o_TxDetectRx_Loopback),
 		.o_TxElecIdle         (phy_if.o_TxElecIdle),
 		.o_TxCompliance       (phy_if.o_TxCompliance),
 		.o_RxPolarity         (phy_if.o_RxPolarity),
 		.o_PowerDown          (phy_if.o_PowerDown),
 		.o_Rate               (phy_if.o_Rate),
 		.i_LTSSMState         (fsm_if.i_LTSSMState),
 		.o_LTSSM_LaneDetected (fsm_if.o_LTSSM_LaneDetected),
 		.o_LTSSM_UpLink       (fsm_if.o_LTSSM_UpLink),
 		.o_LTSSM_RxElecIdle   (fsm_if.o_LTSSM_RxElecIdle)
 	);

 	pcie_LTSSM_stateMachine FSM_DUT(
		//pipe
		.i_PCLK(i_clk),
 		.o_LTSSM_state             (pipe_if.i_LTSSM_state),
 		.i_PHY_laneDetected(pipe_if.o_LTSSM_LaneDetected),
 		.i_PHY_RxElecIdle(pipe_if.o_LTSSM_RxElecIdle)
 		//timer
 		.i_timer_timeout           (timer_if.o_time_out),
 		.o_timer_timeoutValue      (timer_if.i_time_out_Value),
 		.o_timer_start             (timer_if.i_start),
 		//os_decoder
 		.i_OSdecoder_Ack           (osdecoder_if.o_OSdecoder_Ack),
 		.i_OSdecoder_Link          (osdecoder_if.o_OSdecoder_Link),
 		.i_OSdecoder_Lane          (osdecoder_if.o_OSdecoder_Lane),
 		//os_creator
 		.i_OScreator_Ack           (oscreator_if.o_OScreator_Ack),
 		.o_OScreator_Symbol0       (oscreator_if.i_OScreatorSymbol0),
 		.o_OScreator_Symbol1       (oscreator_if.i_OScreatorSymbol1),
 		.o_OScreator_Symbol2       (oscreator_if.i_OScreatorSymbol2),
 		.o_OScreator_Symbol3       (oscreator_if.i_OScreatorSymbol3),
 		.o_OScreator_Symbol4       (oscreator_if.i_OScreatorSymbol4),
 		.o_OScreator_Symbol5       (oscreator_if.i_OScreatorSymbol5),
 		.o_OScreator_Symbol6       (oscreator_if.i_OScreatorSymbol6),
 		.o_OScreator_Symbol7       (oscreator_if.i_OScreatorSymbol7),
 		.o_OScreator_Symbol8       (oscreator_if.i_OScreatorSymbol8),
 		.o_OScreator_Symbol9       (oscreator_if.i_OScreatorSymbol9),
 		.o_OScreator_Symbol10       (oscreator_if.i_OScreatorSymbol10),
 		.o_OScreator_Symbol11       (oscreator_if.i_OScreatorSymbol11),
 		.o_OScreator_Symbol12       (oscreator_if.i_OScreatorSymbol12),
 		.o_OScreator_Symbol13       (oscreator_if.i_OScreatorSymbol13),
 		.o_OScreator_Symbol14       (oscreator_if.i_OScreatorSymbol14),
 		.o_OScreator_Symbol15       (oscreator_if.i_OScreatorSymbol15),
 		.o_LTSSM_stateChange       (oscreator_if.i_LTSSM_stateChange),
 		.o_OScreator_reqNum        (oscreator_if.i_OSreqNum),
 		.o_OScreator_resetTScounter(oscreator_if.i_reset_TS_count),
 		.o_OScreator_enable        (oscreator_if.i_enable),
 		.o_OScreator_types         (oscreator_if.i_OScreatorTypes),
 	);
endmodule : testbench