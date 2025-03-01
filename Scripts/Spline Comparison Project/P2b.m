function [T1,T2,T3,T4] = P2b(a)
%P2b − Creates a table of numerical error and order of accuracy for k
% piecewise polynomials, each with n_k polynomials, at h_k stepsize for
% f = xe^(-x) using quadratic spline and the three cubic splines.
% −Input:
% a - number of piecewise polynomials to compute
% −Output :
% T1 − A table of values for k, n_k, h_k, numerical error, and order of
% accuracy of each piecewise polynomial using a quadratic spline
% T2 − A table of values for k, n_k, h_k, numerical error, and order of
% accuracy of each piecewise polynomial using a natural cubic spline
% T3 − A table of values for k, n_k, h_k, numerical error, and order of
% accuracy of each piecewise polynomial using a clamped cubic spline
% T4 − A table of values for k, n_k, h_k, numerical error, and order of
% accuracy of each piecewise polynomial using a not-a-knot cubic spline
%% set the function to interpolate
f = @(x) x.*exp(-x);
%% setup x and f(x) vectors for quadratic, natural, and not-a-knot splines
x = [0,1,2,3,4];
y = [0,exp(-1),2*exp(-2),3*exp(-3),4*exp(-4)];
%% setup f(x) vector with f'(0) and f'(4) for clamped spline
y2 = [1,0,exp(-1),2*exp(-2),3*exp(-3),4*exp(-4),exp(-4)-4*exp(-4)];
%% calculate the four splines and store in pp format
pp1 = quadspline(x,y,1);
pp2 = myspline(x,y,1);
pp3 = myspline(x,y2,2);
pp4 = myspline(x,y,3);
%% graph the four splines along with the original function f, and the 5 nodes
hold on
xq = 0:0.001:4;
fplot(f,[0,4],'black')
plot(xq,ppval(pp1,xq),'red');
plot(xq,ppval(pp2,xq),'green');
plot(xq,ppval(pp3,xq),'blue');
plot(xq,ppval(pp4,xq),'cyan');
scatter(x,y,'filled','black');
legend('f','quad','natural','clamped','not-a-knot','nodes');
%% create an error and accuracy table for each of the four splines
T1 = P2a(a);
T2 = mysplinetable(a,1);
T3 = mysplinetable(a,2);
T4 = mysplinetable(a,3);
