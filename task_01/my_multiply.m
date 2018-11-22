function ansMat = my_multiply(A, B)
n = size(A, 1);
m = size(A, 2);
k = size(B, 2);
resMat = zeros(n, k);
for i = 1 : n
    for j = 1 : k
        mySum = 0;
        for c = 1 : m
            mySum = mySum + A(i, c) * B(c, j);
        end
        resMat(i, j) = mySum;
    end
end
ansMat = resMat;
end