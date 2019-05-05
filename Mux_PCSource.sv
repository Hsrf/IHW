module Mux_PCSource(A, B, C, D, E, F, out, sel1, sel2, sel3);
  input wire A, B, C, D, E, F, sel1, sel2, sel3;
  output reg out;
  
    always @(sel1, sel2, sel3)begin
      case({sel1, sel2, sel3})
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = F;
        endcase
    end
endmodule