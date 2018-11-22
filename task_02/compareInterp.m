function [] = compareInterp(x, xx, f)
    figure('Name', 'Interpolation', 'units', 'normalized', 'outerposition', [0 0 1 1]);
    
    eps=1e-6;
    yyVec = f(xx);
    AXVec = gobjects(1,4);
    ymax = -inf;
    ymin = +inf;
    
    %nearest
    AXVec(1) = subplot(2, 2, 1);
    hold on;
    plot(xx, f(xx), 'b-');
    y = interp1(x, f(x), xx, 'nearest');
    ymax = max([y, ymax]);
    ymin = min([y, ymin]);
    plot(x, f(x), 'b*', xx, y, 'g-');
    legend(char(f), ' f(x)', 'nearest');
    hold off
    
    %spline
    AXVec(2) = subplot(2, 2, 2);
    plot(xx, yyVec, 'r-');
    hold on
    y = interp1(x, f(x), xx, 'spline');
    ymax = max([y, ymax]);
    ymin = min([y, ymin]);
    plot(x, f(x), 'r*', xx, y, 'b-');
    hold off
    legend(char(f), ' f(x)', 'spline');
    
    %linear
    AXVec(3) = subplot(2, 2, 3);
    plot(xx, yyVec, 'r-');
    hold on;
    y = interp1(x, f(x), xx, 'linear');
    ymax = max([y, ymax]);
    ymin = min([y, ymin]);
    plot(x, f(x), 'r*', xx, y, 'k-');
    hold off
    legend(char(f), ' f(x)', 'linear');
    
    %cubic
    AXVec(4) = subplot(2, 2, 4);
    plot(xx, yyVec, 'r-');
    hold on;
    y = interp1(x, f(x), xx, 'PCHIP');
    ymax = max([y, ymax]);
    ymin = min([y, ymin]);
    plot(x, f(x), 'r*', xx, y, 'k-');
    legend(char(f), ' f(x)', 'cubic');
 
    set(AXVec,'xlim',[min(xx) max(xx)], 'ylim', [min([yyVec, ymin]) - eps, max([yyVec, ymax]) + eps])
end

