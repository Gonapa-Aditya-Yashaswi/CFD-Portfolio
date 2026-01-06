# 1D Steady-State Heat Conduction (FDM)

## Problem Description
This project solves the one-dimensional steady-state heat conduction equation
for a uniform rod with and without internal heat generation using the Finite
Difference Method (FDM).

Both cases are validated against analytical solutions.

---

## Governing Equation

### Without Heat Generation
\[
\frac{d^2 T}{dx^2} = 0
\]

### With Uniform Heat Generation
\[
\frac{d^2 T}{dx^2} = -\frac{q'''}{k}
\]

where:
- \(T\) is temperature
- \(q'''\) is volumetric heat generation
- \(k\) is thermal conductivity

---

## Numerical Method
- Method: Finite Difference Method (FDM)
- Discretization: Second-order central difference
- Grid: Uniform 1D grid
- Linear solver: Gauss–Seidel / TDMA / Jacobi

---

## Boundary Conditions
- Left boundary: 300 °C
- Right boundary: 400 °C

---

## Case 1: No Heat Generation
- Governing equation reduces to Laplace equation
- Linear temperature distribution obtained
- Numerical solution matches analytical solution exactly (within machine error)

---

## Case 2: With Uniform Heat Generation
- Poisson equation solved
- Parabolic temperature distribution obtained
- Numerical solution validated against analytical solution

---

## Validation
- Analytical solutions derived for both cases
- Maximum absolute error and L2 norm evaluated
- Grid refinement confirms second-order accuracy

---

## Results
- Temperature profiles plotted along the wall
- Excellent agreement between numerical and analytical solutions
- Error decreases with grid refinement

---

## Key Learnings
- Implementation of second-order central difference scheme
- Effect of source term on temperature distribution
- Importance of grid resolution and numerical accuracy

---

## Tools Used
- MATLAB

---

## Status
✅ Completed and validated


