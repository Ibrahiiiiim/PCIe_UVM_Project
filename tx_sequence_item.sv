`ifn`ifndef TX_SEQUENCE_ITEM_SV
	`define TX_SEQUENCE_ITEM_SV
	class tx_sequence_item extends uvm_sequence_item;
	
		//inputs form fsm
		logic L0;
		// inputs from oscreator
		logic [15:0] i_OsBuffer_Data;
		logic i_OsBuffer_WrEn;

		// outputs to oscreator
		logic o_OsBuffer_full;


		`uvm_object_utils(tx_sequence_item)
	
		function new(string name = "tx_sequence_item");
			super.new(name);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new
	

		function void display_in(input string name="",input Block block);
			if (block == Creator) begin
				`uvm_info(name,$sformatf("\nCreator - TX transaction input data :\no_OsBuffer_full = %0b",
				o_OsBuffer_full	),UVM_MEDIUM)
			end else if (block == FSM) begin
				
			end else
				`uvm_error("TX interface","Invalid Block")
		endfunction : display_in

		function void display_out(inputs string name="",input Block block);
			if (block == Creator) begin
				`uvm_info(name,
                    $sformatf("\nTX - Creator transaction Output Data:\ni_OsBuffer_Data = %0h,i_OsBuffer_WrEn = %0b",i_OsBuffer_Data,i_OsBuffer_WrEn),
                    UVM_MEDIUM)
			end else if (block == FSM) begin
				`uvm_info(name,
                    $sformatf("\nTX - FSM transaction Output:\n DataL0 = %0b",
                    L0),
                    UVM_MEDIUM)
			end
		endfunction : display_out
	endclass : tx_sequence_item
`endif