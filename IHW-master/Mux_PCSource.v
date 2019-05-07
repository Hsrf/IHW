module Mux_PCSource(A, B, C, D, E, F, out, PCSource);
  input wire A, B, C, D, E, F, PCSource[3:0];
  output reg out;
  
    always @(PCSource)begin
      case({PCSource})
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = F;
        endcase
    end
endmodule