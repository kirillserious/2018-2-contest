function yVec = func2(xVec)
    yVec = xVec .* exp(-2*xVec.^2);
end