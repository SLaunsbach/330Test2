
module cla #(parameter Width = 64) (input [Width-1:0] A,
        input [Width-1:0] B,
        input wire CI,
        output wire [Width-1:0] S,
        output wire CO);

    	wire [Width-1:0] Carries;	
	//FA iFAs[Width-1:0](.A(A), .B(B), .CI({Carries[Width-2:0], CI}), .S(S), .Cout(Carries));

	//buf iBUF0(Cout,Carries[Width-1]);

        genvar i;

	
	for (i = 1; i <= (Width / 4); i = i + 1) begin
            //j = ((i*4)-1)
            //k = ((i*4)-4)
           
            claBlock iCLAB(.A(A[((i*4)-1):((i*4)-4)]), .B(B[((i*4)-1):((i*4)-4)]), .CI(Carries[i-1]), .S(S[((i*4)-1):((i*4)-4)]));
            claLookAhead iCLALA(.A(A[((i*4)-1):((i*4)-4)]), .B(B[((i*4)-1):((i*4)-4)]), .CI(Carries[i-1]), .CO(Carries[i]));
            
	end
        assign CO = Carries[Width/4];

endmodule