function f = getChebyshev(n)
    f = @(x) cos(n.*acos(x));
end