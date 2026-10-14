module pcie_LTSSM_stateMachine
    (
    input wire  i_LTSSM_UpDown,
	input wire  i_resetn,
    //timer
    input wire  i_timer_timeout,
    output reg [22:0] o_timer_timeoutValue,
    output reg o_timer_start,
    // order set creator module
    input wire  i_OScreator_Ack,
    output reg [7:0] o_OScreator_Symbol0,
    output reg [7:0] o_OScreator_Symbol1,
    output reg [7:0] o_OScreator_Symbol2,
    output reg [7:0] o_OScreator_Symbol3,
    output reg [7:0] o_OScreator_Symbol4,
    output reg [7:0] o_OScreator_Symbol5,
    output reg [7:0] o_OScreator_Symbol6,
    output reg [7:0] o_OScreator_Symbol7,
    output reg [7:0] o_OScreator_Symbol8,
    output reg [7:0] o_OScreator_Symbol9,
    output reg [7:0] o_OScreator_Symbol10,
    output reg [7:0] o_OScreator_Symbol11,
    output reg [7:0] o_OScreator_Symbol12,
    output reg [7:0] o_OScreator_Symbol13,
    output reg [7:0] o_OScreator_Symbol14,
    output reg [7:0] o_OScreator_Symbol15,
    output reg [10:0] o_OScreator_reqNum,
    output reg o_OScreator_enable,
    output reg [1:0] o_OScreator_types,
    output reg o_OScreator_resetTScounter,
    // pipe
    output wire [4:0] o_LTSSM_state,// out to decoder and Pipe
    input wire  i_PCLK,
    input wire  i_PHY_laneDetected,
    input wire  i_PHY_RxElecIdle,
    //  receiver
    input wire  [1:0] i_OSdecoder_Ack,
    input wire  [7:0] i_OSdecoder_Link,
    input wire  [7:0] i_OSdecoder_Lane,
    //input wire  [7:0] Rx_RateID,
    //input wire  [7:0] Rx_TrainControl,
        
    output reg o_LTSSM_stateChange,
    // Transmitter
    output reg o_LTSSM_L0_up
    
    );
    localparam COM=8'hBC;
    localparam PAD=8'hF7;
    localparam FTS=8'hFF;
    localparam SKP=8'h1C;
    localparam Detect_Quiet=5'b00000;
    localparam Detect_Active=5'b00001;
    localparam Polling_Active=5'b00010;
    localparam Polling_configuration=5'b00011;
    localparam Config_Linkwidth_start=5'b00100;
    localparam Config_Linkwidth_Accept=5'b00101;
    localparam Config_Lanenum_wait=5'b00110;
    localparam Config_Lanenum_Accept=5'b00111;
    localparam Config_complete=5'b01000;
    localparam Config_idle=5'b01001;
    localparam L0=5'b01010;
    
    reg [4:0] current_state;
    reg [4:0] Next_state;
   
	
    assign o_LTSSM_state=current_state;
    
	always @(posedge i_PCLK )
    begin
        if(!i_resetn)
        begin
        current_state<=Detect_Quiet;
        end
        else
        current_state<=Next_state;
    end
    
    always@(*)
        begin
        case(current_state)
     
        Detect_Quiet:
        begin
            
            Next_state=current_state;    
            o_LTSSM_stateChange=0;
            o_timer_start=1;
            o_LTSSM_L0_up=0;
            o_OScreator_enable=0;
            o_OScreator_types=3;
            o_timer_timeoutValue= 12*4; /// 12 ms scaled 12*4 clk cycle
            
            o_OScreator_Symbol0=0;
            o_OScreator_Symbol1=0;
            o_OScreator_Symbol2=0;
            o_OScreator_Symbol3=0;
            o_OScreator_Symbol4=0;
            o_OScreator_Symbol5=0;
            o_OScreator_Symbol6=0;
            o_OScreator_Symbol7=0;
            o_OScreator_Symbol8=0;
            o_OScreator_Symbol9=0;
            o_OScreator_Symbol10=0;
            o_OScreator_Symbol11=0;
            o_OScreator_Symbol12=0;
            o_OScreator_Symbol13=0;
            o_OScreator_Symbol14=0;
            o_OScreator_Symbol15=0;  
            o_OScreator_reqNum=0; 
            o_OScreator_resetTScounter=0;
            if( i_timer_timeout==1 || i_PHY_RxElecIdle==0)
            begin
            Next_state=Detect_Active;
            o_timer_start=0;
            o_LTSSM_stateChange=1;
            end
            
        end
        
        Detect_Active:
        begin
           
            Next_state=current_state;
            o_timer_start=1;
            o_LTSSM_stateChange=0;             
            o_LTSSM_L0_up=0;
            o_OScreator_enable=0;
            o_OScreator_types=3;
            o_timer_timeoutValue= 12*4;// 12 ms
            
            
            o_OScreator_Symbol0=0;
            o_OScreator_Symbol1=0;
            o_OScreator_Symbol2=0;
            o_OScreator_Symbol3=0;
            o_OScreator_Symbol4=0;
            o_OScreator_Symbol5=0;
            o_OScreator_Symbol6=0;
            o_OScreator_Symbol7=0;
            o_OScreator_Symbol8=0;
            o_OScreator_Symbol9=0;
            o_OScreator_Symbol10=0;
            o_OScreator_Symbol11=0;
            o_OScreator_Symbol12=0;
            o_OScreator_Symbol13=0;
            o_OScreator_Symbol14=0;
            o_OScreator_Symbol15=0;  
            o_OScreator_reqNum=0; 
            o_OScreator_resetTScounter=0;
                      
            
            if(i_PHY_laneDetected==1)
            begin
            Next_state=Polling_Active;
            o_timer_start=0;
            o_LTSSM_stateChange=1;
            end
            else if(i_timer_timeout==1)
            begin
            Next_state=Detect_Quiet;
            o_timer_start=0;
            o_LTSSM_stateChange=1;
            end
            
        end
            
        Polling_Active:begin
            Next_state=current_state;
            o_LTSSM_L0_up=0;            
            o_timer_start=1;
            o_timer_timeoutValue= 24*4;// 24ms
            o_OScreator_enable=1; 
            o_OScreator_types=1 ; // TS1 order set
            o_LTSSM_stateChange=0;
            
            
            
            o_OScreator_Symbol0=COM;
            o_OScreator_Symbol1=PAD;
            o_OScreator_Symbol2=PAD;
            o_OScreator_Symbol3=FTS;
            o_OScreator_Symbol4=8'b0000_0010;
            o_OScreator_Symbol5=0;
            o_OScreator_Symbol6=8'h4A;
            o_OScreator_Symbol7=8'h4A;
            o_OScreator_Symbol8=8'h4A;
            o_OScreator_Symbol9=8'h4A;
            o_OScreator_Symbol10=8'h4A;
            o_OScreator_Symbol11=8'h4A;
            o_OScreator_Symbol12=8'h4A;
            o_OScreator_Symbol13=8'h4A;
            o_OScreator_Symbol14=8'h4A;
            o_OScreator_Symbol15=8'h4A;  
            o_OScreator_reqNum=24; // 1024 scaled to 24
            o_OScreator_resetTScounter=0;
                 
            if(i_OScreator_Ack==1 && i_OSdecoder_Ack==2'b01)
            begin
            Next_state=Polling_configuration;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            end
            else if (i_timer_timeout==1)
            begin
            Next_state=Detect_Quiet;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            o_OScreator_enable=0;
            end
            end
        
        Polling_configuration:begin
              Next_state=current_state;
              o_timer_start=1;
              o_timer_timeoutValue= 48*4;  //48ms
              o_OScreator_enable=1;
              o_OScreator_types=1;
              o_LTSSM_stateChange=0;
              o_LTSSM_L0_up=0;
                          
              
              o_OScreator_Symbol0=COM;
              o_OScreator_Symbol1=PAD;
              o_OScreator_Symbol2=PAD;
              o_OScreator_Symbol3=FTS;
              o_OScreator_Symbol4=8'b0000_0010;
              o_OScreator_Symbol5=0;
              o_OScreator_Symbol6=8'h45;
              o_OScreator_Symbol7=8'h45;
              o_OScreator_Symbol8=8'h45;
              o_OScreator_Symbol9=8'h45;
              o_OScreator_Symbol10=8'h45;
              o_OScreator_Symbol11=8'h45;
              o_OScreator_Symbol12=8'h45;
              o_OScreator_Symbol13=8'h45;
              o_OScreator_Symbol14=8'h45;
              o_OScreator_Symbol15=8'h45;
              o_OScreator_reqNum=16;
             o_OScreator_resetTScounter=0;
                        
            if(i_OScreator_Ack==1 && i_OSdecoder_Ack==2'b01)
            begin
            Next_state=Config_Linkwidth_start;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            end
            else if (i_timer_timeout==1)
            begin
            Next_state=Detect_Quiet;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            o_OScreator_enable=0;
            end
            end
            
        
        Config_Linkwidth_start:begin
              Next_state=current_state;
              o_timer_start=1;
              o_timer_timeoutValue= 24*4;  //24 ms  
              o_LTSSM_stateChange=0;
              o_OScreator_enable=1;
              o_OScreator_types=1;
              o_LTSSM_L0_up=0;
                            
              o_OScreator_Symbol0=COM;
             if(i_LTSSM_UpDown==0)
				o_OScreator_Symbol1=i_OSdecoder_Link;
			 else
			  o_OScreator_Symbol1=8'h00;
              o_OScreator_Symbol2=PAD;
              o_OScreator_Symbol3=FTS;
              o_OScreator_Symbol4=8'b0000_0010;
              o_OScreator_Symbol5=0;
              o_OScreator_Symbol6=8'h4A;
              o_OScreator_Symbol7=8'h4A;
              o_OScreator_Symbol8=8'h4A;
              o_OScreator_Symbol9=8'h4A;
              o_OScreator_Symbol10=8'h4A;
              o_OScreator_Symbol11=8'h4A;
              o_OScreator_Symbol12=8'h4A;
              o_OScreator_Symbol13=8'h4A;
              o_OScreator_Symbol14=8'h4A;
              o_OScreator_Symbol15=8'h4A;
             o_OScreator_reqNum=11'h7ff; 
             o_OScreator_resetTScounter=0;
                                   
            if(i_OSdecoder_Ack==2'b01)
            begin 
            Next_state=Config_Linkwidth_Accept;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            end
            else if (i_timer_timeout==1)
            begin
            Next_state=Detect_Quiet;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            o_OScreator_enable=0;
            end
            end
            
        Config_Linkwidth_Accept:begin
              Next_state=current_state;
              o_timer_start=1;
              o_timer_timeoutValue = 24*4;  // 24 ms  
              o_OScreator_enable=1;
              o_LTSSM_stateChange=0;
              o_OScreator_types=1;
              o_LTSSM_L0_up=0;
                            
              o_OScreator_Symbol0=COM;
			  if(i_LTSSM_UpDown==0)
			  begin
			  o_OScreator_Symbol1=i_OSdecoder_Link;
			  end
			  else
			  begin
			  o_OScreator_Symbol1=8'h00;
			  end
              o_OScreator_Symbol2=PAD;
              o_OScreator_Symbol3=FTS;
              o_OScreator_Symbol4=8'b0000_0010;
              o_OScreator_Symbol5=0;
              o_OScreator_Symbol6=8'h4A;
              o_OScreator_Symbol7=8'h4A;
              o_OScreator_Symbol8=8'h4A;
              o_OScreator_Symbol9=8'h4A;
              o_OScreator_Symbol10=8'h4A;
              o_OScreator_Symbol11=8'h4A;
              o_OScreator_Symbol12=8'h4A;
              o_OScreator_Symbol13=8'h4A;
              o_OScreator_Symbol14=8'h4A;
             o_OScreator_Symbol15=8'h4A; 
             o_OScreator_reqNum=11'h7ff; 
             o_OScreator_resetTScounter=0;
                                  
            if(i_OSdecoder_Ack==2'b01)
            begin
            Next_state=Config_Lanenum_wait;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            end
            else if (i_timer_timeout==1)
            begin
            Next_state=Detect_Quiet;
            o_timer_start=0;
            o_LTSSM_stateChange=1;
            o_OScreator_enable=0;
            end
            end
        
        Config_Lanenum_wait:begin
             Next_state=current_state;
             o_timer_start=1;
             o_timer_timeoutValue = 2*4;    // 2 ms
             o_LTSSM_stateChange=0;  
             o_OScreator_enable=1;
             o_OScreator_types=1;
             o_LTSSM_L0_up=0;
                           
             o_OScreator_Symbol0=COM;
               if(i_LTSSM_UpDown==0)
			  begin
			  o_OScreator_Symbol1=i_OSdecoder_Link;
			  o_OScreator_Symbol2=i_OSdecoder_Lane;
			  end
			  else
			  begin
			  o_OScreator_Symbol1=8'h00;
			  o_OScreator_Symbol2=8'h00;
			  end
              o_OScreator_Symbol3=FTS;
              o_OScreator_Symbol4=8'b0000_0010;
              o_OScreator_Symbol5=0;
              o_OScreator_Symbol6=8'h4A;
              o_OScreator_Symbol7=8'h4A;
              o_OScreator_Symbol8=8'h4A;
              o_OScreator_Symbol9=8'h4A;
              o_OScreator_Symbol10=8'h4A;
              o_OScreator_Symbol11=8'h4A;
              o_OScreator_Symbol12=8'h4A;
              o_OScreator_Symbol13=8'h4A;
              o_OScreator_Symbol14=8'h4A;
              o_OScreator_Symbol15=8'h4A;
             o_OScreator_reqNum=11'h7ff; 
             o_OScreator_resetTScounter=0;
                                   
            if(i_OSdecoder_Ack==2'b01)
            begin
            Next_state=Config_Lanenum_Accept;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            end
            else if (i_timer_timeout==1)
            begin
            Next_state=Detect_Quiet;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            end
            end
        
        Config_Lanenum_Accept:begin
            Next_state=current_state;
            o_timer_start=1;
            o_LTSSM_stateChange=0;
            o_timer_timeoutValue= 2*4;     // 2 ms  
            
            o_OScreator_enable=1;
             o_OScreator_types=1;
            o_LTSSM_L0_up=0;
                           
             o_OScreator_Symbol0=COM;
               if(i_LTSSM_UpDown==0)
              begin
              o_OScreator_Symbol1=i_OSdecoder_Link;
              o_OScreator_Symbol2=i_OSdecoder_Lane;
              end
              else
              begin
              o_OScreator_Symbol1=8'h00;
              o_OScreator_Symbol2=8'h00;
              end
              o_OScreator_Symbol3=FTS;
              o_OScreator_Symbol4=8'b0000_0010;
              o_OScreator_Symbol5=0;
              o_OScreator_Symbol6=8'h4A;
              o_OScreator_Symbol7=8'h4A;
              o_OScreator_Symbol8=8'h4A;
              o_OScreator_Symbol9=8'h4A;
              o_OScreator_Symbol10=8'h4A;
              o_OScreator_Symbol11=8'h4A;
              o_OScreator_Symbol12=8'h4A;
              o_OScreator_Symbol13=8'h4A;
              o_OScreator_Symbol14=8'h4A;
              o_OScreator_Symbol15=8'h4A;
             o_OScreator_reqNum=11'h7ff; 
             o_OScreator_resetTScounter=0;
                                   
            
            if(i_OSdecoder_Ack==2'b01) 
            begin
            Next_state=Config_complete;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            end
            else if (i_timer_timeout==1)
            begin
            Next_state=Detect_Quiet;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            o_OScreator_enable=0;
            end
            end
           
        Config_complete:begin
        Next_state=current_state;
            o_timer_start=1;
            o_LTSSM_stateChange=0;
            o_timer_timeoutValue= 2*4;     // 2ms
              o_OScreator_enable=1;
              o_OScreator_types=1;
                o_LTSSM_L0_up=0;
                            
              o_OScreator_Symbol0=COM;
               if(i_LTSSM_UpDown==0)
			  begin
			  o_OScreator_Symbol1=i_OSdecoder_Link;
			  o_OScreator_Symbol2=i_OSdecoder_Lane;
			  end
			  else
			  begin
			  o_OScreator_Symbol1=8'h00;
			  o_OScreator_Symbol2=8'h00;
			  end
              o_OScreator_Symbol3=FTS;
              o_OScreator_Symbol4=8'b0000_0010;
              o_OScreator_Symbol5=0;
              o_OScreator_Symbol6=8'h45;
              o_OScreator_Symbol7=8'h45;
              o_OScreator_Symbol8=8'h45;
              o_OScreator_Symbol9=8'h45;
              o_OScreator_Symbol10=8'h45;
              o_OScreator_Symbol11=8'h45;
              o_OScreator_Symbol12=8'h45;
              o_OScreator_Symbol13=8'h45;
              o_OScreator_Symbol14=8'h45;
              o_OScreator_Symbol15=8'h45;
             o_OScreator_reqNum=11'h7ff; 
             o_OScreator_resetTScounter=0;
                                   
            if(i_OSdecoder_Ack==2'b10&&i_OScreator_Ack==1)
            begin
            o_OScreator_resetTScounter=0;
            o_OScreator_reqNum=16;
            Next_state=Config_idle;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            end
            else if(i_OSdecoder_Ack==2'b01 || i_OSdecoder_Ack==2'b10)
                begin
                o_OScreator_resetTScounter=1;
                o_OScreator_reqNum=16;
                end        
            else if (i_timer_timeout==1)
            begin
            Next_state=Detect_Quiet;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            o_OScreator_enable=0;
            end        
            end
    
        Config_idle:begin
            Next_state=current_state;
            o_OScreator_enable=1;
            o_OScreator_types=2;
            o_timer_start=1;
            o_LTSSM_stateChange=0;
            o_timer_timeoutValue = 2*4;     //  2ms            
            o_LTSSM_L0_up=0;
                          
            o_OScreator_Symbol0=0;
            o_OScreator_Symbol1=0;
            o_OScreator_Symbol2=0;
            o_OScreator_Symbol3=0;
            o_OScreator_Symbol4=0;
            o_OScreator_Symbol5=0;
            o_OScreator_Symbol6=0;
            o_OScreator_Symbol7=0;
            o_OScreator_Symbol8=0;
            o_OScreator_Symbol9=0;
            o_OScreator_Symbol10=0;
            o_OScreator_Symbol11=0;
            o_OScreator_Symbol12=0;
            o_OScreator_Symbol13=0;
            o_OScreator_Symbol14=0;
            o_OScreator_Symbol15=0;  
            o_OScreator_reqNum=11'h7ff; 
            o_OScreator_resetTScounter=0;
                      
            
            if(i_OSdecoder_Ack==2'b10&&i_OScreator_Ack==1)
            begin
            o_OScreator_resetTScounter=0;
            o_OScreator_reqNum=16 ;
            Next_state=L0;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            end
            else if (i_timer_timeout==1)
            begin
            Next_state=Detect_Quiet;
            o_LTSSM_stateChange=1;
            o_timer_start=0;
            o_OScreator_enable=0;
            end
            else if(i_OSdecoder_Ack==2'b01 || i_OSdecoder_Ack==2'b10) 
                begin
                o_OScreator_resetTScounter=1;
                o_OScreator_reqNum=16 ;
                end     
            end
                 
        L0:
        begin
        Next_state=current_state;
        
        o_OScreator_enable=0;
        o_OScreator_types=3;
        o_timer_start=1;
        o_LTSSM_stateChange=0;
        o_timer_timeoutValue=23'd590;  //1180 Symbol time
        o_LTSSM_L0_up=1;
                
        o_OScreator_Symbol0=0;
        o_OScreator_Symbol1=0;
        o_OScreator_Symbol2=0;
        o_OScreator_Symbol3=0;
        o_OScreator_Symbol4=0;
        o_OScreator_Symbol5=0;
        o_OScreator_Symbol6=0;
        o_OScreator_Symbol7=0;
        o_OScreator_Symbol8=0;
        o_OScreator_Symbol9=0;
        o_OScreator_Symbol10=0;
        o_OScreator_Symbol11=0;
        o_OScreator_Symbol12=0;
        o_OScreator_Symbol13=0;
        o_OScreator_Symbol14=0;
        o_OScreator_Symbol15=0;  
        o_OScreator_reqNum=0; 
        o_OScreator_resetTScounter=0;
        
        if(i_timer_timeout==1)
        begin
        o_OScreator_enable=1;
        o_OScreator_types=0;
        o_OScreator_Symbol0=COM;
        o_OScreator_Symbol1=SKP;
        o_OScreator_Symbol2=SKP;
        o_OScreator_Symbol3=SKP;
        o_OScreator_reqNum=1;
        o_timer_start=0;
        end  
        end
 default: begin
        Next_state=Detect_Quiet;
               
        o_OScreator_enable=0;
        o_OScreator_types=0;
        o_timer_start=0;
        o_LTSSM_stateChange=0;
        o_timer_timeoutValue=0; 
        o_LTSSM_L0_up=0;
                 
         
         o_OScreator_Symbol0=0;
         o_OScreator_Symbol1=0;
         o_OScreator_Symbol2=0;
         o_OScreator_Symbol3=0;
         o_OScreator_Symbol4=0;
         o_OScreator_Symbol5=0;
         o_OScreator_Symbol6=0;
         o_OScreator_Symbol7=0;
         o_OScreator_Symbol8=0;
         o_OScreator_Symbol9=0;
         o_OScreator_Symbol10=0;
         o_OScreator_Symbol11=0;
         o_OScreator_Symbol12=0;
         o_OScreator_Symbol13=0;
         o_OScreator_Symbol14=0;
         o_OScreator_Symbol15=0;  
         o_OScreator_reqNum=0;
         o_OScreator_resetTScounter=0;
                     
 end 
 
        endcase
    end
  endmodule

