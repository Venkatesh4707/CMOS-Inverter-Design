// ============================================================
// Module      : cmos_tb
// Description : Self-checking testbench for CMOS gates
// Author      : P. Venkatesh Sagar
// Date        : June 2026
// ============================================================

`timescale 1ns/1ps

module cmos_tb;

    reg  in_a, in_b;
    wire out_inv, out_nand, out_nor;

    integer pass_count = 0;
    integer fail_count = 0;

    cmos_inverter_behavioral dut_inv  (.in(in_a), .out(out_inv));
    cmos_nand2_behavioral    dut_nand (.a(in_a), .b(in_b), .y(out_nand));
    cmos_nor2_behavioral     dut_nor  (.a(in_a), .b(in_b), .y(out_nor));

    task check_inv;
        input data;
        input exp;
        begin
            in_a = data;
            #5;
            if (out_inv === exp) begin
                $display("PASS | INVERTER | IN=%b -> OUT=%b (expected %b)", in_a, out_inv, exp);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL | INVERTER | IN=%b -> OUT=%b (expected %b)", in_a, out_inv, exp);
                fail_count = fail_count + 1;
            end
        end
    endtask

    task check_nand;
        input a, b, exp;
        begin
            in_a = a; in_b = b;
            #5;
            if (out_nand === exp) begin
                $display("PASS | NAND2    | A=%b B=%b -> Y=%b (expected %b)", a, b, out_nand, exp);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL | NAND2    | A=%b B=%b -> Y=%b (expected %b)", a, b, out_nand, exp);
                fail_count = fail_count + 1;
            end
        end
    endtask

    task check_nor;
        input a, b, exp;
        begin
            in_a = a; in_b = b;
            #5;
            if (out_nor === exp) begin
                $display("PASS | NOR2     | A=%b B=%b -> Y=%b (expected %b)", a, b, out_nor, exp);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL | NOR2     | A=%b B=%b -> Y=%b (expected %b)", a, b, out_nor, exp);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        $display("==============================================");
        $display("  CMOS Gates Testbench");
        $display("  Author: P. Venkatesh Sagar");
        $display("==============================================");

        $display("\n--- CMOS Inverter Truth Table ---");
        check_inv(1'b0, 1'b1); // IN=0 -> OUT=1
        check_inv(1'b1, 1'b0); // IN=1 -> OUT=0

        $display("\n--- CMOS NAND2 Truth Table ---");
        check_nand(1'b0, 1'b0, 1'b1);
        check_nand(1'b0, 1'b1, 1'b1);
        check_nand(1'b1, 1'b0, 1'b1);
        check_nand(1'b1, 1'b1, 1'b0);

        $display("\n--- CMOS NOR2 Truth Table ---");
        check_nor(1'b0, 1'b0, 1'b1);
        check_nor(1'b0, 1'b1, 1'b0);
        check_nor(1'b1, 1'b0, 1'b0);
        check_nor(1'b1, 1'b1, 1'b0);

        $display("\n==============================================");
        $display("  RESULTS: %0d PASSED | %0d FAILED", pass_count, fail_count);
        if (fail_count == 0)
            $display("  ALL TESTS PASSED - CMOS GATES VERIFIED");
        $display("==============================================");
        $finish;
    end

    initial begin
        $dumpfile("cmos_sim.vcd");
        $dumpvars(0, cmos_tb);
    end

endmodule
