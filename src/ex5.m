tic
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
waves = extractWaves(delta, theta, lowAlpha, highAlpha, beta, gamma, f);

numOfElctrodes = 19;
FeatPerElctrodes = 18;
numOfFeat = numOfElctrodes*FeatPerElctrodes;
edgePrct = 90;          %spectral edge percentaile


subNum = 1;
%% files parameters
filesPath = '..\DATA_DIR\**\';
extension = 'mat';
containedCahr = 'p*\d*_*s*\d';

% currElctrode = 5;
nOfFeat = 1;
index = 1;

[Data,nPatients] = structFromFileName(filesPath, extension, containedCahr);

%load raw data

for subNum = 1:nPatients
    
    Data = loadData(Data,subNum);
    currSub = char("patient" + subNum);
        
    for currElctrode = 1:numOfElctrodes

        % split data into windows
        allWindowes = splitSignal(Data,signalWindow,stepWindow,currElctrode,Fs);
        nWindows = size(allWindowes,2); 

        %calculating pWelch

        [Data.CurrData.pWelchRes,Data.CurrData.pWelchResNorm] = ...
            calcPwelch(allWindowes,pwelchWindow,pwelchOverlap,f,Fs);

        % collceting features
        if currElctrode == 1
            Data.(currSub).feat = zeros(numOfFeat,size(Data.CurrData.pWelchRes,2));
        end

        % calculating relative power and relative log power for each freq bend
        for j = 1:nFreqBands
            Data.(currSub).feat(index,:) = extractRelativePower(Data.CurrData.pWelchRes,(waves(j)));
            Data.(currSub).feat(index+nFreqBands,:) = relativeLogPower(Data.CurrData.pWelchRes,(waves(j)));
            index = index + 1;  %updating index
        end
        index = index + nFreqBands;  %updating index

        % calculating root Total Power
        Data.(currSub).feat(index,:) = rootTotalPower(Data.CurrData.pWelchRes);
        index = index + 1;  %updating index

        % calculating spectral Slop and Intercept
        [Data.(currSub).feat(index,:),Data.(currSub).feat(index+1,:)] =...
            spectralSlopIntercept(Data.CurrData.pWelchRes,nWindows,f);
        index = index + 2;

        % calculating spectral Moment
        Data.(currSub).feat(index,:)= spectralMoment(Data,f);
        index = index + 1;

        % calculating spectral Edge
        Data.(currSub).feat(index,:) = spectralEdge(Data,f,edgePrct);
        index = index + 1;

        % calculating spectral Entropy
        Data.(currSub).feat(index,:) = spectralEntropy(Data.CurrData.pWelchResNorm);
        index = index + 1;  %updating index
    end



    %     meanVecPerFeat = mean(Data.(currSub).feat,2);
    %     stdVecPerFeat = std(Data.(currSub).feat,[],2);
    %     Data.(currSub).feat = Data.(currSub).feat- meanVecPerFeat;
    %     Data.(currSub).feat = Data.(currSub).feat./stdVecPerFeat;


    Data.(currSub).feat = (zscore(Data.(currSub).feat,0,2));

    %% PCA

    Data.(currSub).feat = Data.(currSub).feat - mean(Data.(currSub).feat,2);  
    C = Data.(currSub).feat*Data.(currSub).feat'/nWindows-1;
    [EV,D] = eigs(C,3);
    Data.(currSub).PCA = EV' * Data.(currSub).feat;

    eigenvalues = diag(D);
    % eigenvaluesSort = sort(eigenvalues,'descend');
    % Encoding
    %y = V'*(


    figure('Units','normalized','Position',[0 0 1 1]);
%    sgtitle(Data.(currSub).pNum);
    hold on;
    subplot(1,2,1)
    scatter(Data.(currSub).PCA(1,:),Data.(currSub).PCA(2,:),20,1:nWindows,'filled');
    colorbar;

    subplot(1,2,2)
    scatter3(Data.(currSub).PCA(1,:),Data.(currSub).PCA(2,:),Data.(currSub).PCA(3,:),20,1:nWindows,'filled');
    colorbar;
    hold off;
end
toc

