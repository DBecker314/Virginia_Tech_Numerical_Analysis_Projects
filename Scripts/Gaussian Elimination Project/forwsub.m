function X = forwsub(L,B)
[n,~] = size(L);
[~,m] = size(B);
X = zeros(n,m);
for j = 1:m
    y = B(:,j);
    forwsub1(L,y);
    X(:,j) = forwsub1(L,y);
end