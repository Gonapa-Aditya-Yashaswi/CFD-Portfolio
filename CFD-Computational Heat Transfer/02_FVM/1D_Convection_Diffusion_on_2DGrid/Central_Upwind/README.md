# 1D Convection–Diffusion Validation on 2D Grid (FVM)

## Objective
Validate finite volume discretization of the 1D steady convection–diffusion
equation using a 2D computational mesh, with selectable central or upwind
convective flux schemes.

---

## Governing Equation


$u \frac{dT}{dx} = \gamma \frac{d^2T}{dx^2}$


Flow assumed **only in the x-direction**:

$v = 0$


Boundary conditions:
- $\(T(0)=1\)$
- $\(T(L)=0\)$
- Top & Bottom boundaries set to zero (do not affect 1D solution)

---

## Analytical Solution

$T(x)=T_L + \frac{(T_R - T_L)(e^{Pe \, x/L}-1)}{e^{Pe}-1}$

Where Peclet number:

$Pe = \frac{u L}{\gamma}$


---

## Numerical Method
- Cell-centered finite volume method
- 2D grid used, but solution varies only in x
- Convective schemes via switch:
```matlab
scheme = 'central'; % or 'upwind'
```

### Central Differencing (CDS)
Second-order, accurate for low Peclet numbers

### Upwind Differencing (UDS)
First-order, unconditionally stable

Solver:
- Gauss–Seidel iteration
- Convergence to tolerance \(10^{-8}\)

---

## Validation
Centerline values extracted:

$T_{mid}(x) \approx T(x, Ny/2)$


Compared against analytical solution:
- Temperature profile overlay
- L2 error metric

---

## Results

### Contour Plot
![contour](../figures/contour_upwind.png)

### Centerline Validation
![centerline](../figures/centerline_upwind_vs_exact.png)

---

## Observations
- Numerical solution matches analytical curve
- Central accurate when Pe small; may oscillate at higher Pe
- Upwind produces bounded monotonic profile
- Confirms correct implementation of FVM discretization

---

## Tools Used
- MATLAB

---

## Status
✔ Convection–diffusion validated  
✔ Both CDS and UDS available  
✔ Analytical match confirmed

