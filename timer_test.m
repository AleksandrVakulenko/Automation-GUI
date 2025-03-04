
clc

CT = My_class;

%%

CT.Value
%%

figure
Data = [];
Time = [];

stop = 0;
tim = tic;

while ~stop
Data = [Data CT.Value];
Time = [Time toc(tim)];
cla
plot(Time, Data, '.')
drawnow
if toc(tim) > 5
    stop = 1;
end
end

%%

CT.Value
CT.delete;


