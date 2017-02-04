module aclk_lcd_driver(show_a,
		                 show_new_time,
		                 alarm_time,
                       current_time,
                       key,
                       sound_alarm,
                       display_time);



input show_a,
      show_new_time;

input [3:0] alarm_time,
                 current_time,
                 key;

output wand sound_alarm;

output [7:0] display_time;

reg [7:0] display_time;


always@(*)
begin

 if((show_a==1)  &&  (show_new_time==0))
   begin
   display_time = {4'b0011,alarm_time};
   end

 else if((show_a==0) && (show_new_time==1))
   begin
   display_time = {4'b0011,key};
   end

 else
   begin
   display_time =  {4'b0011,current_time};
   end
end

assign sound_alarm = (current_time==alarm_time) ? 1'b1 : 1'b0;

endmodule
