# Numerical Study of Fin Number in a Heat Sink using ANSYS Icepak

## Objective

To investigate the effect of fin number on the thermal and fluid-flow
performance of a heat sink using ANSYS Icepak.

Four heat sink configurations with 5, 10, 15, and 20 fins were simulated
while maintaining a constant fin thickness of 0.025 cm (0.25 mm).

---

## Simulation Details

- Software: ANSYS Icepak
- Flow: Laminar
- Working fluid: Air
- Fin type: Rectangular fins
- Fin thickness: 0.025 cm (0.25 mm)
- Number of fins: 5, 10, 15, 20
- Simulation: Steady-state
- Heat transfer: Conjugate heat transfer

---

## Geometry

The heat sink geometry was varied by changing the number of fins while
keeping the fin thickness constant.

![Geometry](./Figures/geometry.png)

---

## Results

### N = 5 Fins

![N5 Temperature](./Figures/n=5/temp.png)

![N5 Velocity](./Figures/n=5/speed.png)

![N5 Pressure](./Figures/n=5/press.png)

---

### N = 10 Fins

![N10 Temperature](./Figures/n=10/temp2.png)

![N10 Velocity](./Figures/n=10/speed.png)

![N10 Pressure](./Figures/n=10/press2.png)

---

### N = 15 Fins

![N15 Temperature](./Figures/n=15/temp.png)

![N15 Velocity](./Figures/n=15/speed.png)

![N15 Pressure](./Figures/n=15/press.png)

---

### N = 20 Fins

![N20 Temperature](./Figures/n=20/tem.png)

![N20 Velocity](./Figures/n=20/press.png)

![N20 Pressure](./Figures/n=20/press2.png)

---

## Parametric Comparison

| Number of Fins | Paper (°C) | Present Work (°C) | Error (%) |
|---:|---:|---:|---:|
| 5  | 89.6266 | 83.804 | −6.50 |
| 10 | 62.9506 | 60.300 | −4.21 |
| 15 | 58.8103 | 54.349 | −7.59 |
| 20 | 61.9335 | 52.365 | −15.45 |

---

## Key Findings

- Increasing the number of fins initially improves heat dissipation.
- Increasing fin density also increases the available heat-transfer area.
- Excessive fin density can restrict the flow passages between fins.
- The reference study reported an optimum fin number of 15 for the
  investigated configurations.
- The reference study also identified 0.25 mm as the optimum fin thickness.

---

## Conclusion

A parametric study of a finned heat sink was performed using ANSYS Icepak
for 5, 10, 15, and 20 fins at a constant fin thickness of 0.25 mm.

The simulations demonstrate the influence of fin number on temperature,
airflow, and pressure distribution and provide insight into the trade-off
between increased heat-transfer area and flow resistance.

---

## Reference

S. J. Yaseen,

"Numerical study of the fluid flow and heat transfer in a finned heat sink
using Ansys Icepak,"

Open Engineering, 2023.

DOI: 10.1515/eng-2022-0440
