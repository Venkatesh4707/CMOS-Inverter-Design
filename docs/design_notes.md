# CMOS Design Notes — Transistor-Level Analysis

**Author:** P. Venkatesh Sagar
**Date:** June 2026

---

## 1. CMOS Inverter — Transistor-Level Schematic

```
            VDD
             |
             |
        ┌────┴────┐
        │  PMOS   │
        │ (M_P)   │
        │  W/L =  │
        │  2/1    │
        └────┬────┘
             │
    IN ──────┼────── OUT
             │
        ┌────┴────┐
        │  NMOS   │
        │ (M_N)   │
        │  W/L =  │
        │  1/1    │
        └────┬────┘
             │
            GND
```

---

## 2. Operation Principle

| IN | PMOS State | NMOS State | OUT |
|----|-----------|-----------|-----|
| 0  | ON (conducts) | OFF | 1 (VDD) |
| 1  | OFF | ON (conducts) | 0 (GND) |

- When **IN = 0**: V_GS of PMOS = -VDD (strongly ON), pulls OUT to VDD
- When **IN = 1**: V_GS of NMOS = VDD (strongly ON), pulls OUT to GND
- **No direct path** between VDD and GND in steady state → near-zero static power

---

## 3. Transistor Sizing (W/L Ratios)

For a **balanced inverter** (equal rise and fall times):

```
(W/L)_PMOS = 2 to 3 x (W/L)_NMOS
```

This compensates for the lower mobility of holes vs electrons (μp ≈ 0.4 x μn).

**Example sizing used in this design:**
- NMOS: W/L = 1µm / 0.18µm  (minimum size)
- PMOS: W/L = 2.5µm / 0.18µm (2.5x wider for symmetric switching)

---

## 4. Switching Characteristics

### Voltage Transfer Characteristic (VTC)
```
Vout
 │
VDD├──────╮
 │         ╲
 │          ╲   <- Sharp transition region
 │           ╲     (high gain near VDD/2)
 │            ╲
 0└─────────────╲────────── Vin
 0      VDD/2    VDD
```

- **VIL** (Input Low threshold): max input recognized as logic 0
- **VIH** (Input High threshold): min input recognized as logic 1
- **VOL / VOH**: output low/high levels (ideally 0 and VDD for CMOS)
- **Noise Margin** = VIH - VIL (wider = better noise immunity)

---

## 5. Propagation Delay

```
t_pHL = time for output to fall from VDD to VDD/2 (NMOS discharging C_load)
t_pLH = time for output to rise from 0 to VDD/2   (PMOS charging C_load)

t_p = (t_pHL + t_pLH) / 2
```

Approximation:
```
t_p ≈ 0.69 x R_eq x C_load
```
Where R_eq is the equivalent ON resistance of the switching transistor.

---

## 6. Drive Strength

**Drive strength** is the ability of a gate to charge/discharge its output load capacitance quickly.

- Higher W/L → lower ON resistance → higher drive strength → faster switching
- Trade-off: larger transistors = more area + more input capacitance (loads previous stage)

---

## 7. Design Rules Applied

- Minimum channel length (L) used for NMOS to minimize area
- PMOS width increased relative to NMOS for symmetric VTC
- Layout follows standard cell conventions: PMOS near VDD rail, NMOS near GND rail, shared poly gate

---

## 8. NAND2 and NOR2 — Series/Parallel Networks

### CMOS NAND2
- **PMOS network**: 2 transistors in PARALLEL (pull-up)
- **NMOS network**: 2 transistors in SERIES (pull-down)
- Output is LOW only when BOTH inputs are HIGH (both NMOS ON, both PMOS OFF)

### CMOS NOR2
- **PMOS network**: 2 transistors in SERIES (pull-up)
- **NMOS network**: 2 transistors in PARALLEL (pull-down)
- Output is HIGH only when BOTH inputs are LOW

**Sizing rule:** Series transistors must be sized larger (wider) to compensate for the increased resistance of series-connected devices — typically 2x for a 2-input gate.

---

## 9. Relevance to Mixed-Signal Design

These CMOS fundamentals directly underpin:
- **Analog switches** used in SerDes sampling circuits
- **Level shifters** between digital and analog domains
- **Output drivers** for PHY IP (drive strength sizing)
- **Bias generation circuits** (current mirrors built from matched transistor pairs)
