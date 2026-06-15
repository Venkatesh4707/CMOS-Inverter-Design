// ============================================================
// Module      : cmos_inverter_behavioral
// Description : Behavioral model of a CMOS Inverter
// Author      : P. Venkatesh Sagar
// Date        : June 2026
// ============================================================
// A CMOS inverter consists of:
//   - PMOS transistor (pull-up network)   connected to VDD
//   - NMOS transistor (pull-down network) connected to GND
// Truth Table:
//   IN = 0 -> PMOS ON, NMOS OFF -> OUT = 1 (VDD)
//   IN = 1 -> PMOS OFF, NMOS ON -> OUT = 0 (GND)
// This module models the LOGICAL behaviour for simulation.
// Transistor-level (SPICE) sizing is documented in docs/
// ============================================================

module cmos_inverter_behavioral (
    input  wire in,
    output wire out
);

    // Behavioral model — logical inversion
    assign out = ~in;

endmodule


// ============================================================
// Module      : cmos_nand2_behavioral
// Description : 2-input CMOS NAND gate (behavioral)
// ============================================================
// PMOS: parallel pull-up network
// NMOS: series pull-down network
// ============================================================

module cmos_nand2_behavioral (
    input  wire a,
    input  wire b,
    output wire y
);

    assign y = ~(a & b);

endmodule


// ============================================================
// Module      : cmos_nor2_behavioral
// Description : 2-input CMOS NOR gate (behavioral)
// ============================================================
// PMOS: series pull-up network
// NMOS: parallel pull-down network
// ============================================================

module cmos_nor2_behavioral (
    input  wire a,
    input  wire b,
    output wire y
);

    assign y = ~(a | b);

endmodule
