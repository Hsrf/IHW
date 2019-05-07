module Mux_MemToReg(A, B, C, D, E, F, G, H, I, MemToReg, out);
  input wire A, B, C, D, E, F, G, H, I, MemToReg[4:0];
  output reg out;
  
    always @(MemToReg)begin
      case({MemToReg})
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