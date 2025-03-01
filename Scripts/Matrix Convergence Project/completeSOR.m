function [Results,T,w_opt,rho] = completeSOR(A,b,x0,tol,Niter)
[A,b,x0] = Test(50);
tol = 10^-5;
Niter = 20;
[n,~] = size(A);
X = zeros(n,Niter);
X(:,1) = x0;
D = zeros(n);
U = -triu(A);
L = -tril(A);
for i = 1:n
    D(i,i) = A(i,i);
    U(i,i) = 0;
    L(i,i) = 0;
end
W = zeros(20001,1);
for w = 0:20000
    Dinv = (D-w/10000*L)\eye(n);
    T = Dinv*((1-w/10000)*D+w/10000*U);
    W(w+1) = max(abs(eig(T)));
end
[rho,I] = min(W);
w_opt = (I-1)/10000;
x = 0:0.0001:2;
plot(x,W);
Dinv = (D-w_opt*L)\eye(n);
T = Dinv*((1-w_opt)*D+w_opt*U);
for k = 2:Niter   
    X(:,k) = Dinv*w*b + T*X(:,k-1);
    if norm(X(:,k)-X(:,k-1),inf)/norm(X(:,k),inf) < tol  
        t = X(:,1:k);
        n = size(t,2);
        Iteration = zeros(n,1);
        Residual = zeros(n,1);
        Error = zeros(n,1);
        for i = 1:n
            Iteration(i) = i;
            Residual(i) = norm(A*X(:,i)-b,inf);
            Error(i) = norm(X(:,i)-A\b);
        end
        R = table(Iteration,Residual,Error);
        Results = table(R,'VariableNames',{'Results for all Iterations'});
        return
    end
end
Results = 'N/A';
disp('SOR failed to converge after maximum iterations')