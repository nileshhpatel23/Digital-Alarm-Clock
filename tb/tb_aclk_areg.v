module tb_aclk_areg();

reg clk,load_new_a,reset;
reg [3:0] new_alarm_ms_hr,
          new_alarm_ls_hr,
	  new_alarm_ms_min,
	  new_alarm_ls_min;

wire [3:0] alarm_time_ms_hr,
	  alarm_time_ls_hr,
	  alarm_time_ms_min,
	  alarm_time_ls_min;

parameter cycle=20;

//Instantation 
aclk_areg  alarm(.clk(clk),
		     .reset(reset),
		     .load_new_a(load_new_a),
	 	     .new_alarm_ms_hr(new_alarm_ms_hr),
		     .new_alarm_ls_hr(new_alarm_ls_hr),
		     .new_alarm_ms_min(new_alarm_ms_min),
		     .new_alarm_ls_min(new_alarm_ls_min),
		     .alarm_time_ms_hr(alarm_time_ms_hr),
		     .alarm_time_ls_hr(alarm_time_ls_hr),
		     .alarm_time_ms_min(alarm_time_ms_min),
		     .alarm_time_ls_min(alarm_time_ls_min));

//clock generation
initial
begin
clk=0;
forever
#(cycle/2) clk=~clk;
end

// Reset task
task rst();
begin
reset=1'b1;
#50;
reset=1'b0;
end
endtask

//initialisation of inputs
task initialise();
begin
load_new_a = 1'b0;
new_alarm_ms_hr = 0;
new_alarm_ms_min = 0;
new_alarm_ls_min = 0;
new_alarm_ls_hr = 0;
end
endtask

//inputting signals
task inputs(input [3:0] i,j,k,l);
begin
@(negedge clk)
begin
new_alarm_ms_hr = i;
new_alarm_ls_hr = j;
new_alarm_ms_min = k;
new_alarm_ls_min = l;
end
end
endtask

//inputting load signal
task load(input m);
begin
load_new_a = m;
end
endtask


//main
initial
begin
rst();
initialise();
#40;
load(1'b1);
inputs($random,$random,$random,$random);
#20;
inputs(4'b0011,4'b1100,4'b1010,4'b0101);
#20;
$finish;
end

initial $monitor("input:: rst=%b, clk=%b,load=%b   ms_hr=%d, ls_hr=%d : ms_min=%d, ls_min=%d :: output= %d %d : %d %d",reset,clk,load_new_a,new_alarm_ms_hr,new_alarm_ls_hr,new_alarm_ms_min,new_alarm_ls_min,alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min);

endmodule

