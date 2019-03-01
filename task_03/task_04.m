fFun = @(x) sqrt(x) - tan(x);

X = linspace(1, 20, 1000);
middleVec = 0:pi:20;

rightFun = @(x) tan(x);
leftFun = @(x) sqrt(x);
Y1 = leftFun(X);
Y2 = rightFun(X);
Y2(abs(Y2) > abs(Y1) + 10) = NaN;
hold on;
plot(X, Y1, 'g', X, Y2, 'b');

[x0, y0] = ginput(1);

[~, middleI] = min(abs(middleVec - x0));

xSolve1 = fzero(fFun, middleVec(middleI));
xSolve2 = fzero(fFun, middleVec(middleI+1));
xSolve3 = fzero(fFun, middleVec(middleI-1));

xSolve = [xSolve1, xSolve2, xSolve3];
[~, minI] = min(abs(xSolve - x0));

ySolve = leftFun(xSolve(minI));
plot(xSolve(minI), ySolve, 'r*');
disp(xSolve);
hold off;