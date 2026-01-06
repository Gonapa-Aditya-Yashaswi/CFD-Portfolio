# 1D Transient Heat Conduction (FDM)

## Problem Description
This project solves the one-dimensional transient heat conduction equation
in a rod using explicit and implicit finite difference schemes.

The objective is to study stability, accuracy, and time evolution of
temperature profiles.

---

## Governing Equation
\[
\frac{\partial T}{\partial t} = \alpha \frac{\partial^2 T}{\partial x^2}
\]

where:
- \(T\) is temperature
- \(\alpha\) is thermal diffusivity

---

## Numerical Methods
- Finite Difference Method (FDM)
- Spatial discretization: second-order central difference
- Time integration schemes:
  - FTCS (explicit)
  - BTCS (implicit)

---

## Boundary & Initial Conditions
- Prescribed temperature at both ends
- Uniform initial temperature distribution

---

## Validation
- Comparison with analytical transient solution
- Stability criteria verified for explicit scheme

---

## Projects Included
- FTCS: Explicit time-marching scheme
- BTCS: Implicit scheme solved using TDMA

---

## Key Learnings
- Stability limitation of explicit schemes
- Unconditional stability of implicit schemes
- Effect of time step size on accuracy

---

## Tools Used
- MATLAB

---

## Status
✅ Completed and validated

