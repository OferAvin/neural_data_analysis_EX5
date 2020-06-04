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
edgePrct = 90;          %spectral edge percentaile

dataPath = '..\DATA_DIR\';

subNum = 1;
% currElctrode = 5;
currSub = "patient1";
nOfFeat = 1;
index = 1;

% isolating freq bend range
delta_idx = find(f >= delta(1) & f <= delta(end));
theta_idx = find(f > theta(1) & f <= theta(end));
alphaLow_idx = find(f > lowAlpha(1) & f <= lowAlpha(end));
alphaHigh_idx = find(f > highAlpha(1) & f <= highAlpha(end));
beta_idx = find(f > beta(1) & f <= beta(end));
gamma_idx = find(f > gamma(1) & f <= gamma(end));

waveIdx = {delta_idx theta_idx alphaLow_idx alphaHigh_idx beta_idx gamma_idx};

MyFiles = dir('..\DATA_DIR\**\*.mat');       %take files in that path which ands with .mat
%ensure files validity
charToValidate = 'p*\d*_*s*\d';            
validateFileNames = cellfun('isempty',regexp({MyFiles.name},charToValidate));   %check for files that contains charToValidate
MyFiles(validateFileNames == 1) = [];       %delete non matching files
numOfPatient = length(MyFiles);
% build struct with the data from the files
Data = buildDataStruct(numOfPatient);


%% load raw data
Data = loadData(Data,MyFiles,subNum,dataPath);
for currElctrode = 1:numOfElctrodes

    %% split data into windows
    allWindowes = splitSignal(Data,signalWindow,stepWindow,currElctrode,Fs);
    nWindows = size(allWindowes,2); 

    %calculating pWelch

    [Data.CurrData.pWelchRes,Data.CurrData.pWelchResNorm] = ...
        calcPwelch(allWindowes,pwelchWindow,pwelchOverlap,f,Fs);

    if currElctrode == 1
        Data.(currSub) = zeros(numOfFeat,size(Data.CurrData.pWelchRes,2));
    end



    % calculating relative power and relative log power for each freq bend
    for j = 1:nFreqBands
        Data.(currSub)(index,:) = extractRelativePower(Data.CurrData.pWelchRes,(waveIdx(j)));
        Data.(currSub)(index+nFreqBands,:) = relativeLogPower(Data.CurrData.pWelchRes,(waveIdx(j)));
        index = index + 1;  %updating index
    end
    index = index + nFreqBands;  %updating index

    % calculating root Total Power
    Data.(currSub)(index,:) = rootTotalPower(Data.CurrData.pWelchRes);
    index = index + 1;  %updating index

    % calculating spectral Slop and Intercept
    [Data.(currSub)(index,:),Data.(currSub)(index+1,:)] =...
        spectralSlopIntercept(Data.CurrData.pWelchRes,nWindows,f);
    index = index + 2;

    % calculating spectral Moment
    Data.(currSub)(index,:)= spectralMoment(Data,f);
    index = index + 1;

    % calculating spectral Edge
    Data.(currSub)(index,:) = spectralEdge(Data,f,edgePrct);
    index = index + 1;

    % calculating spectral Entropy
    Data.(currSub)(index,:) = spectralEntropy(Data.CurrData.pWelchResNorm);
    index = index + 1;  %updating index
end
    

%     meanVecPerFeat = mean(Data.(currSub),2);
%     stdVecPerFeat = std(Data.(currSub),[],2);
%     Data.(currSub) = Data.(currSub)- meanVecPerFeat;
%     Data.(currSub) = Data.(currSub)./stdVecPerFeat;


Data.(currSub) = (zscore(Data.(currSub),0,2));

%% PCA

Data.(currSub) = Data.(currSub) - mean(Data.(currSub),2);  
C = Data.(currSub)*Data.(currSub)'/nWindows-1;
[V,D] = eigs(C,3);
eigenvalues = diag(D);
% eigenvaluesSort = sort(eigenvalues,'descend');
% Encoding
%y = V'*(


