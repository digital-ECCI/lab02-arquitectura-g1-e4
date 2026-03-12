module sumador_1bt (
    input A,
    input B,
    input cin,
    output s,
    output cout
);
    assign s = A ^ B ^ cin;
    assign cout = (A & B) | (cin & (A ^ B));
endmodule


module sumador_4bt (
    input [3:0] A,
    input [3:0] B,
    input Sel,
    output [3:0] So,
    output Co
);
    wire [3:0] B_xor_Sel;
    wire c0, c1, c2;

   
    assign B_xor_Sel = B ^ {4{Sel}};


    sumador_1bt fa0 (A[0], B_xor_Sel[0], Sel, So[0], c0);
    sumador_1bt fa1 (A[1], B_xor_Sel[1], c0,  So[1], c1);
    sumador_1bt fa2 (A[2], B_xor_Sel[2], c1,  So[2], c2);
    sumador_1bt fa3 (A[3], B_xor_Sel[3], c2,  So[3], Co);

endmodule

module tb;
    reg [3:0] A, B;
    reg Sel;
    wire [3:0] So;
    wire Co;
   
   
    reg [4:0] i, j, k;

    sumador_4bt uut (A, B, Sel, So, Co);

    initial begin
        $dumpfile("resultado.vcd");
        $dumpvars(0, tb);

        for (k = 0; k < 2; k = k + 1) begin
            Sel = k[0];
            for (i = 0; i < 16; i = i + 1) begin
                A = i[3:0];
                for (j = 0; j < 16; j = j + 1) begin
                    B = j[3:0];
                    #5;
                end
            end
        end
        $finish;
    end
endmodule