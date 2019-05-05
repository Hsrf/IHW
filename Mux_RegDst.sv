module Mux_RegDst(A, B, C, D sel1, sel2, out);
  input wire A, B, C, D, sel1, sel2;
  output reg out;
  
    always @(sel1, sel2)begin
      case({sel1, sel2})
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
        endcase
    end
endmodule