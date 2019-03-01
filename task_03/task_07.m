%% Строим траектории
% Задаём начальные условия
G = 60;
m1 = 5;
m2 = 1;
odefunc = @(t, xVec) system(t, xVec, m1, m2, G);

% Задаём время
startTime = 0;
finishTime = 20;

% Задаём стартовую позицию
x0Vec = [ 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0];

% Решаем ОДУ
[tVec, xMat] = ode45(odefunc, [startTime, finishTime], x0Vec);
plot3(xMat(:, 1), xMat(:, 2), xMat(:, 3));
hold on;
plot3(xMat(:, 4), xMat(:, 5), xMat(:, 6));
xlabel("x");
ylabel("y");
zlabel("z");
hold off;

%% Ищем плоскость методом наименьших квадратов
cMat = cat(1, xMat(:, 1:3), xMat(:, 4:6));
height = size(cMat, 1);
cMat = cat(2, cMat,  ones(height, 1));

dVec = zeros(height, 1);
aMat = ones(1, 4);
b = 100;

abcdVec = lsqlin(cMat, dVec, aMat, b);


A =abcdVec(1); B =abcdVec(2); C =abcdVec(3); D =abcdVec(4);
step = 0.005;
xVec = [min(cMat(:,1)), max(cMat(:,1))];
yVec = [min(cMat(:,2)), max(cMat(:,2))];

[X,Y] = meshgrid([xVec(1):step:xVec(2), xVec(2)], [yVec(1):step:yVec(2), yVec(end)]);
Z = -(A*X + B*Y + D)/C;
hold on
surf(X,Y,Z, 'LineStyle', 'none', 'FaceColor', [1,1,0], 'FaceAlpha', 0.7);

clear;

%%
% Функция системы дифференциальных уравнений
function res = system(t, xVec, m1, m2, G)
    norm3 = norm(xVec(1:3) - xVec(4:6)).^3;
    res = zeros(12,1);
    res(1:6) = xVec(7:12);
    res(7) = G*m2*(xVec(4) - xVec(1))./norm3;
    res(8) = G*m2*(xVec(5) - xVec(2))./norm3;
    res(9) = G*m2*(xVec(6) - xVec(3))./norm3;
    res(10) = G*m1*(xVec(1) - xVec(4))./norm3;
    res(11) = G*m1*(xVec(2) - xVec(5))./norm3;
    res(12) = G*m1*(xVec(3) - xVec(6))./norm3;
end