function RTP = rootTotalPower(Data)
    sqrt(sum(Data.curData.pWelchRes,1));
end
