fourierApprox(@(x) 6.*(x), 0, 2*pi, 50, 'fourier')
fourierApprox(@(x) sign(x), -3, 6, 40, 'chebyshev')
fourierApprox(@(x)x.*sign(cos(5*x)), -1, 1, 30, 'legendro')
