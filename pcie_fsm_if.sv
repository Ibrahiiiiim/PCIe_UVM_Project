`ifndef PCIE_FSM_IF_SV
	`define PCIE_FSM_IF_SV

	interface pcie_fsm_if (input logic clk,ref logic i_reset_n);//interface pcie_fsm_if (/*input logic clk,       // Only READ (sampled by assertions/clocking blocks)ref   logic i_reset_n  // READ AND/OR DRIVEN by verification tasks);*/
		
		//outputs to pipe

		logic [4:0] o_LTSSMState;

		//inputs from pipe
		
		logic i_LTSSM_UpLink;
		logic i_RXElecIdle;
		logic i_LTSSM_LaneDetected;

		clocking FCM_cb @(posedge i_clk);
			default input #1step output #1step;
			inout o_LTSSMState ;
			input i_LTSSM_UpLink,i_RXElecIdle,i_LTSSM_LaneDetected;
		endclocking


		task driver();
			
		endtask : driver


		task automatic monitor();
			
		endtask : monitor
		
	endinterface : pcie_fsm_if
`endif