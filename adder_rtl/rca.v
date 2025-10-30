
module rca #(parameter Width = 8) (input [Width-1:0] A,
        input [Width-1:0] B,
        input wire CI,
        output wire [Width-1:0] S,
        output wire CO);

    	wire [Width-1:0] Carries;	
	FA iFAs[Width-1:0](.A(A), .B(B), .CI({Carries[Width-2:0], CI}), .S(S), .Cout(Carries));

	buf iBUF0(Cout,Carries[Width-1]);

endmodule
