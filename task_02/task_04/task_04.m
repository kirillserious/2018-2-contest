%% Функция сходится поточечно, но не в среднем
        fn = @(n, x) sqrt(n).*sin(n.*x).*(x>=0).*(x<=pi./n);
        f = @(x) 0.*x;
        convergenceFunc(fn, f, 0, pi, 30, 'mean');
        convergenceFunc(fn, f, 0, pi, 30, 'uniform');
        convergenceFunc(fn, f, 0, pi, 30, 'point');
        clear fn;
        clear f;
        %% Функция сходится поточечно, в среднем, но не равномерно
        fn = @(n, x) x.^n - x.^(2*n);
        f = @(x) 0.*x;
        convergenceFunc(fn, f, 0, 1, 30, 'mean');
        convergenceFunc(fn, f, 0, 1, 30, 'uniform');
        convergenceFunc(fn, f, 0, 1, 30, 'point');
        clear fn;
        clear f;
        %% Функция сходится по-всякому
        fn = @(n, x) x.^n - x.^(n+1);
        f = @(x) 0.*x;
        convergenceFunc(fn, f, 0, 1, 30, 'mean');
        convergenceFunc(fn, f, 0, 1, 30, 'uniform');
        convergenceFunc(fn, f, 0, 1, 30, 'point');
        clear fn;
        clear f;        
        %% Самая простая функция
        convergenceFunc(@(n, x) x + 1/n, @(x) x, 0.5, 1, 100, 'mean');
        convergenceFunc(@(n, x) x + 1/n, @(x) x, 0.5, 1, 100, 'uniform');
        convergenceFunc(@(n, x) x + 1/n, @(x) x, 0.5, 1, 100, 'point');
