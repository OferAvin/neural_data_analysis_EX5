%this function gets the data file's path extensions and chars its must
%contain. it extracts the files from the path validate file names and than
%build a structure for the expirament data.
function [Data,numOfPatient] = structFromFileName(path, extension, charToValidate)
    MyFiles = dir([path '*.' extension]);       
    validateFileNames = cellfun('isempty',regexp({MyFiles.name},charToValidate));%check for files that contains charToValidate
    MyFiles(validateFileNames == 1) = [];       
    numOfPatient = length(MyFiles);
    
    % build struct with the data from the files
    Data = buildDataStruct(MyFiles,numOfPatient);
    Data.MyFiles = MyFiles;
end