module tb_alarm_clk_rtl();

reg   clk,
        reset,
        alarm_button,
        time_button,
        stop_watch;

reg [3:0] key;

wire  sound_alarm;

wire  [7:0] display_ms_hr,
         display_ls_hr,
         display_ms_min,
         display_ls_min;                      

parameter cycle=20;

alarm_clk_rtl alarm_clk(clk,
		        reset,
		        alarm_button,
		        time_button,
		        key,stop_watch,
		        sound_alarm,
		        display_ms_hr,
		        display_ls_hr,
		        display_ms_min,
		        display_ls_min);


initial
begin
clk=1'b0;
forever
#(cycle/2) clk=~clk;
end

task rst();
begin
reset=1'b1;
#60;
reset=1'b0;
end
endtask


task input_key(input [3:0] i);
begin
@(negedge clk)
key=i;
end
endtask

task alarm(input j);
begin
@(negedge clk)
alarm_button=j;
end
endtask

task tim(input k);
begin
@(negedge clk)
time_button=k;
end
endtask

task stp_wtc(input l);
begin
@(negedge clk)
stop_watch=l;
end
endtask

task initialise();
begin
@(negedge clk)
begin
key=4'd10;
{time_button,alarm_button,stop_watch}=0;
end
end
endtask


initial
begin
rst();
initialise();
stp_wtc(1'b0);
// setting time to 21:23
input_key(4'd2);
#50;
input_key(4'd10);

input_key(4'd1);
#50;
input_key(4'd10);

input_key(4'd2);
#50;
input_key(4'd10);

input_key(4'd3);
#50;
input_key(4'd10);

tim(1'b1);
tim(1'b0);

//setting alarm time to 22:00
input_key(4'd2);
#50;
input_key(4'd10);

input_key(4'd1);
#50;
input_key(4'd10);

input_key(4'd2);
#50;
input_key(4'd10);

input_key(4'd4);
#50;
input_key(4'd10);

alarm(1'b1);
alarm(1'b0);


#99999999 $finish;
end

endmodule
