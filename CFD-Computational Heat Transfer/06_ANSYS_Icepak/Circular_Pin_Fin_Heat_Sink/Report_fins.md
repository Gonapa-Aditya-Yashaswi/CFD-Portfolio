# Thermal and Flow Analysis of a Circular Pin-Fin Heat Sink using ANSYS Icepak

## Objective

To investigate the fluid flow and heat transfer characteristics of a
microelectronic heat sink with circular pin fins using ANSYS Icepak.

The simulation reproduces the inline arrangement (IA) of circular pin
fins reported in the reference study.

---

## Simulation Details

- Software: ANSYS Icepak
- Solver: Fluent
- Flow: Laminar
- Working fluid: Air
- Fin geometry: Circular pin fins
- Fin arrangement: Inline Arrangement (IA)
- Number of fins: 36
- Heat source power: 8 W
- Simulation: Steady-state

---

## Geometry

![Geometry](./Figures/geometry.png)

---

## Temperature Distribution

![Temperature](./Figures/fin+base.png)

---

## Velocity Distribution

![Velocity](./Figures/fin+base_VEL.png)

---

## Pressure Distribution

![Pressure](./Figures/fin+base-PRESS.png)

---

## Validation

The present ANSYS Icepak results are compared with the reference paper
to assess the accuracy of the numerical model.

| Metric | Present Study | Reference Paper | Error |
|---|---:|---:|---:|
| Fin + base temperature | 132–134 °C | 126.97 °C | +4.0 to +5.5% |
| Pressure drop | 0.11–0.125 Pa | 0.12 Pa | −8.0 to +4.0% |

## Key Observations

- Circular pin fins increase the available heat-transfer surface area.
- The airflow is disturbed as it passes through the pin-fin array.
- Pressure decreases along the flow direction due to flow resistance.
- Heat is transferred from the source through the heat sink to the surrounding airflow.

---

## Reference

S. J. Yaseen et al.,  
"A computational search for the optimal microelectronic heat sink using ANSYS Icepak,"  
International Journal of Thermofluids, 2024.
