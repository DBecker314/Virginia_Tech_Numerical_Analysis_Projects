function [f0] = finitder(h)
%FINITDER − computes the slope at the left endpoint using five-point
% forward difference
% −Input:
% h − distance between x_i and x_{i+1}
% −Output :
% f0 − f'(0) when f = xe^(-x)
%% First five interpolation points of the function given in 2a
f = @(x) x.*exp(-x);
X0 = [0,h,2*h,3*h,4*h];
Y0 = f(X0);
%% approximate f'(0) with five-point forward difference formula
f0 = (-25*Y0(1)+48*Y0(2)-36*Y0(3)+16*Y0(4)-3*Y0(5))/(12*h);
