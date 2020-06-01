function overLap = calcOverLap(windowSize,step)
    ratio = step/windowSize;
    overLap = (1-ratio)*windowSize;
end
