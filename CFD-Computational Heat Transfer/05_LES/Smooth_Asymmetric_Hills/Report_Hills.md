# LES of Flow Over Smooth Asymmetric Hills

## Objective
To perform Large Eddy Simulation (LES) of turbulent flow over smooth
asymmetric hills and validate the mean flow and turbulence statistics
against published benchmark data.

## Simulation Details
- Solver: PadeOPS
- Turbulence modeling: Large Eddy Simulation (LES)
- Subgrid-scale model: Anisotropic subgrid scale model
- Flow type: Incompressible turbulent flow

## Results

### Mean Velocity Field
![Mean Velocity](./Figures/case1vel.png)

![Mean Velocity](./Figures/case2vel.png)

![Mean Velocity](./Figures/case3vel.png)

### Reynolds Stress / Turbulence Statistics
![Re Stress](./Figures/case1ti.png)

![Re Stress](./Figures/case2ti.png)

![Re Stress](./Figures/case3ti.png)

## Validation
Mean velocity profiles and turbulence statistics are compared with
benchmark data reported in literature. Good agreement is observed,
confirming the accuracy of the LES setup.

![Validation](./Figures/validation.png)

## Notes
This project demonstrates research-level LES capability and validation
of turbulent flow over complex terrain using PaDEOPS.
