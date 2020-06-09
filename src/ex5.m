tic
%MATLAB 2019a
clear all
close all

%% expariment param
%data
Fs = 250;
f = 1:0.1:40;
windLen = 40;               % signal length in secs
windStep = 20;              % window step in secs
pwelchWindow = 5;           %window length in secs
pwelchOverlap = 1;          %window overlap length in secs
numOfElctrodes = 19;

%bends
nFreqBands = 6;
delta = 1:0.1:4.5;
theta = 4.5:0.1:8;
lowAlpha = 8:0.1:11.5;
highAlpha = 11.5:0.1:15;
beta = 15:0.1:30;
gamma = 30:0.1:40;
waves = extractWavesIdx(delta, theta, lowAlpha, highAlpha, beta, gamma, f);

% features
featPerElctrodes = 18;
numOfFeat = numOfElctrodes*featPerElctrodes;
edgePrct = 90;          %spectral edge percentaile

% pca
dimReductionTo = 3;     %pca will reduce data dim to that number

%files parameters
filesPath = '..\DATA_DIR\';
extension = 'mat';
containedCahr = 'p*\d*_*s*\d';



%% Start proccess

[Data,nPatients] = structFromFileName(filesPath, extension, containedCahr);

%% start process

for subNum = 1:nPatients
    
    Data = loadData(Data,subNum);
    currSub = char("patient" + subNum);
    
    nextFeatIdx = 1;
    for currElctrode = 1:numOfElctrodes

        % split data into windows
        ratio = windStep/windLen;
        overlap = (1-ratio)*windLen;
        [allWindowes,~] = buffer(Data.CurrData.rawData(currElctrode,:) ,windLen*Fs ,overlap*Fs, 'nodelay');
        nWindows = size(allWindowes,2); 
        
        
        %calculating pWelch
        Data.CurrData.pWelchRes = pwelch(allWindowes ,pwelchWindow*Fs, pwelchOverlap*Fs ,f ,Fs);
        Data.CurrData.pWelchResNorm = Data.CurrData.pWelchRes./(sum(Data.CurrData.pWelchRes,1));

        %% collceting features
        if currElctrode == 1
            Data.(currSub).feat = zeros(numOfFeat,size(Data.CurrData.pWelchRes,2));     %allocating feature matrix
        end
        
        % calculating relative power and relative log power for each freq bend
        for j = 1:nFreqBands
            Data.(currSub).feat(nextFeatIdx,:) = extractRelativePower(Data.CurrData.pWelchRes,(waves(j)));
            Data.(currSub).feat(nextFeatIdx+nFreqBands,:) = relativeLogPower(Data.CurrData.pWelchRes,(waves(j)));
            nextFeatIdx = nextFeatIdx + 1;  
        end
        nextFeatIdx = nextFeatIdx + nFreqBands;  

        % calculating root Total Power
        Data.(currSub).feat(nextFeatIdx,:) = rootTotalPower(Data.CurrData.pWelchRes);
        nextFeatIdx = nextFeatIdx + 1;  

        % calculating spectral Slop and Intercept
        [Data.(currSub).feat(nextFeatIdx,:),Data.(currSub).feat(nextFeatIdx+1,:)] =...
            spectralSlopIntercept(Data.CurrData.pWelchRes,nWindows,f);
        nextFeatIdx = nextFeatIdx + 2;

        % calculating spectral Moment
        Data.(currSub).feat(nextFeatIdx,:)= spectralMoment(Data,f);
        nextFeatIdx = nextFeatIdx + 1;

        % calculating spectral Edge
        Data.(currSub).feat(nextFeatIdx,:) = spectralEdge(Data,f,edgePrct);
        nextFeatIdx = nextFeatIdx + 1;

        % calculating spectral Entropy
        Data.(currSub).feat(nextFeatIdx,:) = spectralEntropy(Data.CurrData.pWelchResNorm);
        nextFeatIdx = nextFeatIdx + 1;  
    end
    
    Data.(currSub).feat = (zscore(Data.(currSub).feat,0,2));

    %% PCA

    Data.(currSub).feat = Data.(currSub).feat - mean(Data.(currSub).feat,2);  
    C = Data.(currSub).feat*Data.(currSub).feat'./(nWindows-1);
    [EV,D] = eigs(C,dimReductionTo);
    Data.(currSub).PCA = EV' * Data.(currSub).feat;
    

    
    %% Plots
    figure('Units','normalized','Position',[0 0 1 1]);
    ttl = ['Patient ' Data.(currSub).pNum ', ' 'Seizure ' Data.(currSub).sNum];
    sgtitle(ttl);
    hold on;
    
    windTimeTillSeij = flip(-(windLen-windStep:windStep:nWindows*windStep)./60); %windows start time when 0 is the seijure time
    
    subplot(1,2,1);
    scatter(Data.(currSub).PCA(1,:),Data.(currSub).PCA(2,:),15,windTimeTillSeij,'filled');
    xlabel('PC-1','FontSize',12);
    ylabel('PC-2','FontSize',12);
    
    subplot(1,2,2);
    scatter3(Data.(currSub).PCA(1,:),Data.(currSub).PCA(2,:),Data.(currSub).PCA(3,:),15,windTimeTillSeij,'filled');
    xlabel('PC-1','FontSize',12);
    ylabel('PC-2','FontSize',12);
    zlabel('PC-3','FontSize',12);   
    
    cb = colorbar; colormap(hot);
    cb.Label.String = "time to seizure[min]";
    cb.Label.FontSize = 15;
    caxis([-100 0]);
    hold off;
end
toc

