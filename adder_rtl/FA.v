
module FA(input wire A,
        input wire B,
        input wire CI,
        output wire S,
        output wire CO);

    	xor iSUM (S, A, B, CI);
	majority iCO(.V1(A), .V2(B), .V3(CI), .major(CO));
endmodule
