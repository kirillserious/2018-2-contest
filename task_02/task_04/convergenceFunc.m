function convergenceFunc(f_n, f, a, b, n, convType)
    figure;
    xVec = linspace(a, b, 1000);
    yVec = f(xVec);
    plot(xVec, yVec, 'r');
    axis manual;
    hold on;
    xlabel('x');
    ylabel('f(x)');
    
    
    F(1:n) = struct('cdata',[],'colormap',[]);

    for i = 1 : n-1
        fig = plot(xVec, f_n(i, xVec), 'b');
        switch (convType)
            case 'uniform'
                normStr = '$$ ||f(x)-f_n(x)|| = ';
                deltaVec = max(abs(f_n(i, xVec) - yVec));
                titleStr = strcat(normStr, num2str(deltaVec), ' $$');
            case 'mean'
                normStr = '$$\int\limits_a^b (f_n(x)-f(x))^2dx = ';
                deltaVec = trapz(xVec, (f_n(i, xVec) - yVec).^2);
                titleStr = strcat(normStr, num2str(deltaVec), ' $$');
            case 'point'
                titleStr = '';
        end
        title(titleStr, 'Interpreter', 'latex');
        legend('f(x)','f_n(x)');
        F(i) = getframe;
        delete(fig);
    end

    plot(xVec, f_n(n, xVec), 'b');
    F(n) = getframe;
    legend('f(x)','f_n(x)');
end