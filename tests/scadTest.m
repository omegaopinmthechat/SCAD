clc; clear;

% 1. Add scadPenalty folder to MATLAB path
addpath('../scadPenalty');  % relative path from tests/ folder

% 2. Test plotSCAD
beta = linspace(-8, 8, 400);
lambda = 4;
a=2.5;


% Compute SCAD penalty using your scad function
penalty = scad(beta, lambda,a);  

% Call the plotting function
utils.plotSCAD(beta, penalty, lambda,a);

% 3. Test safeNormalize
data = [1, 5, 10];
normalizedData = utils.safeNormalize(data);
disp('Normalized Data:');
disp(normalizedData);

% 4. Test checkRange
try
    utils.checkRange(lambda, 0, 5, 'lambda');
    disp('lambda is in range!');
catch ME
    disp(ME.message);
end

