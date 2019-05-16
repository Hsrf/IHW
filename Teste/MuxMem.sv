module MuxMem(A, B, out, Mem);

	input logic [31:0] A, B;
	input logic Mem;
	output logic [31:0] out;
  
    always @(Mem)begin
      case(Mem)
            0: out = A;
            1: out = B;
        endcase
    end
endmodule