function drawManyBalls(alphas, colors, edges)
    figure;
    hold on;
    for i = 1 : numel(alphas)
        drawBall(alphas(i), struct('points',20,'level',0.5,'params',...
            {"FaceColor",colors(i),"EdgeColor",edges(i),"FaceAlpha",0.5}));
    
    end
    hold off;
end