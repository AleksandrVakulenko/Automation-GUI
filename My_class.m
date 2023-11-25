

classdef My_class < handle

methods (Access = 'public')
    function Obj = My_class()
        Obj.Timer = timer('Name', 'Nyan_timer', ...
                          'ExecutionMode', 'fixedRate', ...
                          'Period', 0.1, ...
                          'TimerFcn', @Obj.timer_callback, ...
                          'TasksToExecute', inf);
        Obj.Timer.start;
    end
    
    function delete(Obj)
        Obj.Timer.stop;
        Obj.Timer.delete;
    end
    
    function timer_callback(Obj, src, ~)
%         src.InstantPeriod
        Obj.Value = Obj.Value + 1;
    end

end

properties
    Timer timer;
    Str string = 'purr';
    Value double = 0;
end

end











































