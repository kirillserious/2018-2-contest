% Зададим a, b и step - величину разбиения
a = -2;
b = 1;
step = 0.01;

xVec = a : step : b;

% Находим самые близкие нули
yVec = zeros(size(xVec));
for i = 1 : length(xVec)
    yVec(i) = fzero(@func, xVec(i));   % @func - указатель на функцию
end

% Строим график
plot(xVec, yVec);
title("Корень функции");
xlabel("x");
ylabel("Самый близкий корень");

clear;

% Функция из задания. Сделать её наверху в одну строчку не получается, так
% как в нуле получается Nan, на которой ругается fzero.
function res = func(x)
    if x~= 0
        res = sqrt(abs(x)) .* sin(1 ./ x.^2);
    else 
        res = 0;
    end
end
