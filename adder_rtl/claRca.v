
module claRca #(parameter Width = 4) (input [Width-1:0] A,
        input [Width-1:0] B,
        input wire CI,
        output wire [Width-1:0] S);

    	wire [Width-1:0] Carries;	
	FA iFAs[Width-1:0](.A(A), .B(B), .CI({Carries[Width-2:0], CI}), .S(S), .Cout(Carries));

	//buf iBUF0(Cout,Carries[Width-1]); Carry out Not needed for RCA part of CLA

endmodule
