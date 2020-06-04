function RLPower = relativeLogPower(specPower,freqBend)
    relative = specPower(cell2mat(freqBend),:);
<<<<<<< HEAD
    totalPower = sum(relative,1);
    logRelativePower = log(exp(1).*totalPower./min(totalPower));
    powerSum = sum(specPower,1);
    logPower = log(exp(1).*powerSum./min(powerSum));
    RLPower = logRelativePower./logPower;   
=======
    logRelative = log(exp(1).*relative./min(relative));
    logRelativePower = sum(logRelative,1);
    logPower = log(exp(1).*specPower./min(specPower));
    powerSum = sum(logPower,1);
    RLPower = logRelativePower./powerSum;   
>>>>>>> 8ef2f9decd0d310e8d89466cd9f614df967a34f4
end
