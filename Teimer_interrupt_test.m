


Timer = timer('Name', 'Nyan_timer', ...
              'ExecutionMode', 'fixedRate', ...
              'Period', 0.1, ...
              'TimerFcn', @timer_callback, ...
              'TasksToExecute', inf);

clc
Duration = 3; % s
% 
Timer_2 = tic;
stop = 0;
Timer.start;
while ~stop
    Time = toc(Timer_2);
    if Time > Duration
        stop = 1;
    end

end
Timer.stop;
Timer.delete;
% 'done'

% timerfindall

function timer_callback(src, event)
src.InstantPeriod
% event.Data
% disp('nyan');

end














