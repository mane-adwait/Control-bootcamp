% Modified 8Apr19
% 
% Input descriptions:
% n states, m controls
% Need x_t and u_t arranged vertically i.e. each row is value at given
% time.

function makePlots(x_t,u_t,n,m,plot_title)

figure(1); clf; movegui(figure(1),'southwest');

% States: 1:2:n is position, 2:2:n is velocity.
%   Previously 1:n/2 is position, n/2+1:n is velocity.

leg_str_pos = [];
for i_p = 1:2:n
    subplot(3,1,1)
    plot(x_t(:,i_p)); hold on;
    ylabel('pos'); leg_str_pos = [leg_str_pos , string(num2str(i_p))];
    title(plot_title);
end
legend(leg_str_pos);

leg_str_vel = [];
for i_p = 2:2:n
    subplot(3,1,2)
    plot(x_t(:,i_p)); hold on;
    ylabel('vel'); leg_str_vel = [leg_str_vel , string(num2str(i_p))];
end
legend(leg_str_vel);

leg_str_u = [];
for i_p = 1:m
    subplot(3,1,3)
    plot(u_t(:,i_p)); hold on;
    ylabel('u'); leg_str_u = [leg_str_u , string(num2str(i_p))];
end
legend(leg_str_u);
hold off;
end