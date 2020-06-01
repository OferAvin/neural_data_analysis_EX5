function allWindowes = splitSignal(Data,signalWindow,stepWindow,currElctrode,Fs)
    overlap = calcOverLap(signalWindow,stepWindow);
    allWindowes = buffer(Data.CurrData.rawData(currElctrode,:) ,signalWindow*Fs ,overlap*Fs, 'nodelay');
    if allWindowes(end,end) == 0
        allWindowes(:,end) = [];
    end
end