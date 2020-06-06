function[pwr,N_win] = get_pwr(signal,f,win_size,overlap,fs)

[win_signal,lefto] = buffer(signal,win_size,overlap,'nodelay');

p_win_time = 2; %sec
p_overlap_time = 0.5; %sec
p_win_size = p_win_time*fs;
p_overlap = p_overlap_time*fs;

pwr = pwelch(win_signal,p_win_size,p_overlap,f,fs);

N_win = size(pwr,2);


