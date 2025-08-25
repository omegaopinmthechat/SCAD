function penalty = scad(beta, lambda, a)

penalty = penaltyCalculator(beta, lambda, a);

plot(beta, penalty, 'LineWidth', 2);
xlabel('beta');
ylabel('SCAD Penalty');
grid on;

end

function penalty = penaltyCalculator (beta, lambda, a)
abs_beta = abs(beta);
% Case 1:
case1 = (abs_beta <= lambda);

% Case 2:
case2 = (abs_beta > lambda) & (abs_beta <= a * lambda);

% Case 3: 
case3 = (abs_beta > a * lambda);

% New array named penalty with elements = 0s
penalty = zeros(size(beta));

% 1. abs_beta<=lambda
penalty(case1) = lambda * abs_beta(case1);

% 2. abs_beta>lambda & abs_beta<=a*lambda 
penalty(case2) = (-abs_beta(case2).^2 + 2*a*lambda*abs_beta(case2) - lambda^2) ./ (2 * (a - 1));

% 3. abs_beta> a*lambda
penalty(case3) = ((a + 1) * lambda^2) / 2;

end