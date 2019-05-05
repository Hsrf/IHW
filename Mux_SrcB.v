module Mux_SrcB(A, B, C, D, out, SrcB, out);
  input wire A, B, C, D, E, F, SrcB[3:0];
  output reg out;
  
    always @(SrcB)begin
      case({SrcB})
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = F;
        endcase
    end
endmodule