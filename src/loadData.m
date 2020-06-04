function Data = loadData(Data,subNum)
    s = strcat(Data.MyFiles(subNum).folder,'\',(Data.MyFiles(subNum).name));
    tmpData = load(s);
    dataFieldName = fieldnames(tmpData);
    Data.CurrData.rawData = tmpData.(dataFieldName{1});
end