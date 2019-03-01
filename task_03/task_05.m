% ������� a, b � step - �������� ���������
a = -2;
b = 1;
step = 0.01;

xVec = a : step : b;

% ������� ����� ������� ����
yVec = zeros(size(xVec));
for i = 1 : length(xVec)
    yVec(i) = fzero(@func, xVec(i));   % @func - ��������� �� �������
end

% ������ ������
plot(xVec, yVec);
title("������ �������");
xlabel("x");
ylabel("����� ������� ������");

clear;

% ������� �� �������. ������� � ������� � ���� ������� �� ����������, ���
% ��� � ���� ���������� Nan, �� ������� �������� fzero.
function res = func(x)
    if x~= 0
        res = sqrt(abs(x)) .* sin(1 ./ x.^2);
    else 
        res = 0;
    end
end
