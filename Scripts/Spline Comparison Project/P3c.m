function [S] = P3c(a)
%P2a − Creates a table of numerical error and order of accuracy for k
% piecewise polynomials, each with n_k polynomials, at h_k stepsize for
% f = xe^(-x) using quadratic spline with finite difference approximation.
% −Input:
% a - number of piecewise polynomials to compute
% −Output :
% S − A table of values for k, n_k, h_k, numerical error, and order of
% accuracy of each piecewise polynomial
%% set the function to interpolate
f = @(x) x*exp(-x);
%% initialize each column of the output table
n = zeros(a,1);
k = zeros(a,1);
h = zeros(a,1);
enum = zeros(a,1);
alpha = zeros(a,1);
%% loop for each entry in every vector previously initialized
for i = 1:a
%% calculate ith entry for k, n_k, and h_k
    k(i) = i;
    n(i) = 2^(i+1);
    h(i) = 2^(1-i);
%% calculate x and f(x) vectors to use in quadspline2
    X = 0:h(i):n(i);
    Y = zeros(n(i)+1,1);
    for l = 0:h(i):n(i)   
        Y(l/h(i)+1) = f(l);
    end
    pp = quadspline2(X,Y);
%% calculate numerical error and order of accuracy for each quadspline
    for m = 0:0.001:4
        if abs(f(m)-ppval(pp,m)) > enum(i)
            enum(i) = abs(f(m)-ppval(pp,m));
        end
    end
    if i ~= 1
        alpha(i) = log(enum(i)/enum(i-1))/log(h(i)/h(i-1));
    end
end
alpha(1) = "NAN";
%% create a results table for k, n_k, h_k, numerical error, and order or accuracy
R = table(k,n,h,enum,alpha,'VariableNames',{'k','n','h','error','accuracy'});
S = table(R,'VariableNames',{'Results'});
