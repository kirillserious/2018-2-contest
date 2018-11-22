function fourierApprox(f, a, b, n, meth)
    figure;
    grid on;
    hold on;
    xVec = linspace(a, b, 10000);
    yVec = f(xVec);
    plot(xVec, yVec, 'r');
   S_k = zeros(size(xVec));
    switch (meth)
        case 'fourier'
            alpha = 2*pi./(b-a);
            beta = -2*pi*a./(b-a) - pi;
            S_k = 1/(2*pi) * integral(@(x) f((x+pi)./(2*pi) .*(b-a)  + a),-pi,pi);   
            for n = 1:(2*n)
                psi_k = getFourier(n);
                f_k = 1/pi * integral(@(x) f((x+pi)./(2*pi) .*(b-a)  + a).*psi_k(x),-pi,pi);
                S_k = S_k + f_k.*psi_k(xVec.*alpha+beta);
                fig = plot(xVec, S_k, 'b');
                drawnow;
                pause(0.05);
                delete(fig);
            end
            plot(xVec, S_k, 'b');
        case 'chebyshev'
            alpha = 2 / (b - a);
            beta = -2*a/(b-a) - 1;
            S_k = 1/pi *integral(@(x) f((x+1)./2 .*(b-a)  + a)./(1-x.^2).^(0.5),-1,1);
            for n = 1:n
                psi_k = getChebyshev(n);
                f_k = 2/pi * integral(@(x) f((x+1)./2 .*(b-a)  + a).*psi_k(x)./(1-x.^2).^(0.5),-1,1);
                S_k = S_k + f_k.*psi_k(xVec.*alpha+beta);
                fig = plot(xVec, S_k, 'b');
                drawnow;
                pause(0.05);
                delete(fig);
            end
            plot(xVec, S_k, 'b');
        case 'legendro'
            alpha = 2/(b-a);
            beta = -2*a/(b-a) - 1;

            for n = 1:n
                psi_k = getLegendro(n-1);
                f_k = integral(@(x) f((x+1)./2 .*(b-a)  + a).*psi_k(x),-1,1);
                S_k = S_k + f_k.*psi_k(alpha.*xVec+beta);
                fig = plot(xVec, S_k, 'b');
                pause(0.05);
                delete(fig);
            end
            plot(xVec,S_k,'b');    
    end

end