
module prefixBlock(input wire PA, //p i:k
        input wire PB, //p k-1:j
        input wire GA, //g i:k
        input wire GB, //g k-1:j
        output wire PF,
        output wire GF);



    assign PF = PA & PG;
    assign GF = (PA & PB) | (GA);


endmodule
