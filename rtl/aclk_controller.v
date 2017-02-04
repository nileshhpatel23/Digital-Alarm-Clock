module aclk_controller(reset,
		       clk,
		       one_second,
		       alarm_button,
		       time_button,
			key,
			reset_count,
			load_new_c,
			show_new_time,
			show_a,
			load_new_a,
			shift);

input reset,
      clk,
      one_second,
      alarm_button,
      time_button;

input [3:0] key;

output reg      reset_count,
        	load_new_c,
       		show_new_time,
        	show_a,
        	load_new_a,
        	shift;

parameter show_time=3'd0,
	  key_stored=3'd1,
	  key_waited=3'd2,
	  key_entry=3'd3,
          set_alarm_time=3'd4,
          set_current_time=3'd5,
   	  show_alarm=3'd6;	   
 
reg [2:0] state, next_state;

reg [3:0] count_time;

wire time_out;


always@(posedge clk or posedge reset)
begin
if(reset)
begin
state<=show_time;
end

else
state<=next_state;
end

always@(*)
begin

case(state)

show_time : begin
	        {reset_count,load_new_c,load_new_a,show_a,show_new_time,shift}=0;
		if(key!=10)
		begin		
		next_state=key_stored;
		end
		
                else if(alarm_button)
		begin
		next_state=show_alarm;
		end
		
                else
		begin
		next_state=show_time;
                end
            end

key_stored :  begin
	      {reset_count,load_new_c,load_new_a,show_a}=0;
              shift=1'b1;
              show_new_time=1'b1;
              next_state=key_waited;
	      end
          	
key_waited :   begin
               show_new_time=1'b1;
                {reset_count,load_new_c,load_new_a,show_a}=0;
		shift=1'b0;
		 if(key==10)
                 begin
		 next_state=key_entry;
                 end
		
                 else if((key!=10) && (time_out==1))
                 begin
		 next_state=key_waited;
                 end
		
                 else 
                 begin 
		 next_state=show_time;
                 end
               end

key_entry : begin
	      {reset_count,load_new_c,load_new_a,show_a,shift}=0;
               show_new_time=1'b1;
	       if(key!=10)
               begin
               next_state=key_stored;
               end
	       
                else if(time_out==0)
		begin
		next_state=show_time;
                end
		
                else if(alarm_button)
                begin		
                next_state=set_alarm_time;
		end
		
                else if(time_button)
		begin
		next_state=set_current_time;
		end
		
                else
		begin
		next_state=key_entry;
                end
	      end

set_alarm_time : begin
                    load_new_a=1'b1;
		    next_state=show_time;
                    reset_count=1'b0;
                    {load_new_c,show_a,show_new_time,shift}=0;  
		  end

set_current_time : begin
		     next_state=show_time;
                     reset_count=1'b1;
                     load_new_c=1'b1;
		     {load_new_a,show_a,show_new_time,shift}=0;	
 	           end

show_alarm   :     begin
                   show_a=1'b1;
		   {reset_count,load_new_c,load_new_a,show_new_time,shift}=0;
                     if(!alarm_button)
                     begin
		     next_state=show_time;
                     end
             	    
                     else
                     begin               
		     next_state=show_alarm;
		     end 
                   end
		 
default :	begin
		 next_state=show_time;
		 {load_new_c,load_new_a,show_a,reset_count,shift,show_new_time}=0;
		end
endcase
end

always@(posedge clk or posedge reset)
begin  
if(reset)
count_time <= 4'b0000;

else
begin
if(state==key_waited)
begin
   if((state==key_waited) && (key==10))
   begin
   count_time<=4'b0000;
   end


   if(count_time==10) 
   count_time <= 4'b0000;
   else if(one_second)
   count_time<=count_time+1'b1;      
   
end
else
count_time<=4'b0000;
end 
end
assign time_out=(count_time==10)?1'b0:1'b1;
endmodule
