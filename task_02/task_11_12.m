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