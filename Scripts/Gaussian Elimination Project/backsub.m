function X = backsub(U,B)
[n,~] = size(U);
[~,m] = size(B);
x = zeros(n,1);
X = zeros(n,m);
for j = 1:m
    y = B(:,j);
    for i = n:-1:1
    sum = 0;
        for k = i+1:n
        sum = sum+U(i,k)*x(k);
        end
    x(i) = (y(i)-sum)/U(i,i);
    end
X(:,j) = x;
end