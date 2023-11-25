
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




% Creation of Temperature control textbox

% TODO: create method in GUI to get free number (of ask a number)
Position_in_ctrl_frame = 2;
pos_arr = get_rel_pos_in_ctrl_frame(Position_in_ctrl_frame);

Device_temp_frame = uipanel('parent', Control_Frame, ...
                            'position', pos_arr);

Title = uicontrol('parent', Device_temp_frame, ...
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


% Setpoint field and button
UserData_temp.display_format = Temperature_display_format;
UserData_temp.unit = Temp_unit;
UserData_temp.default_value = Default_value_for_temp_sp;
UserData_temp.min = Temperature_min;
UserData_temp.max = Temperature_max;
UserData_temp.prev_value = Default_value_for_temp_sp;

Setpoint_field = uicontrol('parent', Device_temp_frame, ...
                   'Style', 'edit', ...
                   'units', 'normalized', ...
                   'position', [0.64 0.76 0.18 0.12], ...
                   'string', num2str(Default_value_for_temp_sp, Temperature_display_format), ...
                   'Callback', @num_field_callback, ...
                   'UserData', UserData_temp);
button = uicontrol('parent', Device_temp_frame, ...
                   'Style', 'pushbutton', ...
                   'units', 'normalized', ...
                   'position', [0.83 0.76 0.16 0.12], ...
                   'string', 'Setpoint', ...
                   'Callback', {@button_press_callback, Setpoint_field}, ...
                   'BackgroundColor', [0.9 0.4 0.4]);

% Ramp fields and buttons
UserData_speed.display_format = Speed_display_format;
UserData_speed.unit = Speed_unit;
UserData_speed.default_value = Default_value_for_speed;
UserData_speed.min = Speed_min;
UserData_speed.max = Speed_max;
UserData_speed.prev_value = Default_value_for_speed;

Ramp_tg_field = uicontrol('parent', Device_temp_frame, ...
                   'Style', 'edit', ...
                   'units', 'normalized', ...
                   'position', [0.01 0.76 0.15 0.12], ...
                   'string', num2str(Default_value_for_temp_sp, Temperature_display_format), ...
                   'Callback', @num_field_callback, ...
                   'UserData', UserData_temp);
Ramp_speed_field = uicontrol('parent', Device_temp_frame, ...
                   'Style', 'edit', ...
                   'units', 'normalized', ...
                   'position', [0.17 0.76 0.15 0.12], ...
                   'string', num2str(Default_value_for_speed, Speed_display_format), ...
                   'Callback', @num_field_callback, ...
                   'UserData', UserData_speed);
button = uicontrol('parent', Device_temp_frame, ...
                   'Style', 'pushbutton', ...
                   'units', 'normalized', ...
                   'position', [0.33 0.76 0.16 0.12], ...
                   'string', 'Ramp', ...
                   'Callback', {@button_press_callback, Ramp_tg_field}, ...
                   'BackgroundColor', [0.4 0.9 0.4]);


% TODO: add option to input a string with unit letter
function num_field_callback(src, ~)
    Display_format = src.UserData.display_format;
    default_value = src.UserData.prev_value;
    Min = src.UserData.min; % K
    Max = src.UserData.max; % K

    Num_value = String_to_numerical(src.String, default_value, Min, Max);
    src.String = num2str(Num_value, Display_format);
    src.UserData.prev_value = str2double(src.String);
end

function button_press_callback(~, ~, ui_text_field)
    Num_value = str2double(ui_text_field.String);

    disp([num2str(Num_value) ' is sent to device']) % TODO: add something usefull
end




function pos_arr = get_rel_pos_in_ctrl_frame(N)
N = round(N(1));
if (N > 5) || (N < 1)
    error('N must be integer number in range [1; 5]')
end
Rel_pos_in_ctrl_frame = ((5-N)) * 0.2;
pos_arr = [0.0 Rel_pos_in_ctrl_frame 1.0 0.2];
end











