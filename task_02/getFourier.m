function f = getFourier(n)
    switch rem(n, 2)
        case 1
            f = @(x)cos(((n - 1)./2 + 1).*x);
        case 0
            if (n == 0)
                f = @(x) ones(size(x));
            else
                f = @(x) sin((n./2).*x);
            end
    end
end