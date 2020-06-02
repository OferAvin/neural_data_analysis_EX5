function spectralEdge = spectralEdge(Data,f,prct)
    indices = diff(cumsum(Data.CurrData.pWelchResNorm)>prct/100);
    [~,indices] = max(indices);
    spectralEdge = f(indices);
end