% build struct with the data from the files
%for each patient load his data
function Data = buildDataStruct(files,numOfPatient,location)
    Data = struct();
    %for i = 1:numOfPatient
       curPatient = char("patient");
       s = strcat(location,(files(1).name));
       Data.(curPatient) = load(s); 
    %end
end
