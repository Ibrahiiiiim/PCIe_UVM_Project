`ifndef TX_MONITOR_SV
	`define TX_MONITOR_SV
	class tx_monitor#(Block block) extends uvm_monitor;

		virtual tx_if vif;

		tx_sequence_item item;

		uvm_analysis_port#(tx_sequence_item) tx_analysis_port;
	
		`uvm_component_param_utils(tx_monitor#(block))
	
		function new(string name = "tx_monitor", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
			tx_analysis_port = new("tx_analysis_port",this);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			`uvm_info(get_type_item(),"build_phase",UVM_HIGH)

			if (!uvm_config_db#(virtual tx_if)::get(this,"","tx_vif",vif)) begin
				`uvm_error("NOVIF",{"virtual interface must be set for :",get_full_name(),".vif"})
			end
		endfunction : build_phase

    task run_phase(uvm_phase phase);
        //static bit first_flag = 1'b1;
        `uvm_info(get_type_name, "run phase", UVM_HIGH)
        forever begin
            //if (!first_flag) begin
			
			item = tx_sequence_item::type_id::create("item");

            vif.monitor(item, block);
            tx_analysis_port.write(item);
        end
            /*else begin
                @ (vif.OS_Decoder_cb);
                first_flag = 1'b0;
            end*/
        //end
    endtask: run_phase

	
	endclass : tx_monitor
`endif