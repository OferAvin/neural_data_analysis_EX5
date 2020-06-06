
clc; clear; close all;

%% load patients parameters
sub_dir = dir('../DATA_DIR/**/*'); %directory of patients data
[subj] = file_load(sub_dir); %function to create struct based on subjects infomation
sub_names = fieldnames(subj); %subject name var
N_subj = length(sub_names); %number of subjects

%% parameter
f = 1:0.1:40; %Hz, frequency band vector
subj.curr_data = struct; %struct for current data
fs = 250; %Hz. sampling rate
win_time = 40; %sec
overlap_time = 20; %sec
win_size = win_time*fs; %number of samples per window
overlap = overlap_time*fs; %number of samples in overlap
dim_num = 3; %pca reduction dim

% frequency band for different wave length
freq.delta = 1:0.1:4.5;
freq.theta = 4.5:0.1:8;
freq.low_alpha = 8:0.1:11.5;
freq.high_alpha = 11.5:0.1:15;
freq.beta = 15:0.1:30;
freq.gamma = 30:0.1:40;
freq_name = fieldnames(freq); %names of waves
N_freq = length(freq_name); %number of waves

%% feature extraction
for sub_i = 1:N_subj
    sub_idx = subj.(char(sub_names(sub_i))).idx; %get idx of subject in sub_dir
    subj.curr_data = load([sub_dir(sub_idx).folder '\' sub_dir(sub_idx).name]); %load current subject data
    N_elec = size(subj.curr_data.data,1); %number of electrodes in data
    sample_dur = size(subj.curr_data.data,2)/fs/60; %min. duration of recording
    N_feat = N_elec*(2*N_freq + 6); %number of features
    idx = 1;
    for elec_i = 1:N_elec
        [pwr,N_win] = get_pwr(subj.curr_data.data(elec_i,:),f,win_size,overlap,fs);
        if elec_i == 1
            subj.(char(sub_names(sub_i))).feat = zeros(N_feat,N_win);
            t = 0:sample_dur/N_win:sample_dur;
            t = t(1:end-1);
        end
        [sum_pwr,sum_log_pwr,sum_log_wave,sum_wave,norm_pwr] = sum_power(pwr,freq,f);
        for freq_i = 1:N_freq
            subj.(char(sub_names(sub_i))).feat(idx:idx+1,:) = ...
                relative_power(sum_wave.(char(freq_name{freq_i})),sum_pwr,sum_log_wave.(char(freq_name{freq_i})),sum_log_pwr); 
            idx = idx + 2;
        end 
        subj.(char(sub_names(sub_i))).feat(idx,:) = sqrt(sum_pwr); 
        idx = idx + 1;
        for win_i = 1:size(pwr,2)
            subj.(char(sub_names(sub_i))).feat(idx:idx+1,win_i)...
                = polyfit(log(f)',log(pwr(:,win_i)),1)';
        end 
        idx = idx + 2;
        subj.(char(sub_names(sub_i))).feat(idx,:) = f*norm_pwr;
        idx = idx + 1;
        for win_i = 1:size(pwr,2)
            subj.(char(sub_names(sub_i))).feat(idx,win_i) = f(find(cumsum(norm_pwr(:,win_i))>0.9,1));
        end
        idx = idx + 1;
        subj.(char(sub_names(sub_i))).feat(idx,:) = -sum(norm_pwr.*log2(norm_pwr),1);
        idx = idx + 1;
    end
    subj.(char(sub_names(sub_i))).feat = zscore(subj.(char(sub_names(sub_i))).feat,0,2);
    subj.(char(sub_names(sub_i))).comp = pca_red(subj.(char(sub_names(sub_i))).feat,dim_num);
    pca_plot(subj.(char(sub_names(sub_i))),t,sub_i,(char(sub_names(sub_i))));
end 


       

