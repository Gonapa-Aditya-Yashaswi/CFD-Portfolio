# 2D Steady-State Heat Conduction (FVM) — With Uniform Heat Source

## Objective
Solve the 2D steady-state heat conduction equation in a square or rectangular
domain with a uniform internal volumetric heat source using the Finite Volume Method (FVM).

---

## Governing Equation
$$
\nabla^2 T + \frac{q'''}{k} = 0
$$

Boundary conditions:
- Fixed temperature (Dirichlet) on all walls

---

## Numerical Method
- Cell-centered finite volume method
- Control volume discretization:
  
  $a_W T_{i-1,j} + a_E T_{i+1,j} + a_S T_{i,j-1} + a_N T_{i,j+1} - a_P T_{i,j} = b_{i,j}$
  
- Coefficients:

  $a_W = a_E = \frac{k}{\Delta x},\quad$
  $a_S = a_N = \frac{k}{\Delta y},\quad$
  $a_P = a_W + a_E + a_S + a_N$
  

Source treatment:

$b_{i,j} = q''' \Delta x \Delta y$


Boundary control volumes use half-face area for source.

Solver:
- Iterative Gauss–Seidel update
- Converged when residual < tolerance

---

## Validation
Steady-state solution compared against analytical/symmetry profiles:
- Temperature along $(x = L/2\)$
- Temperature along $(y = W/2\)$

Slope curvature increases due to internal heating.
Matching trend confirms correctness.

---

## Results

### Temperature Contour (With Source)
![temperature](../figures/temperature_contour_source.png)

### Mid-Width Profile (\(x = L/2\))
![mid width](../figures/mid_width_validation_source.png)

### Mid-Height Profile (\(y = W/2\))
![mid height](../figures/mid_height_validation_source.png)

---

## Observations
- Internal heat source raises temperature inside the domain
- The field becomes parabolic rather than harmonic
- Influence of source term clearly visible in center
- Grid refinement reduces deviation from analytical values

---

## Tools Used
- MATLAB

---

## Status
✔ Completed  
✔ Validated using centerline comparison

