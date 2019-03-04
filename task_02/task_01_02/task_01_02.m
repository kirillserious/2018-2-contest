    %% Test 1
    x = 1 : 10;
    xx = 1 : 0.05 : 10;
    f = @(x) sin(x);    
    maxDer = 1;
    compareInterp(x, xx, f);
    linearInterpError(x, xx, f, maxDer);
    clear;
    %% Test 2
    compareInterp( -1:0.05:1,    -1:0.005:1,     @(x) max(0, x ./ abs(x)));
    compareInterp( -10:10,       -10:0.05:10,    @(x) abs(x));