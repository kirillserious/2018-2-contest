solFunc = @(x) exp(x) -2;

solinit = bvpinit(linspace(0,1,50),[1,0]);
solution = bvp4c(@odefun, @bcfun, solinit);

xVec = 0:0.01:1;
ySolMat = deval(solution, xVec);
ySolVec = ySolMat(1,:);

yVec = solFunc(xVec);

hold on;
plot(xVec, ySolVec);
plot(xVec, yVec);

% comparing norms

%L2
err1 = sqrt(trapz(xVec, (ySolVec - yVec).^2));
%C
err2 = max(abs(ySolVec - yVec));

disp(err1);
disp(err2);

%%
function dxdy= odefun(x,y)
    dxdy  = [ y(2); y(2) ];
end

function val = bcfun(ya, yb)
    val = [ ya(1)+1; yb(2)-yb(1)-2];
end