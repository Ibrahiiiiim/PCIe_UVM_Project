`ifndef PCIE_PHY_IF_SV
	`define PCIE_PHY_IF_SV
	interface pcie_phy_if(input logic clk);

		// inputs from pipe
		logic o_TxDetectRx_loopback;
		logic o_TxElecIdle;
	endinterface : pcie_phy_if
`endif