
function [Data,numOfPatient] = structFromFileName(path, extension, charToValidate)
    MyFiles = dir([path '*.' extension]);       
    validateFileNames = cellfun('isempty',regexp({MyFiles.name},charToValidate));   %check for files that contains charToValidate
    MyFiles(validateFileNames == 1) = [];       
    numOfPatient = length(MyFiles);
    
    % build struct with the data from the files
    Data = buildDataStruct(MyFiles,numOfPatient);
    Data.MyFiles = MyFiles;
end