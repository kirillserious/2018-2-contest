%%
mex inv_c.c
%%
eps = 10^-2;

A = [7, 4, 7; 5, 3, 7; 4, 4, 4];

tic;
B = inv_c(A);
toc
tic;
inv_matlab(A)
toc
clear;