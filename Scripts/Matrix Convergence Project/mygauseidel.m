function [Results,T,rho] = mygauseidel(A,b,x0,tol,Niter)
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
Dinv = (D-L)\eye(n);
T = Dinv*U;
rho = max(abs(eig(T)));
for k = 2:Niter
    X(:,k) = Dinv*b + T*X(:,k-1);
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
disp('Gauss-Seidel failed to converge after maximum iterations')
