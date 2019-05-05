module Mux_Iord(PC, A, B, C, D, E, out, sel1, sel2, sel3);
  input wire PC, A, B, C, D, E, sel1, sel2, sel3;
  output reg out;
  
    always @(sel1, sel2, sel3)begin
      case({sel1, sel2, sel3})
            0: out = PC;
            1: out = A;
            2: out = B;
            3: out = C;
            4: out = D;
            5: out = E;
        endcase
    end
endmodule