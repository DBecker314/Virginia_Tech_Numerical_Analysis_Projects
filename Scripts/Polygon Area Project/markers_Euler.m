function [x,y]=markers_Euler(Nm,t_end,dt)
%
% This functions outputs the positions of Nm markers at t_end. The markers
% are initially evenly distributed on the cirular interface. 
%
% For example, markers_Euler(32,0.1,0.0001) will compute the position of 32 
% markers at t=0.1, using a step size dt=0.0001. 
% 
% input 
%   Nm      -   number of marker points
%   t_end   -   end time computation
%   dt      -   time step size (t_end/dt should be an integer)
% output
%   x,y     -   x and y positions of makers at t_end
%   
if(nargin<3)
    dt=1.e-4;   % set default dt=1.e-4
end

% initial position of markers
theta=(1:Nm)'*(2*pi/Nm);    
x=0.5+0.15*cos(theta);
y=0.75+0.15*sin(theta);

% time integration using Euler's method
Nt=t_end/dt;   
for n=1:Nt
    for i=1:Nm
        [u,v]=velocity(x(i),y(i));  % get velocity
        x(i)=x(i)+dt*u;             % time marching using Euler's method
        y(i)=y(i)+dt*v;
    end
end
end

function [u,v]=velocity(x,y)
    u=-sin(pi*x)^2*sin(2*pi*y); 
    v=sin(pi*y)^2*sin(2*pi*x);
end
