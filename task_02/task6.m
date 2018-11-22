%% First block
f = @(x) 20.*x.*(cos(x.^2)-sin(x));
a = 1;
b = 3.7;
nh = 1000;
XVec = linspace(a,b,nh);
YVec = f(XVec);
%% Second block
xd = diff(YVec);
xds = sign(xd);
ix = (xds(1:end-1)~=xds(2:end));
ix = ix & (xds(1:end-1)<0);
mask(2:numel(ix)+1)=ix;
ind = find(mask);
[maxY, indMax] = max(YVec);
plot(XVec,YVec,'b',XVec(ind),YVec(ind),' *g', XVec(indMax), maxY,' >r');
[minDif, indMinDif] = min(abs(XVec(indMax) - XVec(ind)));
hold on;
nh = 1000;
XFlyVec = linspace(XVec(indMax), XVec(ind(indMinDif)),nh);
YFlyVec = linspace(YVec(indMax), YVec(ind(indMinDif)),nh);
comet(XFlyVec, f(XFlyVec));