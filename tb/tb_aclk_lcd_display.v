module tb_aclk_lcd_display();

reg [3:0] current_time_ms_hr,
            current_time_ls_hr,
            current_time_ms_min,
            current_time_ls_min,
            alarm_time_ms_hr,
            alarm_time_ls_hr,
            alarm_time_ms_min,
            alarm_time_ls_min,
            key_buffer_ms_hr,
            key_buffer_ls_hr,
            key_buffer_ms_min,
            key_buffer_ls_min;


reg show_new_time,show_a;


wire [7:0] display_ms_hr,
             display_ls_hr,
             display_ms_min,
             display_ls_min;


aclk_lcd_display  dis_driv(current_time_ms_hr,
                        current_time_ls_hr,
                        current_time_ms_min,
                        current_time_ls_min,
                        alarm_time_ms_hr,
                        alarm_time_ls_hr,
                        alarm_time_ms_min,
                        alarm_time_ls_min,
                        key_buffer_ms_hr,
                        key_buffer_ls_hr,
                        key_buffer_ms_min,
                        key_buffer_ls_min,
                        show_new_time,
                        show_a,sound_alarm,
								display_ms_hr,
                        display_ls_hr,
                        display_ms_min,
                        display_ls_min);


task initialise();
begin
{current_time_ms_hr,
 current_time_ls_hr,
 current_time_ms_min,
 current_time_ls_min,
 alarm_time_ms_hr,
 alarm_time_ls_hr,
 alarm_time_ms_min,
 alarm_time_ls_min,
 key_buffer_ms_hr,
 key_buffer_ls_hr,
 key_buffer_ms_min,
 key_buffer_ls_min,
 show_new_time,
 show_a}   =   0 ;
end
endtask



task current_time();
begin
current_time_ms_hr = 4'd1;
current_time_ls_hr = 4'd8;
current_time_ms_min = 4'd0;
current_time_ls_min = 4'd3;
end
endtask

task alarm_time();
begin
alarm_time_ms_hr = 4'd2;
alarm_time_ls_hr = 4'd4;
alarm_time_ms_min = 4'd8;
alarm_time_ls_min = 4'd7;
end
endtask

task key_time();
begin
key_buffer_ms_hr = $random;
key_buffer_ls_hr = $random;
key_buffer_ms_min = $random;
key_buffer_ls_min = $random;
end
endtask

task control_lines(input i,j);
begin
show_a = i;
show_new_time = j;
end
endtask

initial
begin
initialise();
#40;
current_time();

alarm_time();
key_time();
control_lines(0,1);
//control_lines(1,0);
/*current_time(0,2,0,0);
alarm_time(1,2,3,0);
key_time(1,5,3,0);
control_lines(0,0);
*/
end

initial $monitor("output ::: %d %d : %d %d , sound_alarm=%b",display_ms_hr,display_ls_hr,display_ms_min,display_ls_min,sound_alarm);
endmodule










