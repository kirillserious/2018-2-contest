function [] = linearInterpError(x, xx, f, maxDerivative)
    aprioryErrorVec = zeros(size(xx));
    
    j = 1;
    for i = 1 : length(x) - 1
        while xx(j) ~= x(i + 1)
            w = (xx(j) - x(i)) * (xx(j) - x(i + 1));
            aprioryErrorVec(j) = abs(maxDerivative * w / 2);
            j = j + 1;
        end
    end
    
    figure('Name', 'Linear interpolation error', 'units', 'normalized');
    plot (xx, aprioryErrorVec, 'b-');
    hold on
    plot (xx, abs(f(xx) - interp1(x, f(x), xx, 'linear')), 'g-');
    legend('apriory error', 'real error');
    axis([min(xx), max(xx), 0, max(aprioryErrorVec) + eps])
    hold off

    