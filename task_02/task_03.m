clear;
a = 1;
b = 2*pi;
nX = 10;
nXX = 100;
x = a:(b - a)/nX:b;
xx = a:(b - a)/nXX:b;
%%
func = @(x) sin(1.5.*x);
diff_max = 1.5; 
%%
func = @(x) sign(x);
diff_max = 1; 
%%
y = func(xx);
y_interp = interp1(x, func(x), xx, 'linear');
apriorn = diff_max * (b - a)/nXX;
now = abs(y - y_interp);
plot(xx, apriorn * ones(1 , numel(xx)), xx, now);
legend('apriori', 'now');
xlabel('x');
ylabel('y');