
module FA(input wire A,
        input wire B,
        input wire CI,
        output wire S,
        output wire CO);

    	xor iSUM (S, A, B, CI);
	assign CO = (A&B) | (CI&B) | (A&CI);
endmodule
