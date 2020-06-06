function[sum_pwr,sum_log_pwr,sum_log_wave,sum_wave,norm_pwr] = sum_power(pwr,freq,f)
freq_name = fieldnames(freq);
N_freq = length(freq_name);
sum_pwr = sum(pwr,1);
log_pwr = log(exp(1).*pwr./min(pwr));
sum_log_pwr = sum(log_pwr,1);
norm_pwr = pwr./sum_pwr;

for i = 1:N_freq
    range = (f>=freq.(freq_name{i})(1) & f<=freq.(freq_name{i})(end));
    freq.(freq_name{i}) = f(range);
    pwr_range = pwr(range,:);
    log_pwr_range = log(exp(1).*pwr_range./min(pwr_range));
    sum_log_wave.(char(freq_name(i))) = sum(log_pwr_range,1);
    sum_wave.(char(freq_name(i))) = sum(pwr_range,1);
end 