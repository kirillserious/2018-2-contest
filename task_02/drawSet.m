function  drawSet(rho, n)
    n = n+1;
    phi = linspace(0, 2 * pi, n);
    pointVec = zeros(2, n-1);
    p = zeros(2,n-1);
    dir = @(k)[cos(phi(k)), sin(phi(k))];
    for k = 2:n
        [val1 , point1] = rho(dir(k-1));
        [val2,  ~] = rho(dir(k));
        pointVec(:,k-1) = transpose(point1);
        p(:,k-1) = transpose((linsolve([dir(k-1); dir(k)],transpose([val1 val2])))); 
    end
    figure;
    grid on;
    plot([pointVec(1,:),pointVec(1,1)], [pointVec(2,:),pointVec(2,1)], 'k', ...
        [p(1, :),p(1,1)], [p(2, :),p(2,1)], 'r');
    legend('Internal hull','External hull');
end

