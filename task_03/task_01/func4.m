function yVec = func4(xVec)
    yVec = exp(-5*abs(xVec)).*log(3+xVec.^4);
end