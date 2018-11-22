function L = getLegendro(n)
    L = @(x) zeros(size(x));
    for i = 0:n
       L = @(x) L(x) +  nchoosek(n,i)^2.*(x - 1).^(n - i).*(x + 1).^(i);
    end
    L = @(x) ((2*n+1)/2)^(0.5)/(2^n) .* L(x);
end
