n = 10;
A = zeros(n,n);
b = zeros(n,1);
x0 = zeros(n,1);
for i = 1:n-1
    A(i,i) = 2;
    A(i+1,i) = -0.5;
    A(i,i+1) = -0.5;
    A(n,n) = 2;
    b(1) = 1;
    b(i+1) = 2;
    
end
b;
x0;
tol = 10^-5;
Niter = 30;
mygauseidel(A,b,x0,tol,Niter)