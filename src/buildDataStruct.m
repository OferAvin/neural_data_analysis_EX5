% build struct with the data from the files
%for each patient load his data
function Data = buildDataStruct(Files,numOfPatient)
    Data = struct();
    for i = 1:numOfPatient
        pNum = char(extractBetween(Files(i).name,"p","_"));
        curPatient = char("patient" + i);
        Data.(curPatient).pNum = pNum;
        Data.(curPatient).feat = 0;
        Data.(curPatient).PCA = 0;
    end
    Data.CurrData.rawData = 0;
    Data.CurrData.pWelchRes = 0;
    Data.CurrData.pWelchResNorm = 0;
end
