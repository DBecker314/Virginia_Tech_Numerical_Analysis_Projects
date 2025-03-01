function S = P2(iter)
k = zeros(iter,1);
n = zeros(iter,1);
enum = zeros(iter,1);
alpha = zeros(iter,1);
for l = 1:iter
    k(l) = l;
    n(l) = 2^(l-1)*10;
    theta = zeros(n(l),1);
    x = zeros(n(l),1);
    y = zeros(n(l),1);

    for i = 1:n(l)
        theta(i) = 2*i*pi/n(l);
        x(i) = (3*sqrt(2)/2)*cos(theta(i))-sqrt(2)*sin(theta(i));
        y(i) = (3*sqrt(2)/2)*cos(theta(i))+sqrt(2)*sin(theta(i));
    end
    enum(l) = abs(6*pi-myarea(x,y));
end
for l = 2:iter
    alpha(l) = log2(abs(enum(l-1)/enum(l)));
end

R = table(k,n,enum,alpha, 'VariableNames',{'k','n','error','accuracy'});
S = table(R,'VariableNames',{'Results'});