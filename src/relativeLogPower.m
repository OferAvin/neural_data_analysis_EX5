function RLPower = relativeLogPower(specPower,freqBend)
    relative = specPower(cell2mat(freqBend),:);
    logRelative = log(exp(1).*relative./min(relative));
    logRelativePower = sum(logRelative,1);
    logPower = log(exp(1).*specPower./min(specPower));
    powerSum = sum(logPower,1);
    RLPower = logRelativePower./powerSum;   
end
