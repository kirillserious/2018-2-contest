%% Test 1: circle
        options = optimoptions('fmincon','Display','off','Algorithm','sqp');   
        rho = supportLebesgue(@(x) (x(1)+3).^2 + x(2).^2 - 5, options);
        drawSet(rho, 45);
%% Test 2: diamond
        options = optimoptions('fmincon','Display','off','Algorithm','sqp');
        rho = supportLebesgue(@(x) abs(x(1)) + abs(x(2)) - 1, options);
        drawSet(rho, 100);
%% Test 3: ellipce
        options = optimoptions('fmincon','Display','off','Algorithm','sqp');   
        rho = supportLebesgue(@(x) ((x(1)-4)/4).^2 + (x(2)/3).^2 - 5, options);
        drawSet(rho, 45);