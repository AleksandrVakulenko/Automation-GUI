

classdef Device_control_frame < handle

methods (Access = public)
    function obj = Device_control_frame(Control_Frame, Position_in_ctrl_frame)
        frame = create_control_frame(Control_Frame, Position_in_ctrl_frame);
        obj.Dev_ctrl_frame = frame;
    end

    function delete(obj)
        disp("Device_control_frame DELETE")
        frame = obj.Dev_ctrl_frame;
        frame.delete;
    end

end

properties (Access = private)
    Dev_ctrl_frame matlab.ui.container.Panel
end

end


function Device_control_frame = create_control_frame(Control_Frame, Position_in_ctrl_frame)

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
                       'UserData', UserData_temp, ...
                       'Enable', 'inactive');
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
    
    Device_control_frame = Device_temp_frame;

end






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















