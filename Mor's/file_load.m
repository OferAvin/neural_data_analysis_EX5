function[subj,sub_name] = file_load(sub_dir)

% function that receives path of edf files and returns the subject's names,
% the type of record (eyes open EO/ eyes closed EC), and data from edfread
% function- hdr and record for each file

% idx for the variables

subj = struct;


% variables allocation
N = length(sub_dir);


for i = 1:N %loop through all files in path
    %check if current file fits the convention of file naming- has a number
    %in it, letters EC/EO and ends with edf
    format_chk = regexp(sub_dir(i).name,'p\d*_s\d*.mat','match');
    
    %if format_chk is not empty, meaning the file fits the convention
    if ~isempty(format_chk)
        sub_name(i) = regexp(sub_dir(i).name,'p\d+','match'); %extract subject's name
        subj.(char(sub_name(i))) = struct;
        subj.(char(sub_name(i))).seiz_num = char(regexp(sub_dir(i).name,'s\d+','match')); %extract type of record
        subj.(char(sub_name(i))).idx = i;
    end
end 




    
    
    