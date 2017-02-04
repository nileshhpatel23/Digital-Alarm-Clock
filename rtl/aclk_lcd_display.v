module aclk_lcd_display(current_time_ms_hr,
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
			display_time_ms_hr,
                       display_time_ls_hr,
                       display_time_ms_min,
                       display_time_ls_min);



input [3:0] current_time_ms_hr,
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

input show_new_time,show_a;


output [7:0] display_time_ms_hr,
                       display_time_ls_hr,
                       display_time_ms_min,
                       display_time_ls_min;

output wand sound_alarm;


aclk_lcd_driver a_ms_hr(.show_a(show_a),
                     .show_new_time(show_new_time),
                     .alarm_time(alarm_time_ms_hr),
                     .current_time(current_time_ms_hr),
                     .key(key_buffer_ms_hr),
                     .sound_alarm(sound_alarm),
                     .display_time(display_time_ms_hr));


aclk_lcd_driver a_ls_hr(.show_a(show_a),
                     .show_new_time(show_new_time),
                     .alarm_time(alarm_time_ls_hr),
                     .current_time(current_time_ls_hr),
                     .key(key_buffer_ls_hr),
                     .sound_alarm(sound_alarm),
                     .display_time(display_time_ls_hr));



aclk_lcd_driver a_ms_min(.show_a(show_a),
                     .show_new_time(show_new_time),
                     .alarm_time(alarm_time_ms_min),
                     .current_time(current_time_ms_min),
                     .key(key_buffer_ms_min),
                     .sound_alarm(sound_alarm),
                     .display_time(display_time_ms_min));


aclk_lcd_driver a_ls_min(.show_a(show_a),
                     .show_new_time(show_new_time),
                     .alarm_time(alarm_time_ls_min),
                     .current_time(current_time_ls_min),
                     .key(key_buffer_ls_min),
                     .sound_alarm(sound_alarm),
                     .display_time(display_time_ls_min));



endmodule
