beta = linspace(-5, 5, 100);
lambda = 2;                  
a = 3.7; 

penalty = scad(beta, lambda, a);

plot(beta, penalty, 'LineWidth', 2);
xlabel('beta');
ylabel('SCAD Penalty');
grid on;