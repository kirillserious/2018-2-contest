function yVec = func1(xVec)
    yVec = (1 - cos(xVec).^2) ./ xVec;
    yVec(isnan(yVec)) = 0;
end