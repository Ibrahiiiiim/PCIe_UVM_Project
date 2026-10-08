`include "pcie_tests_pkg.sv"
`define CYCLE 10
module testbench;
	import uvm_pkg::*;
	import pcie_tests_pkg::*;
	
	bit i_clk;

	always #(`CYCLE/2) i_clk <= ~clk;

	pcie_phy_if phy_if(i_clk);
	pcie_fsm_if fsm_if(i_clk,i_resetn);

	initial begin
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
endmodule : testbench