function S = NNewton(FF,JF,X0,Nmax,tol)
[~,m] = size(FF);
N = zeros(m,Nmax);
Jac = zeros(m,m);
B = zeros(m,1);
Init = FF;
L = JF;
for i = 1:m
    B(i) = -feval(Init{i},X0(1),X0(2),X0(3));
    for k = 1:m
        Jac(i,k) = feval(L{i,k},X0(1),X0(2),X0(3));
    end
end
X = Jac\B;
N(:,1) = X+X0;
for p = 2:Nmax
    for i = 1:m
        B(i) = -feval(Init{i},N(1,p-1),N(2,p-1),N(3,p-1));
        for k = 1:m
            Jac(i,k) = feval(L{i,k},N(1,p-1),N(2,p-1),N(3,p-1));
        end
    end
    N(:,p) = Jac\B+N(:,p-1);
    if norm(B,inf) < tol  
        t = N(:,1:p);
        n = size(t,2);
        Iteration = zeros(n-1,1);
        x = zeros(n-1,1);
        y = zeros(n-1,1);
        z = zeros(n-1,1);
        F = zeros(n-1,1);
        for i = 1:n-1
            Iteration(i) = i;
            x(i) = N(1,i);
            y(i) = N(2,i);
            z(i) = N(3,i);
            for r = 1:m
                B(r) = -feval(Init{r},N(1,i),N(2,i),N(3,i));
            end
            F(i) = norm(B,inf);
        end
        R = table(Iteration,x,y,z,F,'VariableNames',{'Iteration','x','y','z','||f(x,y,z)||'});
        S = table(R,'VariableNames',{'Results for all Iterations'});
        return
    end
end
S = 'N/A';
disp('Newton method exceeds maximum iterations')