module Mux_SrcA(A, B, C, D, out, SrcA, out);
  input wire A, B, C, D, SrcA[2:0];
  output reg out;
  
    always @(SrcA)begin
      case({SrcA})
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
        endcase
    end
endmodule