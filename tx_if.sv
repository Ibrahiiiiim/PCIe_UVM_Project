`ifndef TX_IF_SV
	`define TX_IF_SV
	interface tx_if (input logic i_clk,ref logic i_resetn);
		//inputs form fsm
		logic L0;
		// inputs from creator
		logic [15:0] i_OsBuffer_Data;
		logic i_OsBuffer_WrEn;

		// outputs to creator
		logic o_OsBuffer_full;

		clocking tx_cb @ (posedge i_clk);
			default input #1step output #1step;
			input L0,i_OsBuffer_Data,i_OsBuffer_WrEn;
			inout o_OsBuffer_full;
		endclocking

		task drive(input Block block);
			if (block == Creator) begin
				
			end 
			else if (block == FSM) begin
				
			end
		endtask : drive

		task automatic monitor(input Block block);
			if (block == Creator) begin
				
			end 
			else if (block == FSM) begin
				
			end
		endtask : monitor

	endinterface : tx_if
`endif