function penalty = scad(vx, lambda, a)
% vx      : input vector
% lambda  : tuning parameter


% a: SCAD parameter (default 3.7)
% if the user doesn't give the 'a' parameter it will take a = 3.7 
% if user gives >= 3 paramters it will take the last value and store it
% as a
if nargin < 3 
    a = 3.7;
end

penalty = zeros(size(vx));

% Case 1: |vx| <= lambda  --> behaves like LASSO
case1 = abs(vx) <= lambda;
penalty(case1) = lambda .* abs(vx(case1));

% Case 2: lambda < |vx| <= a*lambda  --> quadratic
case2 = (abs(vx) > lambda) & (abs(vx) <= a * lambda);
penalty(case2) = (- (abs(vx(case2)).^2) + 2*a*lambda*abs(vx(case2)) - lambda^2) ./ (2*(a-1));

% Case 3: |vx| > a*lambda  --> constant penalty
case3 = abs(vx) > a * lambda;
penalty(case3) = ((a+1) * lambda^2) / 2;

end
