module alarm_clk_rtl(clk,
		     reset,
		     alarm_button,
		     time_button,
		     key,stop_watch,
		     sound_alarm,
		     display_ms_hr,
		     display_ls_hr,
		     display_ms_min,
		     display_ls_min);

input   clk,
        reset,
	alarm_button,
	time_button,
	stop_watch;

input [3:0] key;

output  sound_alarm;

output  [7:0] display_ms_hr,
	 display_ls_hr,
	 display_ms_min,
	 display_ls_min;

wire    reset_count,
	one_second,
	one_minute,
	load_new_c,
        show_new_time,
        show_a,
        load_new_a,
        shift;
	
wire [3:0]  current_time_ms_hr,
            current_time_ls_hr,
            current_time_ms_min,
            current_time_ls_min,
	    key_buffer_ms_hr,
            key_buffer_ls_hr,
            key_buffer_ms_min,
            key_buffer_ls_min,
            alarm_time_ms_hr,
            alarm_time_ls_hr,
            alarm_time_ms_min,
            alarm_time_ls_min;
	

// time generator
aclk_timegen time1(.clk(clk),
                   .reset(reset),
                   .reset_count(reset_count),
                   .stop_watch(stop_watch),
                   .one_second(one_second),
                   .one_minute(one_minute));


// alarm controller
aclk_controller controller(.reset(reset),
		           .clk(clk),
		           .one_second(one_second),
		           .alarm_button(alarm_button),
		           .time_button(time_button),
			   .key(key),
			   .reset_count(reset_count),
			   .load_new_c(load_new_c),
			   .show_new_time(show_new_time),
			   .show_a(show_a),
   			   .load_new_a(load_new_a),
 			   .shift(shift));

// alarm counter

aclk_counter c1(.clk(clk), 
                    .reset(reset),
                    .one_minute(one_minute),
                    .load_new_c(load_new_c),
                    .new_current_time_ms_hr(key_buffer_ms_hr),
                    .new_current_time_ls_hr(key_buffer_ls_hr),
                    .new_current_time_ms_min(key_buffer_ms_min),
                    .new_current_time_ls_min(key_buffer_ls_min),
                    .current_time_ms_hr(current_time_ms_hr),
                    .current_time_ls_hr(current_time_ls_hr),
                    .current_time_ms_min(current_time_ms_min),
                    .current_time_ls_min(current_time_ls_min));

//alarm key register

aclk_keyreg c2(.clk(clk),
               .reset(reset),
               .key(key),
               .shift(shift),
               .key_buffer_ms_hr(key_buffer_ms_hr),
               .key_buffer_ls_hr(key_buffer_ls_hr),
               .key_buffer_ms_min(key_buffer_ms_min),
               .key_buffer_ls_min(key_buffer_ls_min));

// alarm register

aclk_areg  alarm(.clk(clk),
                     .reset(reset),
                     .load_new_a(load_new_a),
                     .new_alarm_ms_hr(key_buffer_ms_hr),
                     .new_alarm_ls_hr(key_buffer_ls_hr),
                     .new_alarm_ms_min(key_buffer_ms_min),
                     .new_alarm_ls_min(key_buffer_ls_min),
                     .alarm_time_ms_hr(alarm_time_ms_hr),
                     .alarm_time_ls_hr(alarm_time_ls_hr),
                     .alarm_time_ms_min(alarm_time_ms_min),
                     .alarm_time_ls_min(alarm_time_ls_min));


// alarm display unit
aclk_lcd_display  dis_driv(.current_time_ms_hr(current_time_ms_hr),
                           .current_time_ls_hr(current_time_ls_hr),
                           .current_time_ms_min(current_time_ms_min),
                           .current_time_ls_min(current_time_ls_min),
                           .alarm_time_ms_hr(alarm_time_ms_hr),
                           .alarm_time_ls_hr(alarm_time_ls_hr),
                           .alarm_time_ms_min(alarm_time_ms_min),
                           .alarm_time_ls_min(alarm_time_ls_min),
                           .key_buffer_ms_hr(key_buffer_ms_hr),
                           .key_buffer_ls_hr(key_buffer_ls_hr),
                           .key_buffer_ms_min(key_buffer_ms_min),
                           .key_buffer_ls_min(key_buffer_ls_min),
                           .show_new_time(show_new_time),
                           .show_a(show_a),
                           .sound_alarm(sound_alarm),
			   .display_time_ms_hr(display_ms_hr),
                           .display_time_ls_hr(display_ls_hr),
                           .display_time_ms_min(display_ms_min),
                           .display_time_ls_min(display_ls_min));
endmodule
