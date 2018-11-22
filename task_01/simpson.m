% Симпсон работает только на равномерной сетке
    function [integral, antiderivative] = simpson(x, y)
        if isequal(nargin, 1)
            y = x;
            x = 1:size(y, 2);
        end
        f = ((x(3:2:end) - x(1:2:end-2)) .* (y(1:2:end-2) + 4*y(2:2:end-1) + y(3:2:end))) ./ 6;
        integral = sum(f);
        antiderivative = cumsum(f, 2);
    end