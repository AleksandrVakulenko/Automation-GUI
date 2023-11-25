% Converts string to numerical value.
% If where is no num value in string it is set to default value.
% Limits the output value to min/max (if provided)
% to use only Max limit, pass NaN to 3rd argument;
% Input arguments:
% 1) String
% 2) default_value
% 3) min_value (optionaly)
% 4) max_value (optionaly)
function Num_value = String_to_numerical(String, default_value, varargin)
if nargin > 4
    error('Too many input arguments in String_to_numerical()')
end

if nargin >= 3
    Min_value = varargin{1};
else
    Min_value = NaN;
end

if nargin == 4
    Max_value = varargin{2};
else
    Max_value = NaN;
end

Num_value = str2num(String);

Corrupted_input = false;
Is_empty = logical(isempty(Num_value));
if ~Is_empty
    Is_nan = logical(isnan(Num_value));
    Is_inf = isinf(Num_value);
    if Is_nan || Is_inf
        Corrupted_input = true;
    end
else
    Corrupted_input = true;
end

if Corrupted_input
    Num_value = default_value;
end

if Num_value < Min_value
    Num_value = Min_value;
end
if Num_value > Max_value
    Num_value = Max_value;
end

end

