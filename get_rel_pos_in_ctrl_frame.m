function pos_arr = get_rel_pos_in_ctrl_frame(N)
N = round(N(1));
if (N > 5) || (N < 1)
    error('N must be integer number in range [1; 5]')
end
Rel_pos_in_ctrl_frame = ((5-N)) * 0.2;
pos_arr = [0.0 Rel_pos_in_ctrl_frame 1.0 0.2];
end