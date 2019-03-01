%% First block
        f = @(x) sin(x);
        a = 4;
        b = 5;
        nh = 1000;
        XVec = linspace(a,b,nh);
        YVec = f(XVec);
%% Second block
        ind = find(islocalmin(YVec));
        [maxY, indMax] = max(YVec);
        plot(XVec,YVec,'b',XVec(ind),YVec(ind),' *g', XVec(indMax), maxY,' >r');
        [minDif, indMinDif] = min(abs(XVec(indMax) - XVec(ind)));
        hold on;
        nh = 1000;
        XFlyVec = linspace(XVec(indMax), XVec(ind(indMinDif)),nh);
        YFlyVec = linspace(YVec(indMax), YVec(ind(indMinDif)),nh);
        comet(XFlyVec, f(XFlyVec));
