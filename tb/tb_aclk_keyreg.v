module tb_aclk_keyreg();
reg clk,reset,shift;
reg [3:0] key;
parameter cycle=20;

wire [3:0]  key_buffer_ms_hr,
                   key_buffer_ls_hr,
                   key_buffer_ms_min,
                   key_buffer_ls_min;

aclk_keyreg c2(clk,
               reset,
               key,
               shift,
               key_buffer_ms_hr,
               key_buffer_ls_hr,
               key_buffer_ms_min,
               key_buffer_ls_min);

initial
begin
clk=0;
forever
#(cycle/2) clk=~clk;
end

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
begin
key=i;
end
end
endtask

task shift_input(input j);
begin
@(negedge clk)
shift=j;
end
endtask

initial
begin
rst();
inputs(4'b0010);
shift_input(1);
inputs(4'b0011);
inputs(4'b0101);
inputs(4'b1001);
shift_input(0);
#2000 $finish;
end
initial $monitor("inputs :: clk=%b reset=%b  shift=%b  key=%b  output :: %d %d : %d %d ",clk,reset,shift,key,key_buffer_ms_hr,key_buffer_ls_hr,key_buffer_ms_min,key_buffer_ls_min,);
endmodule
