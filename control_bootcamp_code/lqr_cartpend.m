% Modified 8Apr19 by Adwait Mane
% Created by Steve Brunton. faculty.washington.edu/sbrunton/control_bootcamp_code.zip
% Lecture: https://www.youtube.com/watch?v=1_UobILf3cc

clear all; close all; clc;

m = 1;
M = 5;
L = 2;
g = -10;
d = 1;

s = 1; % s=1 for pendulum up. s=-1 for pendulum down.

A = [0 1 0 0;
    0 -d/M -m*g/M 0;
    0 0 0 1;
    0 -s*d/(M*L) -s*(m+M)*g/(M*L) 0];
% Error in linearization. Element (2,4) and (4,4) should be non-zero.


B = [0; 1/M; 0; s*1/(M*L)];
eig(A)

Q = [1 0 0 0;
    0 1 0 0;
    0 0 10 0;
    0 0 0 100];
R = .01;

%%
det(ctrb(A,B))

%%
K = lqr(A,B,Q,R);

tspan = 0:.001:10;
if(s==-1)
    y0 = [0; 0; 0; 0]; % default y0 = [0; 0; 0; 0];
%     [t,y] = ode45(@(t,y)cartpend(y,m,M,L,g,d,-K*(y-[4; 0; 0; 0])),tspan,y0);
    [t,y] = ode45(@(t,y)cartpend(y,m,M,L,g,d,-K*y),tspan,y0);
elseif(s==1)
    y0 = [-3; 0; pi+.1; 0]; % default 
%     y0 = [0; 0; pi+.1; 0];
% % [t,y] = ode45(@(t,y)((A-B*K)*(y-[0; 0; pi; 0])),tspan,y0);
    [t,y] = ode45(@(t,y)cartpend(y,m,M,L,g,d,-K*(y-[1; 0; pi; 0])),tspan,y0); % default
    % [1; 0; pi; 0] is the reference value i.e. goal state
%     [t,y] = ode45(@(t,y)cartpend(y,m,M,L,g,d,-K*(y-[0; 0; pi; 0])),tspan,y0);
else

end

x_t = y; u_t = zeros(length(x_t),1); n = 4; m = 1;
plot_title = 'LQR cart-pend';

for i_u = 1:length(x_t)
% s = 1 pendulum up case
    % u_t(i_u) = -K*x_t(i_u,:)';
    u_t(i_u) = -K*(x_t(i_u,:)-[1 0 pi 0])'; % since we need delta-x about linearized point.
end

makePlots(x_t,u_t,n,m,plot_title)

figure(2);
for k=1:50:length(t)
    drawcartpend_bw(y(k,:),m,M,L);
end

% function dy = pendcart(y,m,M,L,g,d,u)