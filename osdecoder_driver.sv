`ifndef OSDECODER_DRIVER_SV
	`define OSDECODER_DRIVER_SV
	class osdecoder_driver#(Block block) extends uvm_driver;
	
		virtual os_decoder_if vif;

		`uvm_component_param_utils(osdecoder_driver#(block))
	
		function new(string name = "osdecoder_driver", uvm_component parent=null);
			super.new(name, parent);
			`uvm_info(get_type_item(),"constructor",UVM_HIGH)
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			`uvm_info(get_type_item(),"build_phase",UVM_HIGH)

			if (!uvm_config_db#(virtual os_decoder_if)::get(this,"","os_decoder_vif",vif)) begin
				`uvm_error("NOVIF",{"virtual interface must be set for :",get_full_name(),".vif"})
			end
		endfunction : build_phase

		task run_phase(uvm_phase phase);

			`uvm_info(get_type_item(),"run phase",UVM_HIGH)

			forever begin
				seq_item_port.get_next_item(req);
				vif.drive(req,block);
				seq_item_port.item_done();
			end
		endtask : run_phase
	
	endclass : osdecoder_driver
`endif