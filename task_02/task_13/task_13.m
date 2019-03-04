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
        %% Одна область
        viewPossible([0,0; 0,1; 2,2; -2,1],[50,40,20,19],20);
        axis equal
        %% Несколько областей
        viewPossible([0,0; 0,1; 2,2; -10,4],[50,40,20,20],20);
        axis equal
        %% Случайные цифры
        dotNumber = randi(4);
        points = rand(dotNumber, 2);
        levels = rand(1, dotNumber);
        level = rand();
        viewPossible(points, levels, level);