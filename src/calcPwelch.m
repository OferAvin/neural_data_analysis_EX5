
function [specMetrix,specMetrixNorm] = calcPwelch(signalWindowed,pwelchWindow,pwelchOverlap,f,Fs)
    specMetrix = pwelch(signalWindowed ,pwelchWindow*Fs, pwelchOverlap*Fs ,f ,Fs);
    specMetrixNorm = specMetrix./(sum(specMetrix,1));
end