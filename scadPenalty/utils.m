classdef utils
    % UTILS - Utility class for SCAD package and general numerical tasks.
    %
    %   Provides reusable helper functions such as plotting routines,
    %   input checks, and data normalization — all written with robust
    %   validation and clear error handling for industrial or research-grade
    %   MATLAB applications.
    %
    %   Example:
    %       beta = linspace(-8, 8, 400);
    %       lambda = 2;
    %       a = 3.7;
    %       penalty = scad(beta, lambda, a);
    %       utils.plotSCAD(beta, penalty, lambda, a);
    
    methods(Static)
        %% 1. SCAD plotting function
        function plotSCAD(beta, penalty, lambda, a)
    % plotSCAD  Robust plotting function for SCAD penalty visualization.
    %
    %   utils.plotSCAD(beta, penalty, lambda)
    %   utils.plotSCAD(beta, penalty, lambda, a)
    %
    %   Inputs:
    %       beta     - Vector or numeric array of coefficients
    %       penalty  - Corresponding SCAD penalty values
    %       lambda   - Tuning parameter (positive scalar)
    %       a        - SCAD shape parameter (scalar > 2, default = 3.7)

    % Set default for 'a' if not provided
    if nargin < 4 || isempty(a)
        a = 3.7;
    end

    % Input Validation with error handling
    try
        validateattributes(beta, {'numeric'}, {'nonempty', 'real', 'finite'}, mfilename, 'beta');
        validateattributes(penalty, {'numeric'}, {'nonempty', 'real', 'finite'}, mfilename, 'penalty');
        validateattributes(lambda, {'numeric'}, {'scalar', 'real', 'finite', 'positive'}, mfilename, 'lambda');
        validateattributes(a, {'numeric'}, {'scalar', 'real', 'finite', '>', 2}, mfilename, 'a');
    catch ME
        error('utils:InvalidInput', 'Invalid input(s) provided to plotSCAD.\nDetails: %s', ME.message);
    end

    % Size Consistency Check
    if numel(beta) ~= numel(penalty)
        error('utils:SizeMismatch', 'Length of beta (%d) must match length of penalty (%d).', numel(beta), numel(penalty));
    end

    % Plotting
    try
        figure('Name', sprintf('SCAD Penalty (λ=%.2f, a=%.2f)', lambda, a), ...
               'Color', 'w', 'NumberTitle', 'off');
        plot(beta, penalty, 'LineWidth', 2);
        xlabel('\beta', 'FontSize', 12);
        ylabel('SCAD Penalty', 'FontSize', 12);
        title(sprintf('SCAD Penalty (λ=%.2f, a=%.2f)', lambda, a), 'FontSize', 13, 'FontWeight', 'bold');
        grid on;
        set(gca, 'FontSize', 11);
    catch ME
        error('utils:PlotError', 'Error while generating SCAD plot.\nDetails: %s', ME.message);
    end
end

        %% 2. Safe Normalization Utility
        function out = safeNormalize(data)
            % safeNormalize  Safely normalizes numeric data to [0, 1] range.
            %
            %   out = utils.safeNormalize(data)
            %
            %   Automatically handles NaN, Inf, and constant-value arrays.
            %
            %   Example:
            %       x = [1, 5, 10];
            %       y = utils.safeNormalize(x);
            
            try
                validateattributes(data, {'numeric'}, {'nonempty', 'real', 'finite'}, mfilename, 'data');
            catch ME
                error('utils:InvalidData', ...
                      'Data must be a nonempty, real, finite numeric array.\n%s', ME.message);
            end

            minVal = min(data(:));
            maxVal = max(data(:));

            if minVal == maxVal
                warning('utils:ConstantData', ...
                        'Input data is constant; returning zeros array.');
                out = zeros(size(data));
                return;
            end

            out = (data - minVal) ./ (maxVal - minVal);
        end

        %% 3. Safe Range Checker
        function checkRange(value, lower, upper, varName)
            % checkRange  Ensures a numeric variable lies within a range.
            %
            %   utils.checkRange(value, lower, upper, varName)
            %
            %   Throws error if value < lower or value > upper.
            %
            %   Example:
            %       utils.checkRange(5, 0, 10, 'lambda');
            
            if nargin < 4
                varName = 'variable';
            end

            if ~isscalar(value) || ~isnumeric(value) || isnan(value)
                error('utils:InvalidValue', ...
                      '%s must be a numeric scalar.', varName);
            end

            if value < lower || value > upper
                error('utils:OutOfRange', ...
                      '%s (%.4f) is out of range [%.4f, %.4f].', ...
                      varName, value, lower, upper);
            end
        end

        %% 4. Safe Figure Cleaner
        function clearFigures()
            % clearFigures  Closes all open figures safely.
            %
            %   utils.clearFigures()
            %
            %   Does not error if no figures exist.
            try
                figs = findall(0, 'Type', 'figure');
                if ~isempty(figs)
                    close(figs);
                end
            catch ME
                warning('utils:FigureCloseError', ...
                        'Could not close figures safely.\n%s', ME.message);
            end
        end
    end
end
