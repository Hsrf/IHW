module Mux_MemToReg(A, B, C, D, E, F, G, H, I, sel1, sel2, sel3, sel4, out);
  input wire A, B, C, D, E, F, G, H, I, sel1, sel2, sel3, sel4;
  output reg out;
  
    always @(sel1, sel2)begin
      case({sel1, sel2})
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = F;
            6: out = G;
            7: out = H;
            8: out = I;
        endcase
    end
endmodule