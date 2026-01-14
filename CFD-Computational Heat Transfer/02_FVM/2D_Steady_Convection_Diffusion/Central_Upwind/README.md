# 2D Steady Convection–Diffusion (FVM) — Central & Upwind Schemes

## Objective
Solve the 2D steady convection–diffusion equation for a transported scalar
(e.g., temperature) using the Finite Volume Method with:

- Central differencing (CDS)
- First-order upwind differencing (UDS)

Both schemes are implemented within a single MATLAB code using a switch flag.

---

## Governing Equation


$u \frac{\partial T}{\partial x} + v \frac{\partial T}{\partial y} = \gamma \left(\frac{\partial^2 T}{\partial x^2} + \frac{\partial^2 T}{\partial y^2}\right)$




Domain:
\[
$0 \le x \le W,\quad$
$0 \le y \le H$
\]

Boundary conditions (Dirichlet):
- Left & Top: $\(T = 120^\circ C\)$
- Right & Bottom: $\(T = 40^\circ C\)$

---

## Numerical Method

### Discretization
- Cell-centered Finite Volume Method
- Diffusion term:
  
  $D = \frac{\gamma}{\Delta x}, \quad \frac{\gamma}{\Delta y}$
  
- Convection flux:
  
  $F = \rho u$
  

### Convection Schemes

#### Central Differencing (CDS)

$T_e = \frac{T_P + T_E}{2}$

- Second-order accurate
- May oscillate for high Peclet numbers

#### Upwind Differencing (UDS)

$T_e = T_P \quad (u>0)$

- First-order accurate
- Always bounded and stable
- Introduces numerical diffusion

Selected using:
```matlab
scheme = 'central';  % or 'upwind'
```

### Solver
- Point Gauss–Seidel iterations
- Convergence when:
  
  $\max |T^{new} - T^{old}| < 10^{-6}$
  

---

## Peclet Number Check
The code computes:

$Pe_x = \frac{\rho u \Delta x}{\gamma}, \quad$
$Pe_y = \frac{\rho v \Delta y}{\gamma}$

- If $\(Pe > 2\)$: Upwind recommended (stable)
- If $\(Pe < 2\)$: Central accurate

---

## Results

### CDS Contour
![central](../figures/central_contour.png)

### UDS Contour
![upwind](../figures/upwind_contour.png)

---

## Observations
- Central scheme provides sharper gradients for low Peclet numbers
- Upwind scheme damps oscillations and remains stable
- Demonstrates classic CFD trade-off:
  - **Central = accuracy (but oscillations)**
  - **Upwind = stability (but diffusion)**

---

## Validation
Validation was **not included**, but qualitative behavior matches expected theory:
- Central → contour symmetry with sharper transitions
- Upwind → smoother gradients due to numerical diffusion

---

## Tools Used
- MATLAB

---

## Status
✔ Code complete  
✔ Supports two convection schemes  
✔ Contours generated for both cases

