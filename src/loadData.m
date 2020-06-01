function Data = loadData(Data,MyFiles,subNum)
    s = strcat(dataPath,(MyFiles(subNum).name));
    tmpData = load(s);
    dataFieldName = fieldnames(tmpData);
    Data.CurrData.rawData = tmpData.(dataFieldName{1});
end