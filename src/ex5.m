%MATLAB 2019a
clear all
close all

%% expariment param
Fs = 250;
f = 1:0.1:40;
signalWindow = 40;          % signal length in secs
stepWindow = 20;            % signal overlap in secs
pwelchWindow = 5;           %window length in secs
pwelchOverlap = 1;          %window overlap length in secs

nFreqBands = 6;
delta = 1:0.1:4.5;
theta = 4.5:0.1:8;
lowAlpha = 8:0.1:11.5;
highAlpha = 11.5:0.1:15;
beta = 15:0.1:30;
gamma = 30:0.1:40;

numOfElctrodes = 19;
FeatPerElctrodes = 18;
numOfFeat = numOfElctrodes*FeatPerElctrodes;

dataPath = '..\DATA_DIR\';

subNum = 1;
currElctrode = 5;
currSub = "patient1";


MyFiles = dir('..\DATA_DIR\**\*.mat');       %take files in that path which ands with .mat
%ensure files validity
charToValidate = 'p*\d*_*s*\d';            
validateFileNames = cellfun('isempty',regexp({MyFiles.name},charToValidate));   %check for files that contains charToValidate
MyFiles(validateFileNames == 1) = [];       %delete non matching files
numOfPatient = length(MyFiles);
% build struct with the data from the files
Data = buildDataStruct(numOfPatient);


%% load raw data
Data = loadData(Data,MyFiles,subNum);

%% split data into windows
overlap = calcOverLap(signalWindow,stepWindow);
signalWindowed = buffer(Data.CurrData.rawData(currElctrode,:) ,signalWindow*Fs ,overlap*Fs, 'nodelay');

%% calculating pWelch
Data.CurrData.pWelchRes = calcPwelch(Data,signalWindowed,pwelchWindow,f,Fs);

Data.(currSub) = zeros(numOfFeat,size(Data.CurrData.pWelchRes,2));

delta_idx = find(f >= delta(1) & f <= delta(end));
theta_idx = find(f > theta(1) & f <= theta(end));
alpha_idx = find(f > lowAlpha(1) & f <= highAlpha(end));
beta_idx = find(f > beta(1) & f <= beta(end));
gamma_idx = find(f > gamma(1) & f <= gamma(end));


relativePower = extractRelativePower(specMetrix,delta_idx);
