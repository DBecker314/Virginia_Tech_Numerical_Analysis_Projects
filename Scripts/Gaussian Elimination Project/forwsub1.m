function x = forwsub1(L,b)
[n,~] = size(L);
x = zeros(n,1);
for i = 1:n
    sum = 0;
        for k = 1:i
        sum = sum+L(i,k)*x(k);
        end
    x(i) = (b(i)-sum)/L(i,i);
end