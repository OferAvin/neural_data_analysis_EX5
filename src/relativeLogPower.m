function RLPower = relativeLogPower(specPower,freqBend)
    relative = specPower(cell2mat(freqBend),:);
    totalPower = sum(relative,1);
    logRelativePower = log(exp(1).*totalPower./min(totalPower));
    powerSum = sum(specPower,1);
    logPower = log(exp(1).*powerSum./min(powerSum));
    RLPower = logRelativePower./logPower;   
end
