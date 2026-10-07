module pcie_LTSSM_pipeOperationBlock (

//PHY inputs
input wire  i_PhyStatus,
input wire  i_RxElecIdle,
input wire  [2:0] i_RXstatus,

//LTSSM inputs
input wire  [4:0] i_LTSSMState,
//input wire  i_RST,

//LTSSM outputs
output reg o_LTSSM_LaneDetected,
output reg o_LTSSM_UpLink,
output wire o_LTSSM_RxElecIdle,


//PHY outputs
output reg o_TxDetectRx_Loopback,
output reg o_TxElecIdle,
output reg o_TxCompliance,
output reg o_RxPolarity,
//output o_Reset_n,
output reg [1:0] o_PowerDown,
output reg [1:0] o_Rate 
);

localparam Detect_Quiet = 5'b00000;
localparam Detect_Active = 5'b00001;


always@(*)	
	begin 
    if(i_LTSSMState==Detect_Quiet)
		begin
        //PHY signals  
        o_TxDetectRx_Loopback = 0;
        o_TxElecIdle = 1;
        o_TxCompliance = 0;
        o_RxPolarity = 0;
        o_PowerDown = 2'b10;
        o_Rate = 0;
        //LTSSM signals
        o_LTSSM_LaneDetected = 0; 
        o_LTSSM_UpLink = 0;
		end
    else if (i_LTSSMState==Detect_Active)
		begin
        //PHY signals
        o_TxDetectRx_Loopback = 1;
        o_TxElecIdle = 1;
        o_TxCompliance = 0;
        o_RxPolarity = 0;
        o_PowerDown = 2'b10;
        o_Rate = 0;
        //LTSSM signals
        o_LTSSM_LaneDetected= 1'b0;
        o_LTSSM_UpLink = 0;
        if(i_PhyStatus == 1'b1)
			begin 
            if(i_RXstatus[2:0]==3'b000)
                o_LTSSM_LaneDetected= 1'b0;
            else if(i_RXstatus[2:0]==3'b011)
                o_LTSSM_LaneDetected= 1'b1;
			end
		//we need to change txElecIdle to 0 after 1 clk cylce from phystatus deassertion  
		end
	
	else 
		begin
        //PHY signals
        o_TxDetectRx_Loopback = 0;
        o_TxElecIdle = 0;
        o_TxCompliance = 0;
        o_RxPolarity = 0;
        o_PowerDown = 2'b00;
        o_Rate = 0;
        
		//LTSSM signals
        o_LTSSM_UpLink = 0;
        o_LTSSM_LaneDetected = 1; 
		end
	end
	
	assign o_LTSSM_RxElecIdle = i_RxElecIdle;
    //assign o_Reset_n = !i_RST;

endmodule

