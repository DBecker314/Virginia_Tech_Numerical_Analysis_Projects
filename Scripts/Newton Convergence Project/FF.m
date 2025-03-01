function Y = FF
Y{1} = @(x,y,z) sin(x)+x*exp(y-2)+x+y^2+cos(z)-4;
Y{2} = @(x,y,z) x^4+8*x*y+3*z+10*z*y-3*pi/2-10*pi;
Y{3} = @(x,y,z) cos(x^2+z^2)-y*exp(z)-cos((pi^2)/4)+2*exp(pi/2);