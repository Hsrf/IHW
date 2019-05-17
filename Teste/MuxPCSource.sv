module MuxPCSource(A, B, C, D, E, F, out, PCSource);

	input logic [31:0] A, B, C, D, E;
	input logic F;
	input logic [2:0] PCSource;
	output logic [31:0] out;
  
    always @(PCSource)begin
      case(PCSource)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = F;
        endcase
    end
endmodule