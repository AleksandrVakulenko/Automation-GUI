
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
Main_figure = figure('position', Main_fig_position, ...
                     'Resize', Resizable, ...
                     'CloseRequestFcn', @figure_close_req_Callback, ... 
                     'DeleteFcn', @figure_del_Callback, ...
                     'MenuBar', 'none');
% add menues
m = uimenu('Text','Options');
mitem = uimenu(m,'Text','Reset', 'MenuSelectedFcn', @Reset_click);

% and frame for five control frames
Control_Frame = uipanel('parent', Main_figure, 'position', [0.7 0.0 0.3 1.0]);




% Creation of Temperature control textbox
% in Control_Frame on position 2
Temp_control_frame = Device_control_frame(Control_Frame, 1);




% TODO: add action for figure close
function figure_del_Callback(src, event)
    disp('fig closed')
end

function figure_close_req_Callback(src, event)
    disp('try to close fig')
    src.delete;
end


function Reset_click(arc, event)
    disp('Nyan!')
end




