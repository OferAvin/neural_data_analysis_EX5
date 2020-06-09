% this function get the normalized power, treat him as probability and
% compute its entropy
function spectralEntropyVec =  spectralEntropy(pNorm)
   spectralEntropyVec = -(sum((pNorm.*log2(pNorm)),1)); 
end