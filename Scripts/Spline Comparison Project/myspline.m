function [pp]=myspline(x,Y,endtype)
%MYSPLINE - computes the cubic spline with different types of endpoint
% conditions
% -Input:
%       x(1:n)  -   interpolation points
%       Y(1:n)  -   (endtype=1,3)  function values at interpolation 
%                   points x(1:n)
%       Y(1:n+2)-   (endtype=2) Y(1)=f'(x(1)), Y(n+2)=f'(x(n)),
%                   Y(2:n-1)=function values at x(1:n)
%       endtype -   (integer) endpoint condition type
%                   1: natural spline (f"=0 at end points)
%                   2: clamped spline (f' given at end points)
%                   3: not-a-knot spline
% -Output:
%       pp      -   piecewise polynomial of pp form
%                   (1) Use [breaks, coefs]=unmkpp(pp) to get the
%                       coefficients of pp.
%                       breaks(1:n): break(i)=x(i)
%                       coefs(1:n-1,1:4): coefs(i,1:4)=coefficients 
%                           [d,c,b,a] of the cubic polynomial on interval
%                           [x(i),x(i+1)]
%                   (2) Use y=ppeval(pp,x) to evaulate pp at x.
% 
% This code is writen for Math 4446 based on Section 11.3 of Ascher & 
% Greif's textbook.   -P. Yue
%% prepare data
n=length(x);
h=x(2:n)-x(1:n-1);  %grid spacing
if(endtype~=2)
    if(length(Y)~=n)
        error('The lengths of x and Y should be the same');
    end
    y=Y(1:n);
else
    if(length(Y)~=n+2)
        error('The length of Y should equal length(x)+2');
    end
    y=Y(2:n+1);
    dy1=Y(1);
    dyn=Y(n+2);
end
%% initialize arrays for the coefficients of the spline
a=zeros(n,1);           %a(n) is declared for convenience
b=zeros(n-1,1);     
d=zeros(n-1,1);     
%% calculate a(1:n)
a(1:n)=y(1:n);                                          % Eq. (11.3a)
%% calculate c(1:n)
A=sparse(n,n);
B=zeros(n,1);
for i=2:n-1
    A(i,i-1:i+1)=[h(i-1),2*(h(i-1)+h(i)),h(i)];         % Eq. (11.5)
    B(i)=3*((a(i+1)-a(i))/h(i)-(a(i)-a(i-1))/h(i-1));   %
end
switch endtype
    case 1 %natural spline
        A(1,1)=1;                                       % c(1)=c(n)=0
        A(n,n)=1;
        B(1)=0;
        B(n)=0;
    case 2 %clampled spline
        A(1,1:2)=[2*h(1),h(1)];                         % see page 343
        A(n,n-1:n)=[h(n-1),2*h(n-1)];
        B(1)=3*((a(2)-a(1))/h(1)-dy1);
        B(n)=3*(dyn-(a(n)-a(n-1))/h(n-1));
    case 3 %not-a-knot spline
        A(1,1:3)=[-h(2),h(1)+h(2),-h(1)];               % d(1)=d(2)
        A(n,n-2:n)=[-h(n-1),h(n-2)+h(n-1),-h(n-2)];     % d(n-1)=d(n)
        B(1)=0;
        B(n)=0;
    otherwise
        error('wrong endpoint condition type');
end
c=A\B;      % c(n) is also included for convenience 
%% calculate b(1:n-1) and d(1:n-1)
for i=1:n-1
    b(i)=(a(i+1)-a(i))/h(i)-(2*c(i)+c(i+1))*h(i)/3;     % Eq. (11.4b)
    d(i)=(c(i+1)-c(i))/(3*h(i));                        % Eq. (11.4a)
end
%% store the spline in pp format
coefs=[d(1:n-1),c(1:n-1),b(1:n-1),a(1:n-1)];
pp=mkpp(x,coefs);
end

        
        
        

