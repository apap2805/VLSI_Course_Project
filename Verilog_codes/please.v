module d_flip_flop(clk,reset,D,Q);
    input clk,reset;
    input D;
    output reg Q;

    always @(posedge clk or negedge reset)
    begin
    if(reset==0)
        Q<=1'b0;
    else
        Q<=D;
    end
endmodule



module please(A0_in,A1_in,A2_in,A3_in,A4_in,B0_in,B1_in,B2_in,B3_in,B4_in,S0_out,S1_out,S2_out,S3_out,S4_out,C_out,reset,clk);
input A0_in,A1_in,A2_in,A3_in,A4_in,B0_in,B1_in,B2_in,B3_in,B4_in,reset,clk;
output S0_out,S1_out,S2_out,S3_out,S4_out;
output C_out;



wire A0, A1, A2, A3, A4;
wire B0, B1, B2, B3, B4;
wire S0, S1, S2, S3, S4;
wire C5;
wire P0_comp, P1_comp, P2_comp, P3_comp, P4_comp;
wire P0_1, P1_1, P2_1, P3_1, P4_1;
wire G0_comp, G1_comp, G2_comp, G3_comp, G4_comp;
wire C1, C2, C3, C4;



d_flip_flop f0(
    .clk(clk),
    .reset(reset),
    .D(A0_in),
    .Q(A0)
);

d_flip_flop f1(
    .clk(clk),
    .reset(reset),
    .D(A1_in),
    .Q(A1)
);

d_flip_flop f2(
    .clk(clk),
    .reset(reset),
    .D(A2_in),
    .Q(A2)
);

d_flip_flop f3(
    .clk(clk),
    .reset(reset),
    .D(A3_in),
    .Q(A3)
);

d_flip_flop f4(
    .clk(clk),
    .reset(reset),
    .D(A4_in),
    .Q(A4)
);

d_flip_flop f5(
    .clk(clk),
    .reset(reset),
    .D(B0_in),
    .Q(B0)
);

d_flip_flop f6(
    .clk(clk),
    .reset(reset),
    .D(B1_in),
    .Q(B1)
);

d_flip_flop f7(
    .clk(clk),
    .reset(reset),
    .D(B2_in),
    .Q(B2)
);

d_flip_flop f8(
    .clk(clk),
    .reset(reset),
    .D(B3_in),
    .Q(B3)
);

d_flip_flop f9(
    .clk(clk),
    .reset(reset),
    .D(B4_in),
    .Q(B4)
);

assign P0_comp=~(A0|B0);
assign P0_1=A0^B0;

assign P1_comp=~(A1|B1);
assign P1_1=A1^B1;

assign P2_comp=~(A2|B2);
assign P2_1=A2^B2;

assign P3_comp=~(A3|B3);
assign P3_1=A3^B3;

assign P4_comp=~(A4|B4);
assign P4_1=A4^B4;

assign G0_comp=~(A0&B0);
assign G1_comp=~(A1&B1);
assign G2_comp=~(A2&B2);
assign G3_comp=~(A3&B3);
assign G4_comp=~(A4&B4);

assign C1=~G0_comp;
assign C2=~(G1_comp&(P1_comp|G0_comp));
assign C3=~(G2_comp&(P2_comp|G1_comp))|((~(P1_comp|P2_comp))&~G0_comp);
assign C4=~(G3_comp&(P3_comp|G2_comp))|~(P3_comp|P2_comp)&~(G1_comp&(P1_comp|G0_comp));
assign C5=~(G4_comp&(P4_comp|G3_comp))|(~(P4_comp|P3_comp))&(~(G2_comp&(P2_comp|G1_comp))|(~(P1_comp|P2_comp))&~G0_comp);

assign S0=P0_1;
assign S1=P1_1^C1;
assign S2=P2_1^C2;
assign S3=P3_1^C3;
assign S4=P4_1^C4;

d_flip_flop f10(
    .clk(clk),
    .reset(reset),
    .D(S0),
    .Q(S0_out)
);

d_flip_flop f11(
    .clk(clk),
    .reset(reset),
    .D(S1),
    .Q(S1_out)
);

d_flip_flop f12(
    .clk(clk),
    .reset(reset),
    .D(S2),
    .Q(S2_out)
);

d_flip_flop f13(
    .clk(clk),
    .reset(reset),
    .D(S3),
    .Q(S3_out)
);

d_flip_flop f14(
    .clk(clk),
    .reset(reset),
    .D(S4),
    .Q(S4_out)
);

d_flip_flop f15(
    .clk(clk),
    .reset(reset),
    .D(C5),
    .Q(C_out)
);

endmodule