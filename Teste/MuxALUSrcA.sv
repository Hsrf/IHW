module MuxALUSrcA(A, B, C, D, out, SrcA);

  input logic A, B, C, D;
  input logic [1:0] SrcA;
  output logic out;
  
    always @(SrcA)begin
      case(SrcA)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
        endcase
    end
endmodule