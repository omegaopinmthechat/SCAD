# SCAD Penalty Implementation in MATLAB

## Overview
This repository provides an implementation of the Smoothly Clipped Absolute Deviation (SCAD) penalty in MATLAB. The SCAD penalty is a popular method in high-dimensional statistical modeling for variable selection. It addresses the bias issues present in other methods like LASSO while encouraging sparsity and allowing for large coefficient values.

The SCAD penalty was introduced by Fan and Li (2001) and is part of the family of folded concave penalties. This repository includes MATLAB code for the SCAD penalty and its derivative, as well as utilities and test cases.

## SCAD Penalty Definition
The SCAD penalty function is defined piecewise as follows:

```math
  p_\lambda(\beta) = \begin{cases} 
    \lambda |\beta| & \text{if } |\beta| \leq \lambda, \\
    \frac{a\lambda|\beta| - \beta^2 - \lambda^2}{2(a-1)} & \text{if } \lambda < |\beta| \leq a\lambda, \\
    \frac{\lambda^2(a+1)}{2} & \text{if } |\beta| > a\lambda.
  \end{cases}
```

Here, λ is the regularization parameter, and a is a tunable parameter that controls how quickly the penalty drops off for large values of β.

## Repository Structure
- `scadPenalty/`
  - `scad.m`: Contains the implementation of the SCAD penalty function.
  - `utils.m`: Utility functions used in the SCAD implementation.
- `tests/`
  - `scadTest.m`: Test cases to validate the SCAD implementation.
- `README.md`: Documentation for the repository.
- `LICENSE`: License information.

## How to Use

### Prerequisites
- MATLAB installed on your system.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/omegaopinmthechat/SCAD.git
   ```
2. Navigate to the repository:
   ```bash
   cd SCAD
   ```
3. Open MATLAB and add the repository to the MATLAB path:
   ```matlab
   addpath(genpath('path_to_repository'));
   ```
4. Run the test cases to validate the implementation:
   ```matlab
   run('tests/scadTest.m');
   ```
5. Use the `scad.m` function in your MATLAB scripts to apply the SCAD penalty.

## Using the Utility Functions

### `utils.m`
The `utils.m` file contains utility functions that support the SCAD penalty implementation. These functions are designed to simplify common operations and calculations required for the SCAD penalty. Below is a guide on how to use the utilities:

1. **Common Operations**:
   - The utility functions include helper methods for matrix operations, thresholding, and other mathematical computations.
   - These functions can be directly called in your MATLAB scripts after adding the repository to the MATLAB path.

2. **Example Usage**:
   ```matlab
   % Example: Using a utility function
   result = someUtilityFunction(input1, input2);
   disp(result);
   ```

3. **Integration with SCAD**:
   - The utility functions are internally used by `scad.m` to compute intermediate values.
   - You can also use them independently for your custom implementations.

### `scadTest.m`
The `scadTest.m` file contains test cases to validate the SCAD penalty implementation. It ensures that the functions in `scad.m` and `utils.m` work as expected.

1. **Running Tests**:
   - Open MATLAB and navigate to the repository directory.
   - Run the test script:
     ```matlab
     run('tests/scadTest.m');
     ```
   - The script will output the results of the test cases, indicating whether the implementation is correct.

2. **Adding New Tests**:
   - You can add your own test cases to `scadTest.m` to validate additional scenarios.
   - Follow the existing test structure to ensure consistency.

## References
- [Andy Jones' Blog on SCAD](https://andrewcharlesjones.github.io/journal/scad.html)

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.
