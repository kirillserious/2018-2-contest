clear;
    tstart = -20;
    tfinal = 20;
    xVec = -6:6;
    yVec = -6:6;
    y0Mat = [6,6];
    fLyap1 = @(x,y) (x + y).^2+(y.^4)/2;
    fLyap2 = @(x,y) x.*y;
    [xMat,yMat] = meshgrid(xVec,yVec);
    z1Mat = fLyap1(xMat,yMat);
    z2Mat = fLyap2(xMat,yMat);
    
    for k = -6:2:6
        y0Mat = cat(1,y0Mat,[6,k],[k,6],[-6,k],[k,-6]);
    end
    
    opt = odeset('OutputFcn',@odephas2,'OutputSel',[1 2]);
    
    figF1 = figure(1);
    figF2 = figure(2);
    for k = 1:size(y0Mat,1)
        figure(figF1);
        hold on;
        [t,y] = ode45(@nineOne,[tstart tfinal],y0Mat(k,:),opt);
        contour(xMat,yMat,z1Mat,[k k]);
        figure(figF2);
        hold on;
        [t,y] = ode45(@nineTwo,[tstart tfinal],y0Mat(k,:),opt);
        contour(xMat,yMat,z2Mat,[k k]);
    end
    figure(figF1);
    odephas2([],[],'done');
    figure(figF2);
    odephas2([],[],'done');