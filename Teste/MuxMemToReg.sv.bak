module MuxMemToReg(A, B, C, D, E, F, G, H, out, MemToReg);

  input logic A, B, C, D, E, F, G, H;
  input logic [3:0] MemToReg;
  output logic out;
  
    always @(MemToReg)begin
      case(MemToReg)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = 8d'227;
            6: out = F;
            7: out = G;
            8: out = H;
        endcase
    end
endmodule