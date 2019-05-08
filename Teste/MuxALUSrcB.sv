module MuxALUSrcB(A, B, C, D, E, F, out, SrcB);
 
  input logic A, B, C, D, E, F;
  input logic [2:0] SrcB;
  output logic out;
  
    always @(SrcB)begin
      case(SrcB)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = F;
        endcase
    end
endmodule