function spectralEntropyVec =  spectralEntropy(pNorm)
   spectralEntropyVec = -(sum((pNorm.*log2(pNorm)),1)); 
end