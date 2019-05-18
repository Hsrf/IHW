module MuxALUSrcA(A, B, C, D, E, out, SrcA);

	input logic [31:0] A, B, C, D, E;
  input logic [2:0] SrcA;
  output logic [31:0] out;
  
    always @(SrcA)begin
      case(SrcA)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
        endcase
    end
endmodule