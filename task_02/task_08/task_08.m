drawSet(@squareRho, 6);
drawSet(@dotRho, 6);


% Опорная функция квадрата 1x1
function [value, point] = squareRho(direction)
    value = abs(direction(1)) + abs(direction(2));
    point = [sign(direction(1)); sign(direction(2))];
end

% Опорная функция точки (3, 4)
function [value, point] = dotRho(direction)
    value = 3 * direction(1) + 4 * direction(2);
    point = [3; 4];
    
end