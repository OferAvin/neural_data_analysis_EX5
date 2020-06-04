function spectralMoment = spectralMoment(Data,f)
    spectralMoment = f*Data.CurrData.pWelchResNorm;
end