%% Компиляция с-файла в mex-функцию
mex quadsolve.c

%% Примеры
[x1, x2] = quadsolve(0, 0, 1)
%%
a = ones(2, 3);
b = ones(2, 3);
c = ones(2, 3);
[x1, x2, d] = quadsolve(a, b, c)
%%
quadsolve(1+i, 2+i, 3+i)