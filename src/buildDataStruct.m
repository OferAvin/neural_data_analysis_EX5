% build struct with the data from the files
%for each patient load his data
function Data = buildDataStruct(numOfPatient)
    Data = struct();
    for i = 1:numOfPatient
       curPatient = char("patient" + i);
       Data.(curPatient) = 0;
    end
    Data.CurrData.rawData = 0;
    Data.CurrData.pWelchRes = 0;
end
