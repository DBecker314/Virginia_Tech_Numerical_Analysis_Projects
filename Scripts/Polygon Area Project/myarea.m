function [area,pp1,pp2] = myarea(x,y)
%MYAREA − computes the area of a region with a curved boundary.
% input
% x − a vector for the x values of points on the boundary
% y − a vector for the y values of points on the boundary
% output
% area − area enclosed by a curved boundary defined by vectors x and y.
%% Find endpoints where curves will intersect
[mx,id1] = max(x);
[mn,id2] = min(x);
maxin = max(id1,id2);
minin = min(id1,id2);
polyleng = maxin-minin;
%% Create vectors for x and y values for top and bottom curves
polyx1 = zeros(polyleng+1,1);
polyy1 = zeros(polyleng+1,1);
polyx2 = zeros(length(x)-polyleng+1,1);
polyy2 = zeros(length(x)-polyleng+1,1);

for i = minin:maxin
    polyx1(i-minin+1) = x(i);
    polyy1(i-minin+1) = y(i);
end
for i = maxin:length(x)
    polyx2(length(polyx2)+maxin-i) = x(i);
    polyy2(length(polyx2)+maxin-i) = y(i);
end
for i = 1:minin
    polyx2(minin-i+1) = x(i);
    polyy2(minin-i+1) = y(i);
end
%% Create piecewise functions using piecewise cubic hermite interpolation
pp1 = pchip(polyx1,polyy1);
pp2 = pchip(polyx2,polyy2);
xq = mn:0.0001:mx;
hold on
plot(xq,ppval(pp1,xq),'red');
plot(xq,ppval(pp2,xq),'green');
%% Integrate top and bottom piecewise functions
[B1,C1] = unmkpp(pp1);
[B2,C2] = unmkpp(pp2);

Integral1 = 0;
for i = 1:length(B1)-1
    polyindv1 = @(x) C1(i,1).*(x-B1(i)).^3+C1(i,2).*(x-B1(i)).^2+C1(i,3).*(x-B1(i))+C1(i,4);
    a = B1(i);
    b = B1(i+1);
    I = integral(polyindv1,a,b);
    Integral1 = Integral1 + I;
end
Integral2 = 0;
for i = 1:length(B2)-1
    polyindv2 = @(x) C2(i,1).*(x-B2(i)).^3+C2(i,2).*(x-B2(i)).^2+C2(i,3).*(x-B2(i))+C2(i,4);
    a = B2(i);
    b = B2(i+1);
    I = integral(polyindv2,a,b);
    Integral2 = Integral2 + I;
end
%% Find the total area
area = Integral2-Integral1;

