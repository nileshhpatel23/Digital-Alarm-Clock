module tb_aclk_counter();


reg clk,
      reset,
      one_minute,
      load_new_c;

reg [3:0] new_current_time_ms_hr,
            new_current_time_ls_hr,
            new_current_time_ms_min,
            new_current_time_ls_min;

wire [3:0] current_time_ms_hr,
                 current_time_ls_hr,
                 current_time_ms_min,
                 current_time_ls_min;


parameter cycle=20;
integer i;

aclk_counter c1(clk, 
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


task initialise();
begin
{new_current_time_ms_hr,
 new_current_time_ls_hr,
 new_current_time_ms_min,
 new_current_time_ls_min}=4'b0000;
end
endtask

task inputs(input [3:0] i,j,k,l);
begin
@(negedge clk)
begin
new_current_time_ms_hr=i;
new_current_time_ls_hr=j;
new_current_time_ms_min=k;
new_current_time_ls_min=l;
end
end
endtask


task load(input i);
begin
@(negedge clk)
load_new_c=i;
end
endtask


task minute(input i);
begin
@(negedge clk)
one_minute=i;
end
endtask


initial
begin
rst();
initialise();
//#20;
inputs(4'd2,4'd3,4'd5,4'd9);
//#20;

load(1'b1);
#20;
load(1'b0);

for(i=0;i<=255;i=i+1)
begin
minute(1'b1);
#20;
minute(1'b0);
#20;
end


#300 $finish;
end

initial $monitor("input :: clk=%b  rst=%b  load=%b, new time %d %d:%d %d, one_min=%b,   output:: current time=%d %d:%d %d",clk,reset,load_new_c,new_current_time_ms_hr,new_current_time_ls_hr,new_current_time_ms_min,new_current_time_ls_min,one_minute,current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min);

endmodule



