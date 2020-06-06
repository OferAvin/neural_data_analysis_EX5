%this function gets a power spectrum and a bend as input and returns the
%relative power of that bend
function relativePower = extractRelativePower(specPower,freqBend)
    bend = specPower(cell2mat(freqBend),:);
    bendPower = sum(bend,1);
    totalPower = sum(specPower,1);
    relativePower = bendPower./totalPower; 
end
