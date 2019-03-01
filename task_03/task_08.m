%% 
drawing(@knotFun, 'Узел');
%%
figure;
drawing(@focusFun, 'Фокус');
%%
figure;
drawing(@saddleFun, 'Седло');
%%
figure;
drawing(@diKnotFun, 'Дикритический узел');
%%
figure;
drawing(@centreFun, 'Центр');

%%
function drawing(odeFun, name)
    maxSize = 5;
    startTime = 0;
    finishTime = 20;
    N = 4;
    x0Vec = linspace(-1, 1, N);
    hold on;
    % Фазовый портрет
    for i = 1:N
        for j = 1:N
            x0 = [x0Vec(i), x0Vec(j)];
            [~, X] = ode45(odeFun, [startTime, finishTime], x0);
            x = X(:, 1);
            y = X(:, 2);
            xMask = (x <= maxSize) & (x >= -maxSize);
            x = x(xMask);
            y = y(xMask);
            yMask = (y <= maxSize) & (y >= -maxSize);
            x = x(yMask);
            y = y(yMask);
            
            % Вариант со стрелками
            quiver(x(2:end), y(2:end), x(2:end) - x(1:end-1), y(2:end)- y(1:end-1));
            
            % Красивый вариант
            
            % count = numel(x) / 4-1;
            % for k = 1:count
            %     plot(x(4*(k-1)+1:4*k+1), y(4*(k-1)+1:4*k+1), 'Color', [(k/count), (k/count), (k/count)]);
            % end
        end
    end
    plot(0, 0, '*');
    hold off;
    title(name);
end

% Knot
function dydx = knotFun(t, y)
    dydx = [2*y(1);...
        y(1)+y(2) ];
end

% Focus
function dydx = focusFun(t, y)
    dydx = [y(1)-2*y(2);...
        4*y(1)-3*y(2) ];
end

% Saddle
function dydx = saddleFun(t, y)
    dydx = [y(2)-2*y(1);...
        y(2) ];
end

%dicritical knot
function dydx = diKnotFun(t, y)
    dydx = [y(1);...
        y(2) ];
end

% Centre
function dydx = centreFun(t, y)
    dydx = [y(1)-2*y(2);...
        y(1)-y(2) ];
end