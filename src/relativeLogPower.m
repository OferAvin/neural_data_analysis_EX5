%this function gets a power spectrum and a bend as input and returns the
%log relative power of that bend
function RLPower = relativeLogPower(specPower,freqBend)
    bend = specPower(cell2mat(freqBend),:);
    logBend = log(exp(1).*bend./min(bend));
    logBendPower = sum(logBend,1);
    %logTotalPower = log(exp(1).*totalPower./min(totalPower));
    %powerSum = sum(specPower,1);
    logPower = log(exp(1).*specPower./min(specPower));
    logTotalPower = sum(logPower,1);
    RLPower = logBendPower./logTotalPower;   
end
