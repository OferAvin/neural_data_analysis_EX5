function relativePower = extractRelativePower(specPower,freqBend)
    relative = specPower(freqBend,:);
    powerSum = sum(specPower,1);
    relativePower = relative/powerSum;
end
