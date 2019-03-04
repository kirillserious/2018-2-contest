%% Task 1
    % Дано
    a = -6*pi;
    b = 6*pi;
    n = 500;
    f = @ (x) sin(0.5 .* x).*x;
    
    % Решение
    x = linspace(a, b, n);  
    y = f(x);               
    
    [maxY, maxIndex] = max(y);  
    [minY, minIndex] = min(y);  
    
    plot(x, y);    
    hold on;               
    plot(x(maxIndex), maxY, 'k*');
    plot(x(minIndex), minY, 'r*');
    axis([a, b, minY - 0.5, maxY + 0.5]);
    title('Задание 1'); 
    xlabel('x');
    ylabel('f(x)');
    hold off;
    
    clear;
    

    %% Task 2
    % Решение
    n = input('Введите натуральное число:\n', 's');
    n = str2double(n);
    if (n ~= floor(n) || n < 1 || n == Inf) 
        error('Не натуральное число');
    end
    
    % 1
    disp('Искомый вектор:')
    disp(9:18:n);
    
    % 2
    A = repmat(transpose(1:n), 1, n);
    disp('Искомая матрица A:');
    disp(A);
    
    %3
    B = reshape((1:n*(n+1)), n+1, n).';
    c = reshape(B, 1, n*(n+1));
    D = B(:, end-1:end);
    clear;
    
%% Task 3
    % Решение
    A = ceil(rand(7, 7) * 100);
    disp('Матрица A:');
    disp(A);
    disp('Максимальный элемент диагонали:');
    disp(max(diag(A)));
    
    ratioVec = prod(A, 2) ./ sum(A, 2);
    disp('Максимальное отношение:');
    disp(max(ratioVec));
    disp('Минимальное отношение:');
    disp(min(ratioVec));
    
    disp('В лексиографичском порядке:');
    disp(sortrows(A));
    
    clear;

    %% Task 4
    % Дано
    xVec = input('Введите вектор x:');
    yVec = input('Введите вектор y:');
    if (~isequal(size(xVec),size(yVec)))
        error('Размеры x и y не совпадают');
    end
    sz = size(xVec, 2);
    
    % Solution
    X = repmat(transpose(xVec), 1, sz);
    Y = repmat(yVec, sz, 1);
    disp(X .* Y);
    
    clear;
%% Task 5
    % Дано
    n = input('Введите натуральное число:\n', 's');
    n = str2double(n);
    
    % Solution
    if n ~= floor(n) || n < 1 || n == Inf || ~isprime(n)
        error('Число не простое');
    end
    
    A = randn(n);
    if isequal(det(A), 0)
        error('Матрица вырождена');
    end
    b = randn(n, 1);
    
    result1 = mldivide(A, b);
    result2 = linsolve(A, b);
    
   % Проверка
    disp(result1);
    disp(min(abs(A*result1 - b) < eps));
    disp(result2);
    disp(min(abs(A*result2 - b) < eps));
    
    clear;
    
    %% Task 6
    % Дано
    n = input('Введите n:');
    m = input('Введите m:');    
    a = randn(n, 1);
    b = randn(m, 1);
    
    % Solution
    resultVec = max([max(a) - min(b), max(b) - min(a)]);
    disp(resultVec);
    
    clear;
    
    %% Task 7
    % Дано
    n = input('Введите число точек:');          
    m = input('Введите размерность:');         
    A = randn(n, m);
    disp(A)

    % Solution
    A = transpose(A);
    B = repmat(A, 1, n);
    A = repmat(A, n, 1);
    A = reshape(A, m, n*n);
    A = A - B;
    A = sqrt(sum((A.*A), 1));
    A = reshape(A, n, n);
    disp(A);
    
    clear;
    %% Task 8
    % Дано
    n = input('Введите размерность:');
    
    % Solution
    xVec = transpose(0:2^n - 1);
    disp((de2bi(xVec)));
    
    clear;
    
    %% Task 9
    clear;
    subplot(1,1,1)
    % Дано
    start = input('Введите начальный n:');
    n = start;
    t = input('Введите число измерений:');
    timeRepeat = 10;
    
    % Solution
    time1Vec = zeros(1, t);
    time2Vec = zeros(1, t);
    time1VecOf = zeros(1, timeRepeat);
    time2VecOf = zeros(1, timeRepeat);
    for n = start : t+start
        for j = 1 : timeRepeat
            A = randn(n, n);
            B = randn(n, n);
            tic;
            Matrix = my_multiply(A, B);
            time1VecOf(j) = toc;
            tic;
            Matrix = A*B;
            time2VecOf(j) = toc;
            
        end
        time1Vec(n) = median(time1VecOf);
        time2Vec(n) = median(time2VecOf);
        
    end
    plot(start : t+start, time1Vec(start:end), 'g-');
    hold on
    plot(start:t+start, time2Vec(start:end), 'r-');
    title('Задание 9'); 
    xlabel('dimention');
    ylabel('time, c');
    hold off;
    
    clear;
    %% Task 10
    % Дано
    n = input('Введите n:');
    m = input('Введите m:');
    X = randn(n, m);
    X(1, 2) = NaN;
    X(3, 2) = NaN;
    
    % Solution
    resultVec = sum(X, 1, 'omitnan') ./ sum(~isnan(X), 1);
    disp(resultVec);
    
    clear;
    
    %% Task 11
     % Дано
     n     = input('Введите n:');
     mu    = input('Введите mu:');
     sigma = input('Введите sigma:');
    
     % Solution
     xVec = normrnd(mu, sigma, [1, n]);
     isInVec = (xVec < mu - 3*sigma) + (xVec > mu + 3*sigma);
     disp(1 - sum(isInVec)/n);
     
    %% Task 12
    a = -pi;
    b = pi;
    x = a:0.01:b;
    y = @(x) sin(x) ./ x;
    
    [integralRectangles, antiderivativeRectanglesVector] = rectangles(x, y(x));
    [integralSimpson, antiderivativeSimpsonVector] = simpson(x, y(x));
    
    % Вывод значения интеграла
    disp(integralRectangles);
    disp(integralSimpson);
    disp(trapz(x, y(x)));
    
    % Построение графиков первообразной
    subplot(2,2,1);
    plot(x, y(x));
    hold on;
    plot(x, antiderivativeRectanglesVector);
    xlabel('x');
    ylabel('y');
    legend('График функции', 'Первообразная методом прямоугольников');
    hold off;
    
    subplot(2,2,2);
    plot(x, y(x));
    hold on;
    plot(x(2:2:end-1), antiderivativeSimpsonVector);
    xlabel('x');
    ylabel('y');
    legend('График функции', 'Первообразная методом Симпсона');
    hold off;
    
    % Изучение скорости сходимости
    n = 15;
    convergenceRectanglesVector = zeros(n, 1);
    convergenceSimpsonVector    = zeros(n, 1);
    convergenceTrapzVector      = zeros(n, 1);
    timeRectanglesVector        = zeros(n, 1);
    timeSimpsonVector           = zeros(n, 1);
    timeTrapzVector             = zeros(n, 1);
       
    
    timeRepeat = 100;
    for i = 1 : n
        
        x1 = a : 2 * 0.1/i : b;
        x2 = a : 0.1/i : b;
        
        for j = 1 : timeRepeat
            tic;
            convergenceRectanglesVector(i) = rectangles(x1, y(x1)) - rectangles(x2, y(x2));
            time(j) = toc;
        end  
        timeRectanglesVector(i) = median(time);
        
        tic;
        for j = 1 : timeRepeat
            tic;
            convergenceSimpsonVector(i) = simpson(x1, y(x1)) - simpson(x2, y(x2));
            time(j) = toc;
        end
        timeSimpsonVector(i) = median(time);
        
        for j = 1 : timeRepeat
            tic;
            convergenceTrapzVector(i) = trapz(x1, y(x1)) - trapz(x2, y(x2));
            time(j) = toc;
        end
        timeTrapzVector(i) = median(time);
        
    end
    
    subplot(2, 2, 3);
    plot(1:n, abs(convergenceRectanglesVector));
    hold on;
    plot(1:n, abs(convergenceSimpsonVector));
    plot(1:n, abs(convergenceTrapzVector));
    xlabel('i, step = 0.1/i');
    ylabel('difference');
    legend('Метод прямоугольников', 'Метод Симпсона', 'Метод трапеций');
    hold off;
    
    subplot(2, 2, 4);
    plot(1:n, timeRectanglesVector);
    hold on;
    plot(1:n, timeSimpsonVector);
    plot(1:n, timeTrapzVector);
    xlabel('i, step = 0.1/i');
    ylabel('time, c');
    legend('Метод прямоугольников', 'Метод Симпсона', 'Метод трапеций');
    hold off;
    
    clear;

    %% Задание 13
    subplot(1,1,1)
    
    x = 0.44;
    func =        @(x) sin(x);
    derivative =  @(x) cos(x);
    diffCentral = @(x, h) (func(x + h) - func(x - h)) ./ (2*h);
    diffRight =   @(x, h) (func(x + h) - func(x)) ./ h;
    
    h = 10 .^ (-10:0);
    centralError =  abs(diffCentral(x, h) - derivative(x));
    rightError =    abs(diffRight(x, h) - derivative(x));
    
    loglog(h, centralError);
    hold on;
    loglog(h, rightError);
    
    xlabel('step')
    ylabel('error')
    legend('Ошибка для центральной разностной производной', 'Ошибка для правой разностной производной');
    hold off;
    
    clear;
    
    

    
    
     
   
