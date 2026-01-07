`timescale 1ns/1ps

module please_test;
    // 1. Clock and Reset
    reg clk;
    reg reset;

    // 2. Updated Inputs (Matching the module port names)
    reg A0_in;
    reg A1_in;
    reg A2_in;
    reg A3_in;
    reg A4_in;

    reg B0_in;
    reg B1_in;
    reg B2_in;
    reg B3_in;
    reg B4_in;

    // 3. Updated Outputs (Matching the module port names)
    wire S0_out;
    wire S1_out;
    wire S2_out;
    wire S3_out;
    wire S4_out;

    wire C_out;

    // 4. Instantiation (Now names match 1:1)
    please uut(
        .clk(clk),
        .reset(reset),

        .A0_in(A0_in),
        .A1_in(A1_in),
        .A2_in(A2_in),
        .A3_in(A3_in),
        .A4_in(A4_in),

        .B0_in(B0_in),
        .B1_in(B1_in),
        .B2_in(B2_in),
        .B3_in(B3_in),
        .B4_in(B4_in),

        .S0_out(S0_out),
        .S1_out(S1_out),
        .S2_out(S2_out),
        .S3_out(S3_out),
        .S4_out(S4_out),

        .C_out(C_out)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("please.vcd");
        $dumpvars(0, please_test);

        // Updated monitor to show new variable names
        $monitor("Time = %t | A=%b%b%b%b%b B=%b%b%b%b%b | Sum=%b%b%b%b%b Cout=%b",
                 $time, A4_in, A3_in, A2_in, A1_in, A0_in, 
                 B4_in, B3_in, B2_in, B1_in, B0_in, 
                 S4_out, S3_out, S2_out, S1_out, S0_out, C_out);
        
        // Initialize
        clk = 0;
        reset = 0; // Assert Reset (Active Low logic from your design)
        A0_in=0; A1_in=0; A2_in=0; A3_in=0; A4_in=0;
        B0_in=0; B1_in=0; B2_in=0; B3_in=0; B4_in=0;
        
        #15;       
        reset = 1; // Release Reset

        // --- TEST VECTORS (Updated assignment names) ---
        // Delays are #20 because of the 2-cycle latency

        // TEST 1: 2 + 3 = 5
        A0_in=0; A1_in=1; A2_in=0; A3_in=0; A4_in=0;
        B0_in=1; B1_in=1; B2_in=0; B3_in=0; B4_in=0;
        #20; 

        // TEST 2: 12 + 7 = 19
        A0_in=0; A1_in=0; A2_in=1; A3_in=1; A4_in=0;
        B0_in=1; B1_in=1; B2_in=1; B3_in=0; B4_in=0;
        #20;

        // TEST 3: 28 + 3 = 31
        A0_in=0; A1_in=0; A2_in=1; A3_in=1; A4_in=1;
        B0_in=1; B1_in=1; B2_in=0; B3_in=0; B4_in=0;
        #20;

        // TEST 4: 31 + 1 = 0 (Overflow)
        A0_in=1; A1_in=1; A2_in=1; A3_in=1; A4_in=1;
        B0_in=1; B1_in=0; B2_in=0; B3_in=0; B4_in=0;
        #20;

        // TEST 5: 9 + 23 = 32 (0 + Carry)
        A0_in=1; A1_in=0; A2_in=0; A3_in=1; A4_in=0;
        B0_in=1; B1_in=1; B2_in=1; B3_in=0; B4_in=1;
        #20;

        // TEST 6: 15 + 15 = 30
        A0_in=1; A1_in=1; A2_in=1; A3_in=1; A4_in=0;
        B0_in=1; B1_in=1; B2_in=1; B3_in=1; B4_in=0;
        #20;

        // TEST 7: 16 + 16 = 32
        A0_in=0; A1_in=0; A2_in=0; A3_in=0; A4_in=1;
        B0_in=0; B1_in=0; B2_in=0; B3_in=0; B4_in=1;
        #20;

        // TEST 8: 10 + 27 = 37 -> 5 + Carry
        A0_in=0; A1_in=1; A2_in=0; A3_in=1; A4_in=0;
        B0_in=1; B1_in=1; B2_in=0; B3_in=1; B4_in=1;
        #20;

        // TEST 9: 21 + 14 = 35 -> 3 + Carry
        A0_in=1; A1_in=0; A2_in=1; A3_in=0; A4_in=1;
        B0_in=0; B1_in=1; B2_in=1; B3_in=1; B4_in=0;
        #20;

        // TEST 10: 5 + 11 = 16
        A0_in=1; A1_in=0; A2_in=1; A3_in=0; A4_in=0;
        B0_in=1; B1_in=1; B2_in=0; B3_in=1; B4_in=0;
        #20;

        $finish;
    end

endmodule