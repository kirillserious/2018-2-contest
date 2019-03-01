function viewPossible(points, P, L)
    
    goodSignal = @(x,y,k) P(k) ./ (1 + ((x - points(k,1)).^2 + (y - points(k,2)).^2).^(0.5));
    searchZone(1:2) = [min(points(:,1)) - (sum(P))/L, max(points(:,1)) + (sum(P))/L];
    searchZone(3:4) = [min(points(:,2)) - (sum(P))/L, max(points(:,2)) + (sum(P))/L];
    figure;
    axis(searchZone);
    steps = 1000;
    XVec = searchZone(1):(searchZone(2) - searchZone(1))/steps:searchZone(2);
    YVec = searchZone(3):(searchZone(4) - searchZone(3))/steps:searchZone(4);
    [X,Y] = meshgrid(XVec,YVec);
    Z = zeros(size(X));
    for i = 1:size(points,1)
        Z = Z + goodSignal(X,Y,i);
    end
    M = contour(X,Y,Z,[L,L]);
    if(M(2,1) == size(M,2) - 1)
        disp('Region of strong signal is simply connected');
    else
        disp('Region consists of two or more sets');
    end
    contourf(X,Y,Z,L:(sum(P)-L):sum(P));
    colorbar;
end