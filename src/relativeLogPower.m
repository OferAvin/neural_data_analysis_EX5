function RLPower = relativeLogPower(specPower,freqBend)
    relative = specPower(cell2mat(freqBend),:);
    relativePower = sum(relative,1);
    logRelativePower = log(exp(1).*relativePower./min(relativePower));
    powerSum = sum(specPower,1);
    logPower = log(exp(1).*powerSum./min(powerSum));
    RLPower = logRelativePower./logPower;   
end
