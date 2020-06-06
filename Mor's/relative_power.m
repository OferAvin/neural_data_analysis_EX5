function[features] = relative_power(sum_wave,sum_pwr,sum_log_wave,sum_log_pwr)

features(1,:) = sum_wave./sum_pwr;
features(2,:) = sum_log_wave./sum_log_pwr;



