function allWindowes = splitSignal(Data,signalWindow,stepWindow,currElctrode,Fs)
    overlap = calcOverLap(signalWindow,stepWindow);
    allWindowes = buffer(Data.CurrData.rawData(currElctrode,:) ,signalWindow*Fs ,overlap*Fs, 'nodelay');
    if allWindowes(end,end) ~= Data.CurrData.rawData(currElctrode,end)  %means padding accured 
        allWindowes(:,end) = [];
    end
end