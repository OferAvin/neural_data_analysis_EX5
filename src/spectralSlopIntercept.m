% this function fit a function for the ln power dependency on the ln frequency
%it returns the slope and intercept for each window
function [slopVec,interceptVec] = spectralSlopIntercept(specPower,nWindows,f)
    slopVec = zeros(1,nWindows);
    interceptVec = zeros(1,nWindows);
    logFreq = log(f);
    for i = 1:nWindows       
        p = polyfit(logFreq',log(specPower(:,i)),1); 
        slopVec(i) = p(1);
        interceptVec(i) = p(2);
    end
end
