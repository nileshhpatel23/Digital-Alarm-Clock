module tb_aclk_controller();


reg   reset,
      clk,
      one_second,
      alarm_button,
      time_button;

reg [3:0] key;

wire  reset_count,
      load_new_c,
      show_new_time,
      show_a,
      load_new_a,
      shift;
parameter cycle=20;
integer k;


aclk_controller controller(reset,
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
initial
begin
clk=0;
forever
#(cycle/2) clk=~clk;
end

task initialise();
begin
{key,alarm_button,time_button,one_second}=0;
end
endtask

task rst();
begin
reset=1'b1;
#20;
reset=1'b0;
end
endtask

task inputs(input [3:0] i);
begin
@(negedge clk)
key=i;
end
endtask

initial
begin
forever
#30 one_second=~one_second;
end

initial
begin
rst();
initialise();
//inputs(5);
//#100;
//inputs(10);
inputs(4'b0010);
inputs(4'b1010);
#20;
inputs(4'b0101);
inputs(4'b1010);
#20;
inputs(4'b0011);
inputs(4'b1010);
#20;
inputs(4'b1001);
inputs(4'b1010);
#20;
alarm_button=1'b1;
#30;
alarm_button=1'b0;
inputs(4'b0001);
inputs(4'b1010);
#20;
inputs(4'b0010);
inputs(4'b1010);
#20;
inputs(4'b0110);
inputs(4'b1010);
#20;
time_button=1'b1;
#30000;
time_button=1'b0;
#20;
alarm_button=1'b1;
#80;
alarm_button=1'b0;

#20000 $finish;
end
endmodule





