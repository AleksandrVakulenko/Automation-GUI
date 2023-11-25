
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

Title = uicontrol('parent', Device_frame, ...
                  'Style', 'text', ...
                  'units', 'normalized', ...
                  'position', [0.0 0.88 0.5 0.12], ...
                  'HorizontalAlignment', 'left', ...
                  'string', 'Temperature control');


% Creation of Temperature control textbox

Default_value_for_temp_sp = 273; %K
Temp_unit = 'K';
Temperature_display_format = '%6.2f';
Temperature_min = 80; % K
Temperature_max = 600; % K
% User data is a cell array:
% cell(1) contains num2string display format
% cell(2) ... temperature unit
% cell(3) ... def value of temperature
% cell(4) ... min value
% cell(5) ... max value
% cell(6) ... prev_value (initby def, dont modify);
UserData = {Temperature_display_format, ...
            Temp_unit, ...
            Default_value_for_temp_sp, ...
            Temperature_min, ...
            Temperature_max, ...
            Default_value_for_temp_sp};
num_field = uicontrol('parent', Device_frame, ...
                   'Style', 'edit', ...
                   'units', 'normalized', ...
                   'position', [0.1 0.1 0.22 0.12], ...
                   'string', num2str(Default_value_for_temp_sp, Temperature_display_format), ...
                   'Callback', {@num_field_callback, }, ...
                   'UserData', UserData);

button = uicontrol('parent', Device_frame, ...
                   'Style', 'pushbutton', ...
                   'units', 'normalized', ...
                   'position', [0.32 0.1 0.16 0.12], ...
                   'string', 'Setpoint', ...
                   'Callback', {@button_field_callback, num_field});


% FIXME: add min/max limit
% TODO: add option to input a string with unit letter
function num_field_callback(src, ~)
    default_value = src.UserData{6};
    Tmin = src.UserData{4}; % K
    Tmax = src.UserData{5}; % K
    Num_value = String_to_numerical(src.String, default_value, Tmin, Tmax);
    Temperature_display_format = src.UserData{1};
    src.String = num2str(Num_value, Temperature_display_format);
    src.UserData{6} = str2double(src.String); % update old value
end

function button_field_callback(~, ~, ui_text_field)
    Num_value = str2double(ui_text_field.String);
    disp([num2str(Num_value) ' is sent to device'])
end

















