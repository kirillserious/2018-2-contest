function drawBall(alpha, params)
    steps = -1.1 : 2/params(1).points : 1.1;
    [X,Y,Z] = meshgrid(steps,steps,steps);
    if(alpha == inf)
        V = max(max(abs(X), abs(Y)), abs(Z));
    else
        V = abs(X).^alpha + abs(Y).^alpha + abs(Z).^alpha;
    end
    fv = isosurface(X,Y,Z,V,params(1).level);
    p2 = patch(fv,params.params);
    isonormals(X,Y,Z,V,p2)
    view(3) 
    daspect([1 1 1])
    axis tight
    camlight 
    camlight(-80,-10) 
    lighting gouraud
    axis([-1.1,1.1,-1.1,1.1,-1.1,1.1]);
end