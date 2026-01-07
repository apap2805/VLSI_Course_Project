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