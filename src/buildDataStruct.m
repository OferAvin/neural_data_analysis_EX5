% build struct with the data from the files
%for each patient load his data
function Data = buildDataStruct(files,numOfPatient,location)
    Data = struct();
    for i = 1:numOfPatient
       curPatient = char("patient" + i);
       s = strcat(location,(files(i).name));
       Data.(curPatient) = load(s); 
    end
end
