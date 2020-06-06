%this function gets a power spectrum as input and returns the root total
%power as output
function RTP = rootTotalPower(pWelchRes)
    power = sum(pWelchRes,1);
    RTP = sqrt(power);
end
