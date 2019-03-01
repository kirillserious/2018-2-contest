function yVec = funcFT2(lambdaVec)
    yVec = (-1i*(pi^0.5)) *lambdaVec .* exp(-lambdaVec.^2/8) / (4*(2^0.5));
end