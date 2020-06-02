function spectralMoment = spectralMoment(Data,f)
    spectralMoment = sum(f*Data.CurrData.pWelchResNorm,1);
end