function b = RHS(n)
b = zeros(n,1);
for i = 1:n
    sum = 0;
    for j = 1:n
        sum = sum + 1/(i+j-1);
    end
    b(i) = sum;
end