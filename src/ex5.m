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
delta = 1:0.1:4.5;
theta = 4.5:0.1:8;
lowAlpha = 8:0.1:11.5;
highAlpha = 11.5:0.1:15;
beta = 15:0.1:30;
gamma = 30:0.1:40;
nFreqBands = 6;
location = '..\DATA_DIR\';


MyFiles = dir('..\DATA_DIR\**\*.mat');       %take files in that path which ands with .mat
%ensure files validity
charToValidate = 'p*\d*_*s*\d';            
validateFileNames = cellfun('isempty',regexp({MyFiles.name},charToValidate));   %check for files that contains charToValidate
MyFiles(validateFileNames == 1) = [];       %delete non matching files
numOfPatient = length(MyFiles);
% build struct with the data from the files
Data = buildDataStruct(MyFiles,numOfPatient,location);

overLap = calcOverLap(signalWindow,stepWindow);
signalWindowed = buffer(Data.patient1.data(5,:) ,40*Fs ,overLap*Fs, 'nodelay');
specMetrix = pwelch(signalWindowed ,windowSec*Fs, overlapSec*Fs ,f ,Fs);
pNorm = specMetrix/(sum(specMetrix,1));

delta_idx = find(f >= delta(1) & f <= delta(end));
theta_idx = find(f > theta(1) & f <= theta(end));
alpha_idx = find(f > lowAlpha(1) & f <= highAlpha(end));
beta_idx = find(f > beta(1) & f <= beta(end));
gamma_idx = find(f > gamma(1) & f <= gamma(end));


relativePower = extractRelativePower(specMetrix,delta_idx);
