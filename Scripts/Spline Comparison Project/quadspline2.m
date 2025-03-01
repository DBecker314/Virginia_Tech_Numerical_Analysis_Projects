function [pp] = quadspline2(x,y)
%QUADSPLINE2 − computes the quadratic spline with slope at the left
% endpoint approximated by finite difference.
% −Input:
% x − the vector of x_i values
% y − the vector of f(x_i)
% −Output :
% pp − A piecewise polynomial structure for the quadratic spline
%% initialize coefficient matrix
n = length(x)-1;
A = zeros(n,3);
%% Calculate a_0, b_0, and c_0 using finite difference approximation
A(1,3) = y(1);
A(1,2) = finitder(0.001);
A(1,1) = (y(2)-A(1,3)-A(1,2)*(x(2)-x(1)))/(x(2)-x(1))^2;
%% Complete the coefficient matrix for a_i, b_i, and c_i
for i = 1:n-1
    A(i+1,3) = A(i,3)+A(i,2)*(x(i+1)-x(i))+A(i,1)*(x(i+1)-x(i))^2;
    A(i+1,2) = A(i,2)+2*A(i,1)*(x(i+1)-x(i));
    A(i+1,1) = (y(i+2)-A(i+1,3)-A(i+1,2)*(x(i+2)-x(i+1)))/(x(i+2)-x(i+1))^2;
end
%% Store spline in pp format
pp = mkpp(x,A);
