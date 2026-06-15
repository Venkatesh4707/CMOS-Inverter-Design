# CMOS Design & Layout — Inverter, NAND, NOR

**Author:** P. Venkatesh Sagar  
**Date:** June 2026  
**Tools:** Verilog HDL (behavioral) · Transistor-level design analysis

---

## Overview

This project covers **CMOS digital logic gate design** from transistor-level fundamentals: inverter, 2-input NAND, and 2-input NOR. Includes behavioral Verilog models for functional verification plus detailed transistor-level design notes covering sizing, switching characteristics, propagation delay, and drive strength — foundational knowledge for mixed-signal and analog IC design.

---

## Project Structure

```
CMOS-Inverter-Design/
├── rtl/
│   └── cmos_gates.v       # Behavioral models: inverter, NAND2, NOR2
├── tb/
│   └── cmos_tb.v          # Self-checking testbench (truth tables)
├── docs/
│   └── design_notes.md    # Transistor-level analysis & sizing
├── sim/
│   └── (waveform screenshots)
└── README.md
```

---

## Gates Implemented

| Gate | PMOS Network | NMOS Network | Function |
|------|--------------|---------------|----------|
| Inverter | Single PMOS | Single NMOS | Y = NOT(A) |
| NAND2 | Parallel | Series | Y = NOT(A AND B) |
| NOR2 | Series | Parallel | Y = NOT(A OR B) |

---

## Key Topics Covered (see `docs/design_notes.md`)

- Transistor-level schematic and operation principle
- W/L sizing ratios for balanced switching (PMOS ≈ 2.5x NMOS)
- Voltage Transfer Characteristic (VTC) and noise margins
- Propagation delay analysis (t_pHL, t_pLH)
- Drive strength and load capacitance trade-offs
- Series/parallel transistor networks for NAND/NOR
- Relevance to mixed-signal design (switches, level shifters, drivers)

---

## How to Simulate (ModelSim)

```tcl
vlog rtl/cmos_gates.v tb/cmos_tb.v
vsim cmos_tb
run -all
```

---

## Testbench Results

| Gate | Truth Table Entries | Result |
|------|---------------------|--------|
| Inverter | 2/2 | PASS |
| NAND2 | 4/4 | PASS |
| NOR2 | 4/4 | PASS |

---

## Skills Demonstrated

- CMOS transistor-level design principles (PMOS/NMOS networks)
- Transistor sizing for balanced switching characteristics
- Switching characteristic analysis (propagation delay, drive strength)
- Behavioral RTL modeling and functional verification
- Foundational mixed-signal design knowledge (switches, drivers, level shifters)
