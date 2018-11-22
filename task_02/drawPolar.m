function  drawPolar(rho, N)
    N = N + 1;
    valVec = zeros(N, 1);
    phi = linspace(0, 2* pi, N);
    dir = [transpose(cos(phi)), transpose(sin(phi))];
    for i = 1 : N
        [valVec(i), ~] = rho(dir(i,:));
    end
    
    valVec(valVec < 1e-5) = NaN;
    newL = dir./valVec;
    
    figure;
    grid on;
    plot(newL(:, 1), newL(:, 2), 'g');
end

