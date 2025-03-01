function S = P3
[x,y]=markers_Euler(32,0.1,0.0001);
    enum = abs(0.15^2*pi-polyarea(x,y));
    enum2 = abs(0.15^2*pi-myarea(x,y));
R = table(enum,enum2, 'VariableNames',{'polyerror','myerror'});
S = table(R,'VariableNames',{'Results'});