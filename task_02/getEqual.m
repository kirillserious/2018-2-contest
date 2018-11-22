function result = getEqual (f, g, n, t0, t1)
    result = fsolve(@(dt)getDist(dt,f,g,n,t0,t1), ...
        (t1-t0)/(n-1).*ones(1,n-2));
    
    function result = getDist(dt, f, g, n, t0, t1)
        result = zeros(1,n);
        t = [t0,t0+cumsum(dt),t1];
        for i = 2 : n
            result(i) = getLen(f, g, t(i-1), t(i));
        end
        result = abs(result - getLen(f, g, t0, t1)./n);
    
        function result = getLen(f, g, t0, t1)
            result = sum(diff(f(t0:(t1-t0)/100:t1)).^2 + diff(g(t0:(t1-t0)/100:t1)).^2);
        end
    end
end
