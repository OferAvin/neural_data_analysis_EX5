function RTP = rootTotalPower(pWelchRes)
    power = sum(pWelchRes,1);
    RTP = sqrt(power);
end
