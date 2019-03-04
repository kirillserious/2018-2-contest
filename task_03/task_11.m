%fun = @(x) sin(x(1)/6).*(x(2).^2);
%grad = @(x) [cos(x(1)/6).*(x(2).^2)/6 ,  2.*sin(x(1)/6).*x(2)];
%grad2  = @(x) [ -sin(x(1)/6).*(x(2).^2)/36, cos(x(1)/6).*x(2)/3; ..
%                 cos(x(1)/6).*x(2)/3, 2.*sin(x(1)/6)];
%fun1 = @(x,y) sin(x/6).*(y.^2);

%fun = @(x) x(1).^4+x(2).^4;
%grad = @(x) [4.*x(1).^3, 4.*x(2).^3];
%grad2 = @(x) [12.*x(1).^2, 0; 0, 12.*x(2).^2];

%fun1 = @(x,y) x.^4 + y.^4;

%fun = @(x) (x(1).^2+x(2).^2).*(sin(1./(x(1).^2+x(2).^2)).^2);
%grad = @(x) [ 2.*x(1).*sin(1/(x(1).^2 + x(2).^2)).^2 - 4.*x(1).*sin(1/(x(1).^2 + x(2).^2)).*cos(1/(x(1).^2 + x(2).^2))./(x(1).^2 + x(2).^2), ...
%     2.*x(2).*sin(1/(x(1).^2 + x(2).^2)).^2 - 4.*x(2).*sin(1/(x(1).^2 + x(2).^2)).*cos(1/(x(1).^2 + x(2).^2))./(x(1).^2 + x(2).^2)];
%grad2 = @(x) [    -8.*x(1).^2.*sin(1/(x(1).^2 + x(2).^2)).^2/(x(1).^2 + x(2).^2).^3 + 8.*x(1).^2.*cos(1/(x(1).^2 + x(2).^2)).^2/(x(1).^2 + x(2).^2).^3 + 2.*sin(1/(x(1).^2 + x(2).^2)).^2 - 4.*sin(1/(x(1).^2 + x(2).^2)).*cos(1/(x(1).^2 + x(2).^2))/(x(1).^2 + x(2).^2), ...
%    -8.*x(1).*x(2).*sin(1/(x(1).^2 + x(2).^2)).^2/(x(1).^2 + x(2).^2).^3 + 8.*x(1).*x(2).*cos(1/(x(1).^2 + x(2).^2)).^2/(x(1).^2 + x(2).^2).^3; ...
%   -8.*x(1).*x(2).*sin(1/(x(1).^2 + x(2).^2)).^2/(x(1).^2 + x(2).^2).^3 + 8.*x(1).*x(2).*cos(1/(x(1).^2 + x(2).^2)).^2/(x(1).^2 + x(2).^2).^3, ...
%    -8.*x(2).^2.*sin(1/(x(1).^2 + x(2).^2)).^2/(x(1).^2 + x(2).^2).^3 + 8.*x(2).^2.*cos(1/(x(1).^2 + x(2).^2)).^2/(x(1).^2 + x(2).^2).^3 + 2.*sin(1/(x(1).^2 + x(2).^2)).^2 - 4.*sin(1/(x(1).^2 + x(2).^2)).*cos(1/(x(1).^2 + x(2).^2))/(x(1).^2 + x(2).^2)];
    
%fun1 = @(x,y) (x.^2 +y.^2).*(sin(x.^2 +y.^2).^2);


%% Рисуем   

% Вводим функции
fcn = @(x) x(1).^2.*sin(x(1)).^2 + x(2).^2.*sin(x(2)).^2;
fcn1 = @(x,y) x.^2.*sin(x).^2 + y.^2.*sin(y).^2;

grad  = @(x) [ 2*x(1).*sin(x(1)).^2+2*x(1).^2.*sin(x(1)).*cos(x(1)); ...
    2*x(2).*sin(x(2)).^2+2*x(2).^2.*sin(x(2)).*cos(x(2))];
grad2 = @(x) [ 2*sin(x(1)).^2+8*x(1).*sin(x(1)).*cos(x(1))+2*x(1).^2.*cos(2*x(1)), 0;
    0, 2*sin(x(2)).^2+8*x(2).*sin(x(2)).*cos(x(2))+2*x(2).^2.*cos(2*x(2))];

% График функции
[X,Y] = meshgrid(-1:0.01:1);
surf(X, Y, fcn1(X,Y), 'LineStyle', 'none', 'FaceColor', [1,1,0], 'FaceAlpha', 0.7);

% Считаем функцией     
[xNewt, fNewt] = NewtonMin(fcn, grad, grad2, [1; 1], 'drawing');

% Рисуем
hold on;
plot3(xNewt(:, 2), xNewt(:, 2), fNewt, '-r*');    % Шаги
contour3(X, Y, fcn1(X,Y), fNewt);    % Контур
hold off;


%% Сравниваем с fminbnd

% Вводим функции
fcn = @(x) x.^2.*sin(x).^2;
grad = @(x) 2*x.*sin(x).^2 + 2*x.^2.*sin(x).*cos(x);
grad2 = @(x) 2*sin(x).^2 + 8*x.*sin(x).*cos(x) + 2*x.^2.*cos(2*x);

xFminbnd  = fminbnd(fcn, -1, 1);
[xNewt, fNewt] = NewtonMin(fcn, grad, grad2, 1, 'calculate');
disp(xNewt - xFminbnd);

%% Функция NewtonMin ищет минимум функции многих переменных.
%  Если использовать флаг 'drawing', то для функций ДВУХ переменных
%  выдаётся матрица х шагов, и вектор y значений функции в этих точках.

%  Иначе выдаётся одно значение точки минимума и минимума.

function [x, y] = NewtonMin(fcn, gradVecFcn, grad2MatFcn, x0, param)
    switch param
        % Для рисования двумерных функций
        case 'drawing'
            n = 15;    % Количество итераций работы алгоритма
            % Инициализация нужных векторов
            xCurVec = x0;          % Текущее значение вектора x
            xMat = zeros(n, 2);    % Матрица вектора x на каждой итерации
            yVec = zeros(n, 1);    % Вектор значений функции на каждой итерации
            % 
            for iter = 1:n
               grad2Mat = grad2MatFcn(xCurVec);
               gradVec  = gradVecFcn(xCurVec);
               xCurVec = xCurVec - grad2Mat\gradVec;    % inv(a)*b -> a\b
               yVec(iter) = fcn(xCurVec);
               xMat(iter, :) = xCurVec;
            end
            
            x = xMat;
            y = yVec;
        
        % Для обычного вычисления минимума
        otherwise 
            % Инициализация нужных векторов
            xPrevVec = x0 + ones(size(x0));
            xCurVec = x0;
            iter = 0; 
            epsLoc = 0.005;
            
            while norm(xCurVec - xPrevVec) > epsLoc
                iter = iter + 1;
                xPrevVec = xCurVec;
                gMat = grad2MatFcn(xPrevVec);
                gVec = gradVecFcn(xPrevVec);
                xCurVec = xPrevVec - gMat\(gVec.');    %inv(a)*b; -> a\b
            end
            disp("Число итераций алгоритма");
            disp(iter);
            
            y = fcn(xCurVec);
            x  = xCurVec;
    end
end