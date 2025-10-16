function penalty = scad(vx, lambda, a)
%%                          SCAD
%   penalty = scad(vx, lambda, a) computes the SCAD penalty for input vector vx
%   using tuning parameter lambda and SCAD parameter a (default = 3.7).
%
%   This implementation includes strong input validation and detailed
%   error handling suitable for integration into larger projects.
%
%   Inputs:
%       vx      - Numeric vector, matrix, or scalar (real values only)
%       lambda  - Positive scalar tuning parameter
%       a       - SCAD parameter (scalar > 2, default = 3.7)
%
%   Output:
%       penalty - Numeric array of same size as vx

    % Prevents undefined or missing variables from being used (e.g., beta2-type issues)
    if nargin < 2
        error('scad:MissingArguments', ...
              'Not enough input arguments. Usage: scad(vx, lambda, [a]).');
    end

    if isempty(vx)
        error('scad:EmptyVX', ...
              'Input "vx" cannot be empty. Provide a numeric array or scalar.');
    end

    if isempty(lambda)
        error('scad:EmptyLambda', ...
              'Input "lambda" cannot be empty. Provide a positive scalar.');
    end

    % if parameters are less than 3 that means a is not given; take a as
    % 3.7 
    if nargin < 3
        a = 3.7;
    end

    % Validation input and having an proper error handeling for faliures
    try
        validateattributes(vx, {'numeric'}, {'nonempty', 'real', 'finite'}, mfilename, 'vx');
    catch ME
        error('scad:InvalidVX', ...
              'Input "vx" must be a nonempty, finite, real numeric array.\n%s', ME.message);
    end

    try
        validateattributes(lambda, {'numeric'}, {'scalar', 'real', 'finite', 'positive'}, mfilename, 'lambda');
    catch ME
        error('scad:InvalidLambda', ...
              'Input "lambda" must be a finite, positive real scalar.\n%s', ME.message);
    end

    try
        validateattributes(a, {'numeric'}, {'scalar', 'real', 'finite', '>', 2}, mfilename, 'a');
    catch ME
        error('scad:InvalidA', ...
              'Input "a" must be a finite, real scalar greater than 2.\n%s', ME.message);
    end

    % Actual mathematical computation
    absVx = abs(vx);
    penalty = zeros(size(vx));

    % Case 1: |vx| ≤ lambda
    case1 = absVx <= lambda;
    % Penalty for case 1:
    penalty(case1) = lambda .* absVx(case1);

    % Case 2: lambda < |vx| ≤ a * lambda
    % Penalty for case 2:
    case2 = (absVx > lambda) & (absVx <= a * lambda);
    penalty(case2) = (-(absVx(case2).^2) + 2 * a * lambda * absVx(case2) - lambda^2) ./ (2 * (a - 1));

    % Case 3: |vx| > a * lambda
    % Penalty for case 3:
    case3 = absVx > a * lambda;
    penalty(case3) = ((a + 1) * lambda^2) / 2;

    % Checks if the result penalty contains any invalid numeric values, i.e.:
    % NaN (Not a Number)
    % Inf (Infinity) 
    if any(isnan(penalty(:))) || any(isinf(penalty(:)))
        warning('scad:NumericalInstability', ...
                'Numerical instability detected in SCAD computation (NaN or Inf values found).');
    end

    % Output:
    penalty = reshape(penalty, size(vx));

end
