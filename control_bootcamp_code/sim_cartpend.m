% Modified 8Apr19 by Adwait Mane
% Created by Steve Brunton. faculty.washington.edu/sbrunton/control_bootcamp_code.zip
% Lecture: https://www.youtube.com/watch?v=1_UobILf3cc

clear all, close all; clc;

m = 1;
M = 5;
L = 2;
g = -10;
d = 1;

tspan = 0:.1:3;
y0 = [0; 0; pi; .5];
[t,y] = ode45(@(t,y)cartpend(y,m,M,L,g,d,0),tspan,y0);


%% Plot
x_t = y; n = 4;

figure(1); clf; 
movegui(gcf,'southwest');

% Inputs: n, x_t. Need x_t and u_t arranged vertically i.e. each row is value at given
% time.

leg_str_pos = [];
for i_p = 1:2:n % Position plots
    subplot(3,1,1)
    plot(x_t(:,i_p)); hold on;
    ylabel('pos'); title("Cart-pole open-loop");

    leg_str_pos = [leg_str_pos , string(num2str(i_p))];
end
legend(leg_str_pos);

leg_str_vel = [];
for i_p = 2:2:n % Velocity plots
    subplot(3,1,2)
    plot(x_t(:,i_p)); hold on;
    ylabel('vel')

    leg_str_vel = [leg_str_vel , string(num2str(i_p))];
end
legend(leg_str_vel); hold off; 

%% Animate
figure(2);
for k=1:2
    drawcartpend_bw(y(k,:),m,M,L);
end
disp('End')