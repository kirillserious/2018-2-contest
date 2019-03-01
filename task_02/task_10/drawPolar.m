function  drawPolar(rho, N)
    N = N + 1;
    valVec = zeros(N, 1);
    angle = linspace(0, 2* pi, N);
    direction = [transpose(cos(angle)), transpose(sin(angle))];
    for i = 1 : N
        [valVec(i), ~] = rho(direction(i,:));
    end    
    valVec(valVec < 1e-5) = NaN;
    newL = direction ./ valVec;
    figure;
    plot(newL(:, 1), newL(:, 2), 'b*');
    hold on;
    maxL = norm(max(newL));
    newL(isnan(newL)) = direction(isnan(newL)) .* maxL;
    
    grid on;
    fill([newL(:, 1); newL(1, 1)], [newL(:, 2); newL(1, 2)], 'r');
    hold off;
end

