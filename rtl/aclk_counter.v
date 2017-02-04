module aclk_counter(clk, 
                    reset,
                    one_minute,
                    load_new_c,
                    new_current_time_ms_hr,
                    new_current_time_ls_hr,
                    new_current_time_ms_min,
                    new_current_time_ls_min,
                    current_time_ms_hr,
                    current_time_ls_hr,
                    current_time_ms_min,
                    current_time_ls_min);

input clk,
      reset,
      one_minute,
      load_new_c;

input [3:0] new_current_time_ms_hr,
            new_current_time_ls_hr,
            new_current_time_ms_min,
            new_current_time_ls_min;

output reg [3:0] current_time_ms_hr,
                 current_time_ls_hr,
                 current_time_ms_min,
                 current_time_ls_min;

always@(posedge clk or posedge reset)
begin
if(reset)
begin
{current_time_ms_hr,
 current_time_ls_hr,
 current_time_ms_min,
 current_time_ls_min} <= 0;
end

else
begin
	if(load_new_c==1)
	 begin
		current_time_ms_hr<=new_current_time_ms_hr;
		current_time_ls_hr<=new_current_time_ls_hr;
		current_time_ms_min<=new_current_time_ms_min;
		current_time_ls_min<=new_current_time_ls_min;
	 end

	 if((load_new_c==0) && (one_minute==1))
	      begin

                 current_time_ls_min <= current_time_ls_min + 1'b1;
                 
	         if(current_time_ls_min==4'b1001)
	         begin
	         current_time_ls_min <=4'b0000;
	         current_time_ms_min <= current_time_ms_min+1'b1;
	        

                   if(current_time_ms_min==4'b0101)
                   begin
	                 current_time_ms_min<=0;
	                 current_time_ls_hr<=current_time_ls_hr+1'b1;
	          		     if(current_time_ls_hr==9)
		                  begin
		                   current_time_ls_hr<=0;
		                   current_time_ms_hr<=current_time_ms_hr+1'b1;
		                   end   
		                   else if((current_time_ms_hr==2) && (current_time_ls_hr==3) && (current_time_ms_min==5) && (current_time_ls_min==9))
		        begin
		        {current_time_ms_hr, 
		         current_time_ls_min,
                         current_time_ls_hr,
                         current_time_ms_min}<=0;
		         end
                          
                        
                     
                    end
                   end
                  end
               
		end
     end

endmodule
