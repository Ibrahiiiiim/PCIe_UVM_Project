`ifndef PIPE_IF_SV
	`define PIPE_IF_SV
	interface pipe_if;
		typedef enum {Detect_Quiet, Detect_Active, Polling_Active, Polling_configuration,
    	Config_Linkwidth_start, Config_Linkwidth_Accept, Config_Lanenum_wait, Config_Lanenum_Accept,
    	Config_complete, Config_idle, L0} state;
		
		//ltssm input
		logic [4:0] i_LTSSMState;
		//ltssm outputs 
		logic o_LTSSM_UpLink;
		logic o_LTSSM_RxElecIdle;
		logic o_LTSSM_LaneDetected;

		//phy outputs
		logic o_TxDetectRx_loopback;
		logic o_TxElecIdle;
		logic o_TxCompliance;
		logic o_RxPolarity;
		logic [1:0] o_PowerDown;
		logic [1:0] o_Rate;

		//phy inputs
		logic i_PhyStatus;
		logic i_RxElecIdle;
		logic [2:0] i_RxStatus;

		clocking pipe_cb @(i_clk);
			
			default input #1step output #1step;
			inout i_LTSSMState,o_LTSSM_UpLink,o_LTSSM_RxElecIdle,o_LTSSM_LaneDetected,
			o_TxDetectRx_loopback,o_TxElecIdle,o_TxCompliance,o_RxPolarity,o_PowerDown,o_Rate,i_PhyStatus,i_RxElecIdle,i_RxStatus;

		endclocking

		function void display_in(input string name="",input Block block);
			if (block == FSM) begin
				`uvm_info(name,$sformatf("\nFSM - PIPE interface input data :\n o_LTSSM_LaneDetected = %0b ,o_LTSSM_UpLink = %0b ,o_LTSSM_RxElecIdle = %0b",
					o_LTSSM_LaneDetected,o_LTSSM_Uplink,o_LTSSM_RxElecIdle),UVM_MEDIUM)
			end
			else if(block==PHY)
			`uvm_info(name, $sformatf("\nPHY - PIPE interface input data:\no_TxDetectRx_Loopback = %0b, o_TxElecIdle = %0b, o_TxCompliance = %0b, o_RxPolarity = %0b, \no_PowerDown = %0d, o_Rate = %0b",
             o_TxDetectRx_Loopback, o_TxElecIdle, o_TxCompliance, o_RxPolarity, o_PowerDown, o_Rate),
             UVM_MEDIUM)
		endfunction : display_in

		function void display_out(input string name="",input int block=0);
			if (block==FSM) begin
				`uvm_info(name,$sformatf("\nFSM - PIPE interface output data:\ni_LTSSMState = %0b,current state=%0p",
					i_LTSSMState,state'(i_LTSSMState)),UVM_MEDIUM)
			end
			else if(block == PHY) begin
            	`uvm_info(name, $sformatf("\nPHY - PIPE interface Data:\ni_PhyStatus = %0b, i_RxElecIdle = %0b, i_RXstatus = %0b",
             	i_PhyStatus, i_RxElecIdle, i_RXstatus),UVM_MEDIUM)
        	end
		endfunction : display_out


		task drive(input pipe_sequence_item s1,input Block block);
			@(pipe_cb);
			if (block == FSM) begin
				pipe_cb.o_LTSSM_LaneDetected <= s1.o_LTSSM_LaneDetected;
				pipe_cb.o_LTSSM_UpLink <= s1.o_LTSSM_UpLink;
				pipe_cb.o_LTSSM_RxElecIdle <= s1.o_LTSSM_RxElecIdle;
			end
			`ifdef DEBUG
			#1step;
			$display_in("FSM/PIPE Driver",block);
			`endif
		endtask : drive
		
		task automatic monitor();
			
		endtask : monitor
		
	endinterface : pipe_if
`endif
/*
some notes:-
ifdef DEBUG ... `endif (Conditional Compilation)
Printing text to the simulation console ($display / uvm_info) slows down simulation significantly.
By wrapping this in `ifdef DEBUG, this code is completely ignored and not compiled during normal, fast test runs.
It will only run if you pass +define+DEBUG in your simulator command line when you need to troubleshoot.

Notice the <= (non-blocking drive) to the clocking block.
In SystemVerilog, non-blocking assignments do not take effect immediately in the current moment; they are scheduled to update in the NBA region.
Without #1step;: If you call display_in() immediately on the next line, the simulator will print the old, previous value of the signals because the assignment hasn't committed yet!
With #1step;: It forces a tiny time step forward so the new values are actually committed to the signals before display_in() prints them to the terminal.


The Core Problem: Two Things Happening at the Same Time
Imagine this scenario at the exact same clock edge:

text

DUT (Design):        Samples (reads) the input signal
Testbench (Driver):  Updates (writes) the input signal
Who goes first? In real hardware, this is determined by physical wire delays. But in simulation, both happen at the exact same simulation time, and the result depends on which process the simulator happens to schedule first. This unpredictability is the race condition.

Visual Example: WITHOUT Clocking Block (Broken ❌)
systemverilog

// DUT (always block)
always @(posedge clk) begin
    data_reg <= data_in;  // DUT reads data_in
end

// Testbench Driver
task drive();
    @(posedge clk);
    data_in = 8'hFF;      // Driver writes data_in (BLOCKING =)
endtask
What the Simulator Sees at the Clock Edge:
text

Time = 100ns (posedge clk arrives)
│
├── ACTIVE REGION (all blocking = assignments execute here)
│   ├── Process A (DUT):    data_reg <= data_in  → reads data_in
│   └── Process B (Driver): data_in = 8'hFF      → writes data_in
│
│   ⚠️  SIMULATOR CAN RUN THESE IN ANY ORDER!
│
│   Scenario 1: DUT runs FIRST
│       DUT reads data_in = OLD VALUE (e.g., 8'h00)  ← WRONG DATA!
│       Driver writes data_in = 8'hFF (too late!)
│
│   Scenario 2: Driver runs FIRST
│       Driver writes data_in = 8'hFF
│       DUT reads data_in = 8'hFF  ← Correct (but by luck!)
│
└── Result: NON-DETERMINISTIC! Different simulators or runs
            may give different results!
Visual Example: WITH Clocking Block (Fixed ✅)
systemverilog

// Interface with Clocking Block
clocking pipe_cb @(posedge clk);
    default input #1step output #1step;  // ← THE KEY LINE
    output data_in;
endclocking

// DUT (always block) — unchanged
always @(posedge clk) begin
    data_reg <= data_in;  // DUT reads data_in
end

// Testbench Driver — using clocking block
task drive();
    @(pipe_cb);
    pipe_cb.data_in <= 8'hFF;  // Clocking block drive (<=)
endtask
What the Simulator Sees at the Clock Edge:
text

Time = 100ns (posedge clk arrives)
│
├── ACTIVE REGION
│   └── DUT: data_reg <= data_in
│       → reads data_in = OLD VALUE (8'h00)
│       → This is CORRECT! In real hardware, the DUT captures
│         the value that was stable BEFORE this clock edge.
│
├── NBA REGION (Non-Blocking Assignments)
│   └── DUT's data_reg gets updated with old value
│
├── REACTIVE REGION
│   └── (Clocking block input sampling happens here)
│
├── Time = 100ns + 1step (tiny delta later)  ← output #1step
│   └── Clocking block drives data_in = 8'hFF
│       → The NEW value appears AFTER the DUT has already
│         sampled the old value. No collision!
│
└── Result: DETERMINISTIC! Every simulator, every run,
            gives the exact same correct result.
The Key Insight: output #1step
The magic is in this line:

systemverilog

At a posedge of i_clk, the DUT's flip-flops update. If the testbench reads or writes signals at that same instant, the result depends on simulator event ordering, which is a race condition.

Input skew: input #1step
When the testbench reads a signal through the clocking block, it gets the value just before the clock edge, not after.

text

time:      ...  T-1step   T (posedge i_clk)   T+1step
DUT flops:                   update here
TB samples:       ^ value read here (pre-edge value)
So the testbench sees the same values the DUT saw when it captured data on that edge.

I need to correct my earlier explanation. I said input sampling happens #1step after the edge. That was wrong. For inputs, the sampling happens #1step before the edge.

Output skew: output #1step
When the testbench drives a signal through the clocking block, the new value is applied just after the clock edge.

text

time:      T (posedge i_clk)   T+1step
DUT flops:  DUT samples here
TB drives:                      ^ new value appears here
The DUT has already sampled the old value at T, so the new value is seen starting at the next edge. This avoids a race with the DUT's flip-flops.

Example
systemverilog

@(posedge i_clk);            // wait for the clock edge
pipe_cb.o_TxElecIdle <= 1;   // applied #1step after the edge
x = pipe_cb.i_PhyStatus;     // reads the value from just before the edge





*/