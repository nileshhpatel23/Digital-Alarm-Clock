module aclk_timegen(clk,
                    reset,
                    reset_count,
                    stop_watch,
                    one_minute,
                    one_second);

input clk, reset, reset_count, stop_watch;

output reg one_second, one_minute;

reg [5:0] count_6;
reg [7:0] count_8;

always@(posedge clk or posedge reset or posedge reset_count)
begin
if(reset)
 begin
 {one_second, one_minute, count_6, count_8}=0;
 end

else if(reset_count)
 begin
 {one_second, one_minute, count_6, count_8}=0;
 end

else
 begin
     if((count_8==255) && (stop_watch==1'b0))
      begin
      count_8=0;
      one_second = 1'b1;
      count_6 = count_6 + 1'b1;
           if(count_6==60)
           begin
           one_minute = 1'b1;
           count_6 = 0;
           end
        end
    
      else if((count_8==255) && (stop_watch==1'b1))
        begin
	count_8=0;
	one_minute= 1'b1;
	one_second = 1'b1;
        count_6 = count_6 + 1'b1;
          if(count_6==60)
          count_6 = 0;
        end
 
    else
    begin
    count_8 = count_8 + 1'b1;
    one_second=1'b0;
    one_minute=1'b0;
    end

end
   
end
endmodule
 

