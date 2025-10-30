
module claBlock(input wire [3:0] A,
        input wire [3:0] B,
        input wire CI,
        output wire [3:0] S);



    //SUM LOGIC
    //Uses the claRCA (which acts as a 4 bit RCA with no carry out) to find the sum
    claRca iRCA(.A(A), .B(B), .CI(CI), .S(S));


endmodule
