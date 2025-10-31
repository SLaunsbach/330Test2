
module prefixOutput(input wire A,
        input wire B,
        input wire G,
        output wire S
);



    assign S = (A ^ B) ^ G;


endmodule
