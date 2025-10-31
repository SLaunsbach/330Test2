
module prefix #(parameter Width = 8) (input [Width-1:0] A,
        input [Width-1:0] B,
        input wire CI,
        output wire [Width-1:0] S,
        output wire CO);

    	wire [Width-1:0] CarriesP; //Used to carry Propagation data from one row of black squares to the next
    	wire [Width-1:0] CarriesG; //Used to carry Generation data from one row of black squares to the next
    	wire [Width-1:0] FinalsP; //Final propagation data for each column
    	wire [Width-1:0] FinalsG; //Final Generation data for each column
	
	//assign propagation/generation carries to logic from first row of white blocks
        prefixInput iPFs[Width-1:0](.A({A[Width-2:0], 0}), .B({B[Width-2:0], 0}), .P({CarriesP[Width-2:0],1}), .G({CarriesG[Width-2:0], 0}));


        //Vector of black blocks for every other column

        genvar i;

        for (i = 1; i < Width; i = i + 2) begin
            
            prefixBlock iPFB(.PA(CarriesP[i]), .PB(CarriesP[i-1]), .GA(CarriesG[i]),  .GB(CarriesG[i-1]), .PF(CarriesP[i]), .GF(CarriesG[i]));

        end

        //Groups of 2

        for (i = 3; i < Width; i = i + 4) begin
            
            prefixBlock iPFBy(.PA(CarriesP[i-1]), .PB(CarriesP[i-2]), .GA(CarriesG[i-1]),  .GB(CarriesG[i-2]), .PF(CarriesP[i-1]), .GF(CarriesG[i-1]));
            prefixBlock iPFBz(.PA(CarriesP[i]), .PB(CarriesP[i-2]), .GA(CarriesG[i]),  .GB(CarriesG[i-2]), .PF(CarriesP[i]), .GF(CarriesG[i]));

        end

        //Groups of 4

        for (i = 7; i < Width; i = i + 8) begin
            
            prefixBlock iPFBa(.PA(CarriesP[i-3]), .PB(CarriesP[i-4]), .GA(CarriesG[i-3]),  .GB(CarriesG[i-4]), .PF(CarriesP[i-3]), .GF(CarriesG[i-3]));
            prefixBlock iPFBb(.PA(CarriesP[i-2]), .PB(CarriesP[i-4]), .GA(CarriesG[i-2]),  .GB(CarriesG[i-4]), .PF(CarriesP[i-2]), .GF(CarriesG[i-2]));
            prefixBlock iPFBc(.PA(CarriesP[i-1]), .PB(CarriesP[i-4]), .GA(CarriesG[i-1]),  .GB(CarriesG[i-4]), .PF(CarriesP[i-1]), .GF(CarriesG[i-1]));
            prefixBlock iPFBd(.PA(CarriesP[i]), .PB(CarriesP[i-4]), .GA(CarriesG[i]),  .GB(CarriesG[i-4]), .PF(CarriesP[i]), .GF(CarriesG[i]));

        end

        //If 16 Plus:
        //Groups of 8
        if (Width > 15) begin
            for (i = 15; i < Width; i = i + 16) begin

                prefixBlock iPFBe(.PA(CarriesP[i-7]), .PB(CarriesP[i-8]), .GA(CarriesG[i-7]),  .GB(CarriesG[i-8]), .PF(CarriesP[i-7]), .GF(CarriesG[i-7]));
                prefixBlock iPFBf(.PA(CarriesP[i-6]), .PB(CarriesP[i-8]), .GA(CarriesG[i-6]),  .GB(CarriesG[i-8]), .PF(CarriesP[i-6]), .GF(CarriesG[i-6]));
                prefixBlock iPFBg(.PA(CarriesP[i-5]), .PB(CarriesP[i-8]), .GA(CarriesG[i-5]),  .GB(CarriesG[i-8]), .PF(CarriesP[i-5]), .GF(CarriesG[i-5]));
                prefixBlock iPFBh(.PA(CarriesP[i-4]), .PB(CarriesP[i-8]), .GA(CarriesG[i-4]),  .GB(CarriesG[i-8]), .PF(CarriesP[i-4]), .GF(CarriesG[i-4]));
               
                prefixBlock iPFBi(.PA(CarriesP[i-3]), .PB(CarriesP[i-8]), .GA(CarriesG[i-3]),  .GB(CarriesG[i-8]), .PF(CarriesP[i-3]), .GF(CarriesG[i-3]));
                prefixBlock iPFBj(.PA(CarriesP[i-2]), .PB(CarriesP[i-8]), .GA(CarriesG[i-2]),  .GB(CarriesG[i-8]), .PF(CarriesP[i-2]), .GF(CarriesG[i-2]));
                prefixBlock iPFBk(.PA(CarriesP[i-1]), .PB(CarriesP[i-8]), .GA(CarriesG[i-1]),  .GB(CarriesG[i-8]), .PF(CarriesP[i-1]), .GF(CarriesG[i-1]));
                prefixBlock iPFBl(.PA(CarriesP[i]), .PB(CarriesP[i-8]), .GA(CarriesG[i]),  .GB(CarriesG[i-8]), .PF(CarriesP[i]), .GF(CarriesG[i]));

            end
        end

        //If 32:
        //Group of 16
       genvar k;
       if (Width > 31) begin
            for (i = 15; i < Width; i = i + 16) begin

                for (k = 15; k >= 0; k= k - 1) begin
                    prefixBlock iPFBm(.PA(CarriesP[i-k]), .PB(CarriesP[i-16]), .GA(CarriesG[i-k]),  .GB(CarriesG[i-16]), .PF(CarriesP[i-k]), .GF(CarriesG[i-k]));
                end

            end
        end
        

        genvar j;

        if (Width == 64) begin
           

                for (j = 31; j >= 0; j = j - 1) begin
                    prefixBlock iPFBn(.PA(CarriesP[63-j]), .PB(CarriesP[63-32]), .GA(CarriesG[63-j]),  .GB(CarriesG[63-32]), .PF(CarriesP[63-j]), .GF(CarriesG[63-j]));
                end

            
        end

        //Now we can just plug the final carry/propagate values into the sum logic

        prefixOutput  iPFO[Width-1:0](.A(A), .B(B), .G(CarriesG), .S(S));
        assign CO = (A[Width-1] & B[Width-1]) | (CarriesG[Width-1] & (A[Width-1] | B[Width-1]));

endmodule
