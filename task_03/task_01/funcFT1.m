function yVec = funcFT1(lambdaVec)
    yVec = lambdaVec;
    yVec(lambdaVec == 2) = -pi*1i/4;
    yVec(lambdaVec == -2) = pi*1i/4;
    yVec(lambdaVec > -2 & lambdaVec < 0) = pi*1i/2;
    yVec(lambdaVec > 0 & lambdaVec < 2) = -pi*1i/2;
    yVec((lambdaVec < -2) | abs(lambdaVec) < 10^(-10) | (lambdaVec > 2)) = 0;

end