function [pp] = quadspline(x,y,k)
%QUADSPLINE − computes the quadratic spline with given slope at the left
% endpoint.
% −Input:
% x − the vector of x_i values
% y − the vector of f(x_i)
% k − derivative f'(x) at left endpoint
% −Output :
% pp − A piecewise polynomial structure for the quadratic spline
%% initialize coefficient matrix
n = length(x)-1;
A = zeros(n,3);
%% Calculate a_0, b_0, and c_0
A(1,3) = y(1);
A(1,2) = k;
A(1,1) = (y(2)-A(1,3)-A(1,2)*(x(2)-x(1)))/(x(2)-x(1))^2;
%% Complete the coefficient matrix for a_i, b_i, and c_i
for i = 1:n-1
    A(i+1,3) = A(i,3)+A(i,2)*(x(i+1)-x(i))+A(i,1)*(x(i+1)-x(i))^2;
    A(i+1,2) = A(i,2)+2*A(i,1)*(x(i+1)-x(i));
    A(i+1,1) = (y(i+2)-A(i+1,3)-A(i+1,2)*(x(i+2)-x(i+1)))/(x(i+2)-x(i+1))^2;
end
%% Store spline in pp format
pp = mkpp(x,A);
