`ifndef OSCREATOR_MONITOR_SV
	`define OSCREATOR_MONITOR_SV
	class oscreator_monitor#(Block block) extends uvm_monitor;

		virtual os_creator_if vif;

		oscreator_sequence_item item;

		uvm_analysis_port#(oscreator_sequence_item) oscreator_analysis_port;
	
		`uvm_component_param_utils(oscreator_monitor#(block))
	
		function new(string name = "oscreator_monitor", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
			oscreator_analysis_port = new("oscreator_analysis_port",this);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			`uvm_info(get_type_item(),"build_phase",UVM_HIGH)

			if (!uvm_config_db#(virtual os_creator_if)::get(this,"","os_creator_vif",vif)) begin
				`uvm_error("NOVIF",{"virtual interface must be set for :",get_full_name(),".vif"})
			end
		endfunction : build_phase

    task run_phase(uvm_phase phase);
        //static bit first_flag = 1'b1;
        `uvm_info(get_type_name, "run phase", UVM_HIGH)
        forever begin
            //if (!first_flag) begin
			
			item = oscreator_sequence_item::type_id::create("item");

            vif.monitor(item, block);
            oscreator_analysis_port.write(item);
        end
            /*else begin
                @ (vif.OS_Decoder_cb);
                first_flag = 1'b0;
            end*/
        //end
    endtask: run_phase

	
	endclass : oscreator_monitor
`endif