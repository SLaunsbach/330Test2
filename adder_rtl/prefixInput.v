
module prefixInput(input A,
        input B,
        output wire P,
        output wire G
);



    assign P = A | B;
    assign G = A & B;


endmodule
