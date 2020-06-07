% this function splits the data of a specific electrode to windows
% according to window size and the window step. 
function allWindowes = splitSignal(Data,signalWindow,stepWindow,currElctrode,Fs)
    overlap = calcOverLap(signalWindow,stepWindow);
    [allWindowes,~] = buffer(Data.CurrData.rawData(currElctrode,:) ,signalWindow*Fs ,overlap*Fs, 'nodelay');
end