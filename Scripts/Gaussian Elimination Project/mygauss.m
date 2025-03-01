function [X,row] = mygauss(A,B)
adj = [A,B];
[n,m] = size(adj);
row = (1:n)';
Scales = zeros(n,1);
for k = 1:n
    Scales(k) = max(abs(A(k,:)));
end
for j = 1:n-1
    d = zeros(n-j+1,1);
    for i = j:n
    d(i) = abs(A(i,j))/Scales(i);
    end
    [~,p] = max(d(j:n));
    P = p+j-1;
        temp = adj(j,:);
        adj(j,:) = adj(P,:);
        adj(P,:) = temp;
        t = row(j);
        row(j) = row(P);
        row(P) = t;
    for i = j+1:n
        s = adj(i,j)/adj(j,j);
        adj(i,:) = adj(i,:) - s*adj(j,:);
    end
end
U = adj(:,1:m-1);
b = adj(:,m);
X = backsub(U,b);