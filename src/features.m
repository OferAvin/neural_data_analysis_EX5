function features = features()
    features = strings([1,18]);
    
    features(1) = "deltaPow";
    features(2) = "thetaPow";
    features(3) = "lowAlphaPow";
    features(4) = "highAlphaPow";
    features(5) = "betaPow";
    features(6) = "gammaPow";
    
    features(7) = "deltaLogPow";
    features(8) = "thetaLogPow";
    features(9) = "lowAlphaLogPow";
    features(10) = "highAlphaLogPow";
    features(11) = "betaLogPow";
    features(12) = "gammaLogPow";
    
    features(13) = "rootTotalPow";
    
    features(14) = "slope";
    features(15) = "intercept";
    
    features(16) = "spectralMoment";
    features(17) = "spectralEdge";
    features(18) = "spectralEntropy";
end