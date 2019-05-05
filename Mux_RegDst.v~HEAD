module Mux_RegDst(A, B, C, D, RegDst, out);
  input wire A, B, C, D, RegDst[2:0];
  output reg out;
  
    always @(RegDst)begin
      case({RegDst})
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
        endcase
    end
endmodule