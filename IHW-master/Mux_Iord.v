module Mux_Iord(PC, A, B, C, D, E, out, Iord);
  input wire PC, A, B, C, D, E, Iord[3:0];
  output reg out;
  
    always @(Iord)begin
      case({Iord})
            0: out = PC;
            1: out = A;
            2: out = B;
            3: out = C;
            4: out = D;
            5: out = E;
        endcase
    end
endmodule