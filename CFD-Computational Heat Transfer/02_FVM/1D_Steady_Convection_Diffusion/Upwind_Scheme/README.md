
# 1D Steady Convection–Diffusion (FVM) — Upwind Scheme

## Objective
Solve the same 1D steady convection–diffusion equation using first-order upwind
discretization for convective fluxes.

---

## Governing Equation

$$
u \frac{dT}{dx} = \alpha \frac{d^2T}{dx^2}
$$

Same boundary conditions as central scheme.

---

## Numerical Method
- Diffusion handled using central differencing
- Convection handled using upwind:
  
  $T_e = T_P \quad (u>0)$
 
- Ensures:
  - Positivity
  - Boundedness
  - No oscillations
- But introduces **numerical diffusion**

---

## Results

### Temperature Profile (Upwind)
![upwind](../figures/1D_upwind.png)

### Comparison With Central
![comparison](../figures/central_vs_upwind.png)

---

## Observations
- Stable for all Peclet numbers
- No non-physical oscillations
- Solution becomes smeared at high Pe

---

## Tools Used
- MATLAB

---

## Status
✔ Completed  
✔ Stable for all Pe
