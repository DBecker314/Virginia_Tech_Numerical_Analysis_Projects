function T = newton(f,fp,x0,tol,Nmax)
X = zeros(Nmax,1);
X(1) = x0-f(x0)/fp(x0);
for k = 2:Nmax
    X(k) = X(k-1)-f(X(k-1))/fp(X(k-1));
    if abs(f(X(k))) < tol  
        t = X(1:k);
        n = size(t,1);
        Iteration = zeros(n,1);
        x = zeros(n,1);
        F = zeros(n,1);
        for i = 1:n
            Iteration(i) = i;
            x(i) = X(i);
            F(i) = abs(f(X(i)));
        end
        R = table(Iteration,x,F,'VariableNames',{'Iteration','x','|f(x)|'});
        T = table(R,'VariableNames',{'Results for all Iterations'});
        return
    end
end
T = 'N/A';
disp('Newton method exceeds maximum iterations')