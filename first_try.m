
clc
Resizable = 'on'; % NOTE: DEBUG mode

% FIXME: make sizes relative to screen size
Pix_SS = get(0,'screensize');
Screen_x_shift = Pix_SS(1);
Screen_y_shift = Pix_SS(2);
Screen_x_scale = Pix_SS(3)/1920;
Screen_y_scale = Pix_SS(4)/1080;
Main_fig_position = [145 + Screen_x_shift ...
                      90 + Screen_y_shift ...
                  	1190 * Screen_x_scale ...
                	 850 * Screen_y_scale];
clearvars Screen_x_shift Screen_y_shift Screen_x_scale Screen_y_scale

% Create main frame
Main_figure = figure('position', Main_fig_position, 'Resize', Resizable);
% and frame for five control frames
Control_Frame = uipanel('parent', Main_figure, 'position', [0.7 0.0 0.3 1.0]);


Device_frame = uipanel('parent', Control_Frame, 'position', [0.0 0.0 1.0 0.2]);





% Creation of Temperature control textbox

Title = uicontrol('parent', Device_frame, ...
                  'Style', 'text', ...
                  'units', 'normalized', ...
                  'position', [0.0 0.88 0.5 0.12], ...
                  'HorizontalAlignment', 'left', ...
                  'string', 'Temperature control', ...
                  'FontWeight', 'bold');

Temperature_display_format = '%6.2f';
Temp_unit = 'K';
Default_value_for_temp_sp = 273; %K
Temperature_min = 80; % K
Temperature_max = 600; % K

Speed_display_format = '%4.1f';
Speed_unit = 'K/min';
Default_value_for_speed = 1; %K/m
Speed_min = 0.1;
Speed_max = 60;


UserData.temp_display_format = Temperature_display_format;
UserData.temp_unit = Temp_unit;
UserData.temp_sp_default_value = Default_value_for_temp_sp;
UserData.temp_min = Temperature_min;
UserData.temp_max = Temperature_max;
UserData.temp_sp_prev_value = Default_value_for_temp_sp;

UserData.speed_display_format = Speed_display_format;
UserData.speed_unit = Speed_unit;
UserData.speed_default_value_for = Default_value_for_speed;
UserData.speed_min = Speed_min;
UserData.speed_max = Speed_max;
UserData.speed_prev_value = Default_value_for_speed;

% Setpoint field and button
Setpoint_field = uicontrol('parent', Device_frame, ...
                   'Style', 'edit', ...
                   'units', 'normalized', ...
                   'position', [0.64 0.76 0.18 0.12], ...
                   'string', num2str(Default_value_for_temp_sp, Temperature_display_format), ...
                   'Callback', {@num_field_callback, }, ...
                   'UserData', UserData);
button = uicontrol('parent', Device_frame, ...
                   'Style', 'pushbutton', ...
                   'units', 'normalized', ...
                   'position', [0.83 0.76 0.16 0.12], ...
                   'string', 'Setpoint', ...
                   'Callback', {@button_press_callback, Setpoint_field}, ...
                   'BackgroundColor', [0.9 0.4 0.4], ...
                   'Tag', 'sp_button');

% Ramp fields and buttons
Ramp_tg_field = uicontrol('parent', Device_frame, ...
                   'Style', 'edit', ...
                   'units', 'normalized', ...
                   'position', [0.01 0.76 0.15 0.12], ...
                   'string', num2str(Default_value_for_temp_sp, Temperature_display_format), ...
                   'Callback', {@num_field_callback, }, ...
                   'UserData', UserData, ...
                   'Tag', 'temp');
Ramp_speed_field = uicontrol('parent', Device_frame, ...
                   'Style', 'edit', ...
                   'units', 'normalized', ...
                   'position', [0.17 0.76 0.15 0.12], ...
                   'string', num2str(Default_value_for_speed, Speed_display_format), ...
                   'Callback', {@num_field_callback, }, ...
                   'UserData', UserData, ...
                   'Tag', 'speed');
button = uicontrol('parent', Device_frame, ...
                   'Style', 'pushbutton', ...
                   'units', 'normalized', ...
                   'position', [0.33 0.76 0.16 0.12], ...
                   'string', 'Ramp', ...
                   'Callback', {@button_press_callback, Ramp_tg_field}, ...
                   'BackgroundColor', [0.4 0.9 0.4], ...
                   'Tag', 'ramp_button');


% TODO: add option to input a string with unit letter
function num_field_callback(src, ~)
    if src.Tag == "temp"
        Display_format = src.UserData.temp_display_format;
        default_value = src.UserData.temp_sp_prev_value;
        Min = src.UserData.temp_min; % K
        Max = src.UserData.temp_max; % K
    elseif src.Tag == "speed"
        Display_format = src.UserData.speed_display_format;
        default_value = src.UserData.speed_prev_value;
        Min = src.UserData.speed_min; % K
        Max = src.UserData.speed_max; % K
    end
    Num_value = String_to_numerical(src.String, default_value, Min, Max);
    src.String = num2str(Num_value, Display_format);
    if src.Tag == "temp" % update old value
        src.UserData.temp_sp_prev_value = str2double(src.String);
    elseif src.Tag == "speed"
        src.UserData.speed_prev_value = str2double(src.String);
    end
end

function button_press_callback(src, ~, ui_text_field)
    Num_value = str2double(ui_text_field.String);
    % TODO: add something usefull
    disp([num2str(Num_value) ' is sent to device'])
end

















