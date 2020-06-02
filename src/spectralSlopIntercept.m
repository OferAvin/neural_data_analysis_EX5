function [slopVec,interceptVec] = spectralSlopIntercept(specPower,nWindows,f)
    slopVec = zeros(1,nWindows);
    interceptVec = zeros(1,nWindows);
    logFreq = log(f);
    for i = 1:nWindows       
        p = polyfit(log(specPower(:,i)),logFreq',1); 
        slopVec(i) = p(1);
        interceptVec(i) = p(2);
    end
end
