function RLPower = relativeLogPower(specPower,freqBend)
    relative = specPower(cell2mat(freqBend),:);
    logPower = log(exp(1).*relative./min(relative));
    logTotalPower = sum(logPower,1);
    %logTotalPower = log(exp(1).*totalPower./min(totalPower));
    %powerSum = sum(specPower,1);
    logPower = log(exp(1).*specPower./min(specPower));
    logPowerSum = sum(logPower,1);
    RLPower = logTotalPower./logPowerSum;   
end
