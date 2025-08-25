beta = linspace(-5,5,100);  
lambda = 2;
a = 2.5;
beta2 = [1 -2 3];

penalty = scad(beta, lambda); %takes a = 3.7
penalty2 = scad(beta, lambda, a);
penalty3 = scad(beta2, lambda);
disp(['Total SCAD penalty = ', num2str(penalty)]);
disp(['Total SCAD penalty2 = ', num2str(penalty2)]);
disp(['Total SCAD penalty2 = ', num2str(penalty3)]);

figure;
plot(beta, penalty, 'LineWidth', 2);
xlabel('beta');
ylabel('SCAD Penalty');
title('penalty 1');
grid on;

figure;
plot(beta, penalty2, 'LineWidth', 2);
xlabel('beta');
ylabel('SCAD Penalty');
title('penalty 2');
grid on;

figure;
plot(beta2, penalty3, 'LineWidth', 2);
xlabel('beta');
ylabel('SCAD Penalty');
title('penalty 3');
grid on;