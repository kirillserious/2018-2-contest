%% Двумерная графика, часть первая
    %% Test 1
    x = 1 : 10;
    xx = 1 : 0.05 : 10;
    f = @(x) sin(x);    
    maxDer = 1;
    compareInterp(x, xx, f);
    linearInterpError(x, xx, f, maxDer);
    clear;
    %% Test 2
    compareInterp( -1:0.05:1,    -1:0.005:1,     @(x) max(0, x ./ abs(x)));
    compareInterp( -10:10,       -10:0.05:10,    @(x) abs(x));
%% Двумерная графика, часть вторая
    %% Task 4
        %% Функция сходится поточечно, но не в среднем
        fn = @(n, x) sqrt(n).*sin(n.*x).*(x>=0).*(x<=pi./n);
        f = @(x) 0.*x;
        convergenceFunc(fn, f, 0, pi, 30, 'mean');
        convergenceFunc(fn, f, 0, pi, 30, 'uniform');
        convergenceFunc(fn, f, 0, pi, 30, 'point');
        clear fn;
        clear f;
        %% Функция сходится поточечно, в среднем, но не равномерно
        fn = @(n, x) x.^n - x.^(2*n);
        f = @(x) 0.*x;
        convergenceFunc(fn, f, 0, 1, 30, 'mean');
        convergenceFunc(fn, f, 0, 1, 30, 'uniform');
        convergenceFunc(fn, f, 0, 1, 30, 'point');
        clear fn;
        clear f;
        %% Функция сходится по-всякому
        fn = @(n, x) x.^n - x.^(n+1);
        f = @(x) 0.*x;
        convergenceFunc(fn, f, 0, 1, 30, 'mean');
        convergenceFunc(fn, f, 0, 1, 30, 'uniform');
        convergenceFunc(fn, f, 0, 1, 30, 'point');
        clear fn;
        clear f;        
        %% Самая простая функция
        convergenceFunc(@(n, x) x + 1/n, @(x) x, 0.5, 1, 100, 'mean');
        convergenceFunc(@(n, x) x + 1/n, @(x) x, 0.5, 1, 100, 'uniform');
        convergenceFunc(@(n, x) x + 1/n, @(x) x, 0.5, 1, 100, 'point');
    %% Task 5
    fourierApprox(@(x) 6.*(x), 0, 2*pi, 50, 'fourier')
    fourierApprox(@(x) sign(x), -3, 6, 40, 'chebyshev')
    fourierApprox(@(x)x.*sign(cos(5*x)), -1, 1, 30, 'legendro')
    %% Task 6 (task6.m)
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
    %% Task 7
    t0 = 0;
    t1 = 20;
    n = 9;
    A = 2;
    B = 3;
    a = 1;
    b = 1;
    delta = 1;
    f = @(t)A.*sin(a.*t+delta);
    g = @(t) B.*sin(b.*t);
        
    pVec = getEqual(f, g, n, t0, t1);
    
    figure;
    plot(f(t0:0.001:t1), g(t0:0.001:t1));
    hold on;
    grid on;
    %plot(f(t0:(t1-t0)/(n-1):t1),g(t0:(t1-t0)/(n-1):t1));
    plot(f([t0,t0+cumsum(abs(pVec)),t1]),g([t0,t0+cumsum(abs(pVec)),t1]));
    axis equal;
    legend('figure', 'uniform', 'equal');
    hold off;

    %% Task 8 & 9 & 10
        %% Test 1: circle
        options = optimoptions('fmincon','Display','off','Algorithm','sqp');   
        rho = supportLebesgue(@(x) (x(1)+3).^2 + x(2).^2 - 0, options);
        drawSet(rho, 45);
        drawPolar(rho, 45);
        %% Test 2: diamond
        options = optimoptions('fmincon','Display','off','Algorithm','sqp');
        rho = supportLebesgue(@(x) abs(x(1)) + abs(x(2)) - 1, options);
        drawSet(rho, 100);
        drawPolar(rho, 45);
        %%
        rho = @(x) sum(abs(x));
        
        drawSet(rho, 100);
        %% Test 3: ellipce
        options = optimoptions('fmincon','Display','off','Algorithm','sqp');   
        rho = supportLebesgue(@(x) ((x(1)-4)/4).^2 + (x(2)/3).^2 - 0, options);
        drawSet(rho, 45);
        drawPolar(rho, 45);   
%% Трехмерная графика
    %% Function and its mesh
    %f = @(x,y,n) sin(n.*x.^2) + cos(y) + 9;
    f = @(x,y,n) sin(n.*x.^2) + cos(y + x) + 9;
    %f = @(x,y,t) t.*y.^sin(t.*x.^2) + x.^cos(y.^2 + x) + 9;
    x = 1 : 4/200 : 5;
    y = 1 : 4/200 : 5;
    [X, Y] = meshgrid(x, y);
    tbounds = 1 : 0.5 : 5;
    %% Evalution
    zmax = -inf;
    zmin =  inf;
    figure;
    F(1 : size(tbounds,2)) = struct('cdata',[],'colormap',[]);
    % Двигаем оси
    for i = 1:size(tbounds,2)
        Z = f(X, Y, tbounds(i)); 
        zmax = max([Z(:);zmax]);
        zmin = min([Z(:);zmin]);
    end
    fig = surf(X,Y,Z); % Без этого никак не работают оси, что делать и зачем -- не ясно!
    axis([x(1), x(end), y(1), y(end), zmin, zmax]);
    axis manual;
    hold on;
    delete(fig);

    for i = 1:size(tbounds,2)
        Z = f(X, Y, tbounds(i));
   
        ZMin = imregionalmin(Z).*Z;
        ZMax = imregionalmax(Z).*Z;
        fig1 = surf(X,Y,Z, 'EdgeColor', 'none', 'FaceAlpha', 0.5);
        fig2 = plot3(X, Y, ZMin, ' *g', X, Y, ZMax, ' >m');
        drawnow;
        F(i) = getframe;
        pause(0.05);
        delete(fig1);
        delete(fig2);
    end

    plot3(X,Y,ZMin,' *g',X,Y,ZMax,' >m');
    surf(X,Y,Z, 'EdgeColor', 'none','FaceAlpha',0.5);
    hold off;
    %% Animation
    figure;
    movie(F, 3, ceil(size(tbounds,2)/5));

    %% Saving
    save evolution.mat F
    vidObj = VideoWriter('evolution.avi');
    vidObj.Quality = 100;
    vidObj.FrameRate = ceil(size(tbounds,2)/5);
    open(vidObj);
    writeVideo(vidObj,F);
    close(vidObj);

    %% Contour on level
    figure;
    height = 10;
    param = tbounds(fix(end/2)+1);
    Z = f(X,Y,param);
    contourf(X,Y,Z);
    colorbar;
    figure;
    contourf(X,Y,Z,[height,height]);
    colorbar
    %% viewPossible
    viewPossible([0,0; 0,1; 2,2; -2,1],[50,40,20,19],20);
    viewPossible([0,0; 0,1; 2,2; -10,4],[50,40,20,20],20);
    axis equal
%% Четырехмерная графика
    %% Task 14
    figure;
    drawBall(1, ...
        struct('points',20,'level',-1,'params',{"FaceColor","red","EdgeColor","none","FaceAlpha",0.5}));
    v = flow;
    %% Task 15
    drawManyBalls([1,inf], ["red","black"],["none","yellow"]);

    
    


    