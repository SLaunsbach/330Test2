
module prefixInput(input wire A,
        input wire B,
        output wire P,
        output wire G,
);



    assign P = A | B;
    assign G = A & B;


endmodule
