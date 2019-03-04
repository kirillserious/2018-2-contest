% Задаём фигуру Лиссажу    
t0 = 1;
t1 = 10;
n = 10;
A = 2;
B = 3;
a = 1;
b = 1;
delta = 1;
f = @(t) A.*sin(a.*t+delta);
g = @(t) B.*sin(b.*t);
    
% Рисуем график
timeVec = linspace(t0, t1, 100);
plot(f(timeVec), g(timeVec));
    
% Рисуем параметризацию с равноудалёнными точками
hold on;
pointVec = getEqual(f, g, t0, t1, n);
plot(pointVec(:, 1), pointVec(:, 2));

% Риcуем равномерную по t параметризацию 
timeVec = linspace(t0, t1, n);
plot(f(timeVec), g(timeVec));

legend("Фигура Лиссажу", "Наша параметризация", "Равномерная параметризация");
xlabel("x");
ylabel("y");
hold off;

% Считаем среднее расстояние между точками при равномерной параметризации
fVec = f(timeVec);
gVec = g(timeVec);

A = ( fVec(1:end-1) - fVec(2:end) ).^2;
B = ( gVec(1:end-1) - gVec(2:end) ).^2;

distance = sum((A + B).^0.5)/(n-1);

disp("Равномерная параметризаия:")
disp(distance)
% Расстояние при равной параметризации
distance = norm(pointVec(1,:) - pointVec(2,:));

disp("Наша параметризаия:")
disp(distance)