%this function returns each frequency multiplyed by its normalized power 
function spectralMoment = spectralMoment(Data,f)
    spectralMoment = f*Data.CurrData.pWelchResNorm;
end