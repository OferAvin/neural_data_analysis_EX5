function relativePower = extractRelativePower(specPower,freqBend)
    relative = specPower(freqBend,:);
    relativePower = sum(relative,1);
    powerSum = sum(specPower,1);
    relativePower = relativePower/powerSum;
      
end
