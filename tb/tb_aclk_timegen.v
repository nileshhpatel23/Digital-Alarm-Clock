module tb_aclk_timegen();
reg clk, reset, reset_count, stop_watch;

wire one_second, one_minute;

parameter cycle=20;

aclk_timegen time1(.clk(clk),
                   .reset(reset),
                   .reset_count(reset_count),
                   .stop_watch(stop_watch),
                   .one_second(one_second),
                   .one_minute(one_minute));

initial
begin
clk=1'b0;
forever
#(cycle/2) clk=~clk;
end

task rst();
begin
reset=1'b1;
#40;
reset=1'b0;
end
endtask

task rst_count();
begin
reset_count=1'b1;
#40;
reset_count=1'b0;
end
endtask

task stopwatch(input i);
begin
@(negedge clk)
stop_watch=i;
end
endtask

initial
begin
rst();
rst_count();
stopwatch(1'b0);
#1000000;
//stopwatch(1'b1);

#200000 $finish;
end

initial $monitor("clk=%b,  rst=%b, rse_cnt=%b, stp_wtc=%b,    one_sec=%b  one_min=%b", clk,reset,reset_count,stop_watch,one_second, one_minute);

endmodule              
