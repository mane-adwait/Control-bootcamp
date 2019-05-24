
close all;
A = [0]; B = [1]; Q = [1]; R = [1]; % System matrices
sys_c = ss(A,B,0,0); % Create state-space model
K = lqr(A,B,Q,R); % Calculate optimal gain

% Integrate and plot solution
tspan_c = 0:.05:10; x0 = [3];
[t_c,x_c] = ode45(@(t,x) -K*x,tspan_c,x0);
plot(t_c,x_c,'-'); hold on; 

% Create discrete-time version of system
Ts = 0.1; sys_d = c2d(sys_c,Ts);
A_d = sys_d.A; B_d = sys_d.B;
K_d = dlqr(A_d,B_d,Q,R,0);

% Calculate and plot solution
x_d = x0;
t_d = 0:Ts:10;
for i_d = 1:length(t_d)-1
    x_d(i_d+1) = (A_d-B_d*K_d)*x_d(i_d);
end
plot(t_d,x_d,'+'); legend(["cont","disc"])