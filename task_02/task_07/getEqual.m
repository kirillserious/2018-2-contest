function pointVec = getEqual (fFunc, gFunc, t0, t1, N)
    timeVec = getTime(fFunc, gFunc, t0, t1, N);
    fVec = fFunc(timeVec);
    gVec = gFunc(timeVec);
    pointVec = cat(2, fVec, gVec);
end

function timeVec = getTime(fFunc, gFunc, t0, t1, N)
    sysFunc = @(deltaTimeVec) systemFunc(deltaTimeVec, fFunc, gFunc, t0, t1);
    deltaTime0Vec = zeros(N-1, 1);
    
    deltaTimeVec = fsolve(sysFunc, deltaTime0Vec);
    timeVec = cat(1, t0,  t0 + cumsum(abs(deltaTimeVec)));
end

function res = systemFunc(deltaTVec, fFunc, gFunc, t0, t1)
    deltaTVec = abs(deltaTVec);
    tVec = t0 + cumsum(deltaTVec);
    tVec = cat(1, t0, tVec);
    fVec = fFunc(tVec);
    gVec = gFunc(tVec);
    A = ( fVec(1:end-2) - fVec(2:end-1) ).^2;
    B = ( gVec(1:end-2) - gVec(2:end-1) ).^2;
    C = ( fVec(2:end-1) - fVec(3:end)   ).^2;
    D = ( gVec(2:end-1) - gVec(3:end)   ).^2;
    
    res = A + B - C - D;
    res = cat(1, res, t1 - tVec(end));
end