function [T,rho,w_opt,values] = mySOR(A)
[A] = Test(20);
[n,~] = size(A);
D = zeros(n);
U = -triu(A);
L = -tril(A);
for i = 1:n
    D(i,i) = A(i,i);
    U(i,i) = 0;
    L(i,i) = 0;
end
W = zeros(21,1);
for w = 0:20
    Dinv = (D-w/10*L)\eye(n);
    T = Dinv*((1-w/10)*D+w/10*U);
    W(w+1) = max(abs(eig(T)));
end
[rho,I] = min(W);
w_opt = (I-1)/10
x = 0:0.1:2;
plot(x,W)
Dinv = (D-w_opt*L)\eye(n);
T = Dinv*((1-w_opt)*D+w_opt*U);
Omega = zeros(21,1);
Rho = zeros(21,1);
for i = 1:21
    Omega(i) = (i-1)/10;
    Rho(i) = W(i);
end
values = table(Omega,Rho)
