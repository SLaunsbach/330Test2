
module claLookAhead(input wire [3:0] A,
        input wire [3:0] B,
        input wire CI,
        output wire CO);

    //CLA LOGIC
    //Uses propagate and generate signals to find what the carry out will be
    
    //Create propagate and generate signals from inputs
    wire GZero;
    wire GOne;
    wire GTwo;
    wire GThree;
    wire GTotal; //store G[3:0]

    wire PZero;
    wire POne;
    wire PTwo;
    wire PThree;
    wire PTotal; //store P[3:0]

    assign GZero = A[0] & B[0];
    assign GOne = A[1] & B[1];
    assign GTwo = A[2] & B[2];
    assign GThree = A[3] & B[3];

    assign PZero = A[0] & B[0];
    assign POne = A[1] & B[1];
    assign PTwo = A[2] & B[2];
    assign PThree = A[3] & B[3];

    //Logic for Propagate and Generate signals
    
    assign GTotal = GThree | PThree & (GTwo | PTwo & (GOne | POne & GZero));
    
    assign PTotal = PThree & PTwo & POne & PZero;

    //And finally, use CI, Propagate, and Generate to find the carry out

    assign CO = GTotal | (PTotal & CI);
	
endmodule
