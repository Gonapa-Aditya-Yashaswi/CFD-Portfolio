# 1D Steady-State Heat Conduction (FVM) — With Uniform Heat Source

## Objective
Solve the steady-state heat conduction equation in a 1D rod with internal
volumetric heat generation using the Finite Volume Method.

---

## Governing Equation
$$
\frac{d^2 T}{dx^2} + \frac{q'''}{k} = 0
$$

With boundary conditions: 

- $T(0) = T_L, \qquad T(L) = T_R$


Analytical solution:

- $T(x) = -\frac{q'''x^2}{2k}$
       + $\left(\frac{T_R - T_L + \frac{q'''L^2}{2k}}{L}\right)x$
       + $T_L$


---

## Numerical Method
- Cell-centered finite volume method
  
- Uniform mesh with \( $\Delta x = L/N \$)
  
- Constant thermal conductivity
  
- Interior control volume balance: $a_W T_{i-1} + a_P T_{i} + a_E T_{i+1} = b_i$
  
- Source term contribution: $b_i = q''' \Delta x$
  
- Boundary control volumes use \($\Delta x/2\$)

- Linear system solved using MATLAB backslash operator.

---

## Note
The source term enters naturally into the control-volume balance,
demonstrating why the Finite Volume Method provides a systematic and
general framework for conduction problems with internal generation.

---

## Validation
Temperature at cell centers matches the analytical parabolic solution.
Error decreases with grid refinement.

---

## Results

### Temperature Distribution
![temperature](../figures/temp_profile_with_source.png)

---

## Tools Used
- MATLAB

---

## Status
✔ Completed and validated

