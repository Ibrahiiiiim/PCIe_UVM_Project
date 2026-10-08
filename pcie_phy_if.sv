`ifndef PCIE_PHY_IF_SV
	`define PCIE_PHY_IF_SV
	interface pcie_phy_if(input logic clk);

		// inputs from pipe
		logic o_TxDetectRx_loopback;
		logic o_TxElecIdle;
		logic o_TxCompliance;
		logic o_RxPolarity;
		logic [1:0] o_PowerDown;
		logic [1:0] o_Rate;

		// outputs to pipe

		logic i_PhyStatus;
		logic i_RxElecIdle;
		logic [2:0] i_RxStatus;

		clocking PHY_cb @(posedge i_clk);
			default input #1step output #1step;
			input o_TxDetectRx_loopback;
			input o_TxElecIdle;
			input o_TxCompliance;
			input o_RxPolarity;
			input [1:0] o_PowerDown;
			input [1:0] o_Rate;
			inout i_PhyStatus;
			inout i_RxElecIdle;
			inout [2:0] i_RxStatus;
		endclocking

		function void display_in(string name);
			$display("------------------------------------------------------------------------------------------");
			`uvm_info(name,$sformatf("\nPHY - PIPE interface input data :\ni_PhyStatus = %b ,i_RxElecIdle = %b, i_RxStatus = %b\n",i_PhyStatus,i_RxElecIdle, i_RxStatus),
			UVM_MEDIUM)
		endfunction : display_in

		task drive();
			
		endtask : drive

		task automatic monitor();
			
		endtask : monitor

	endinterface : pcie_phy_if
`endif