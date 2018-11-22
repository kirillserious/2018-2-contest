function rho = supportLebesgue (f, opts)
    rho = @(l) suppfunc(l, f, opts);

    function [c, ceq] = myFunc(f, x)
        ceq = [];
        c = f(x);
    end

    function [val,x]=suppfunc(l, f, opts)
        x0Vec = zeros(size(l));
        scalar = @(x) -sum(x.*l);
        [x,val] = fmincon( @(x) scalar(x), x0Vec, [], [], [], [], [], [], @(x) myFunc(f,x), opts);
        val = -val;
    end
end