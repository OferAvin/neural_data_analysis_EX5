function specMetrixNorm = calcPwelch(signalWindowed,pwelchWindow,f,Fs)
    specMetrix = pwelch(signalWindowed ,pwelchWindow*Fs, pwelchOverlap*Fs ,f ,Fs);
    specMetrixNorm = specMetrix./(sum(specMetrix,1));
end