%MATLAB 2019a
clear all
close all

%% expariment param
Fs = 250;
f = 1:0.1:40;
signalWindow = 40;          % signal length in secs
stepWindow = 20;            % signal overlap in secs
windowSec = 5;              %window length in secs
overlapSec = 1;             %window overlap length in secs
location = '..\DATA_DIR\';


MyFiles = dir('..\DATA_DIR\**\*.mat');       %take files in that path which ands with .mat
%ensure files validity
charToValidate = 'p*\d*_*s*\d';            
validateFileNames = cellfun('isempty',regexp({MyFiles.name},charToValidate));   %check for files that contains charToValidate
MyFiles(validateFileNames == 1) = [];       %delete non matching files
numOfPatient = length(MyFiles);
Data = struct();
for i = 1:numOfPatient
   curPatient = char("patient" + i);
   s = strcat(location,(MyFiles(i).name));
   Data.(curPatient) = load(s); 
end
overLap = calcOverLap(signalWindow,stepWindow);
signalWindowed = buffer(Data.patient1.data(3,:) ,40*Fs ,overLap*Fs, 'nodelay');
specVec = pwelch(signalWindowed ,window_sz , overlap_sz ,Fs ,f)';


