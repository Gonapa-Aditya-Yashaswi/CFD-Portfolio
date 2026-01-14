# Lid-Driven Cavity Flow (Vorticity–Stream Function, FDM)

## Objective
Solve the 2D incompressible Navier–Stokes equations for flow inside a square
cavity driven by a moving top wall using the vorticity–stream function formulation.

Simulations performed for:
- Re = 100 (steady laminar)
- Re = 400 (strong secondary vortices)
- Re = 1000 (high-Re laminar)

---

## Governing Equations (ψ–ω formulation)

### Vorticity transport:

$\frac{\partial \omega}{\partial t}$ +
$u \frac{\partial \omega}{\partial x}$ +
$v \frac{\partial \omega}{\partial y}$ =
$\frac{1}{Re} \nabla^2 \omega$


### Stream function–vorticity relation:
$$
\nabla^2 \psi = -\omega
$$

### Velocity from stream function:
$$
u = \frac{\partial \psi}{\partial y} , \quad
v = -\frac{\partial \psi}{\partial x}
$$

---

## Numerical Method
- Finite Difference Method (FDM)
- Vorticity–stream function formulation
- Explicit/implicit handling of convection term
- Gauss–Seidel iteration for Poisson equation for ψ
- Uniform structured Cartesian mesh

---

## Boundary Conditions
- Top lid: $(u = U_{lid}, v = 0\)$
- Other walls: no-slip $(u = v = 0\)$
- Vorticity enforced from wall stream function

---

## Validation
Velocity profiles compared against **Ghia et al. (1982)** at:
- $( u \) vs \( y \) at \( x = 0.5 \)$
- $( v \) vs \( x \) at \( y = 0.5 \)$

---

## Results Available
- Streamlines $(\psi =\ constant)$
- Vorticity contours
- Velocity magnitude fields
- Centerline validation profiles

---

## Re Cases
- [Re = 100](Re100)
- [Re = 400](Re400)
- [Re = 1000](Re1000)

---

## Tools Used
- MATLAB

---

## Status
✔ Complete for Re = 100, 400, 1000
✔ Validated against benchmark profiles

