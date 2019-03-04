    function [integral, antiderivative] = rectangles(x, y)
        if isequal(nargin, 1)
            y = x;
            offset = ones(size(y(1:end-1)));
        else
            offset = x(2 : end) - x(1 : end-1);
        end
        y(1) = 0;
        y(2 : end) = y(2 : end) .* offset;
        
        integral = sum(y, 2);
        antiderivative = cumsum(y, 2);
    end
    