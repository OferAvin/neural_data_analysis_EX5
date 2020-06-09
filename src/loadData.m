% this function get the data structure and the current patient and create
% the exact path to load the raw data from(temp data).
function Data = loadData(Data,subNum)
    s = strcat(Data.MyFiles(subNum).folder,'\',(Data.MyFiles(subNum).name));
    tmpData = load(s);
    dataFieldName = fieldnames(tmpData);
    Data.CurrData.rawData = tmpData.(dataFieldName{1});
end