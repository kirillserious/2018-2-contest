% ����� alpha
alpha = 0.5;
odefun = @(t, x) fun(t, x, alpha);
% ����� ��������� �������
x0 = [1, 2];
% ����� ����� ������ � �����
startTime = 0;
finishTime = 30;

% ������� �� � �����
te = startTime;
xe = x0;
tVec = startTime;
xVec = x0;
options = odeset('Events', @myEventFcn);

while 1
    [curTimeVec, curXVec, te, xe, ie] = ode45(odefun, [te, finishTime], xe, options);
    tVec = [tVec, curTimeVec.'];
    xVec = [xVec; curXVec];
    
    % ������ ���, ������ ��� � ��������� ��� te, xe, ie �� �����������, �,
    % ������, ������ ���� ������ ������
    if curTimeVec(end) >= finishTime
        break;
    end
    te = te(end);
    xe = [xe(end, 1), -xe(end, 2)];
   
end

% C����� ������
plot(tVec, xVec(:, 1));
hold on;
plot(tVec, xVec(:, 2));
hold off;
title("���������� ��������");
xlabel("t");
legend("x", "x'");

clear;

% �������, ������������ ������ ��� ode45
function res = fun (t, x, alpha)
    res = [x(2); -sin(x(1)) - alpha*x(2)];
end

% ������� �������
function [value, isterminal, direction] = myEventFcn(t, x)
    value = x(1);
    isterminal = 1;
    direction = 0;
end