//---------------------------------------------------------------------------
// File        : aclk_areg.v
// Module      : aclk_areg
// Author      : Nilesh Patel                
// Description : Set New Alarm
// Version     : V0.1
// Date        : 5th November 2016
// e-mail      : nhpatel@syr.edu 
//---------------------------------------------------------------------------

module  aclk_areg(clk, reset, load_new_a, new_alarm_ms_hr, new_alarm_ls_hr, new_alarm_ms_min, new_alarm_ls_min,
                  alarm_time_ms_hr, alarm_time_ls_hr, alarm_time_ms_min, alarm_time_ls_min);

    // System Clock input
    input clk;
    
    // System Reset input
    input reset;
    
    // Load input signal to enter new Alarm
    input load_new_a;
    
    // MSB Digit of Hour input of New Alarm
    input [3:0] new_alarm_ms_hr;
    
    // LSB Digit of Hour input of New Alarm
    input [3:0] new_alarm_ls_hr;
    
    // MSB Digit of Minute input of New Alarm
    input [3:0] new_alarm_ms_min;
    
    // LSB Digit of Minute input of New Alarm
    input [3:0] new_alarm_ls_min;
    
    // MSB Digit Hour of Display Alarm time
    output [3:0]  alarm_time_ms_hr;
    
    // LSB Digit Hour of Display Alarm time
    output [3:0]  alarm_time_ls_hr;
    
    // MSB Digit Minute of Display Alarm time
    output [3:0]  alarm_time_ms_min;
    
    // LSB Digit Minute of Display Alarm time
    output [3:0]  alarm_time_ls_min;
    
    // Internal Registers to store Alarm Time
    reg [3:0]  alarm_time_ms_hr ;
    reg [3:0]  alarm_time_ls_hr ;
    reg [3:0]  alarm_time_ms_min;
    reg [3:0]  alarm_time_ls_min;
    
    
    always@(posedge clk or posedge reset)
    begin
        if(reset)
        begin
           {alarm_time_ms_hr, alarm_time_ls_hr, alarm_time_ms_min, alarm_time_ls_min} <= 0;
        end
        else if(load_new_a)
        begin
            alarm_time_ms_hr  <= new_alarm_ms_hr;
            alarm_time_ls_hr  <= new_alarm_ls_hr;
            alarm_time_ms_min <= new_alarm_ms_min;
            alarm_time_ls_min <= new_alarm_ls_min;
        end
    end
endmodule


