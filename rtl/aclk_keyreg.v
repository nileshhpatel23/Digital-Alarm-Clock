module aclk_keyreg(clk,
                   reset,
                   key,
                   shift,
                   key_buffer_ms_hr,
                   key_buffer_ls_hr,
                   key_buffer_ms_min,
                   key_buffer_ls_min);

input clk, 
      reset,
      shift;

input [3:0] key;

output reg [3:0]  key_buffer_ms_hr,
                   key_buffer_ls_hr,
                   key_buffer_ms_min,
                   key_buffer_ls_min;

always@(posedge clk or posedge reset)
begin
if(reset)
begin
{key_buffer_ms_hr,
 key_buffer_ls_hr,
 key_buffer_ms_min,
 key_buffer_ls_min}<=0;
end

else
begin
  if(shift)
  begin
  key_buffer_ls_min <= key;
  key_buffer_ms_min <= key_buffer_ls_min;
  key_buffer_ls_hr <= key_buffer_ms_min;
  key_buffer_ms_hr <= key_buffer_ls_hr;
 end
end
end
endmodule
