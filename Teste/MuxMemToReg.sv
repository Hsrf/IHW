module MuxMemToReg(A, B, C, D, E, F, G, H, out, MemToReg);

  input logic B, C, F, H;
  input logic [31:0] A, D, E, G;
  input logic [3:0] MemToReg;
  output logic [31:0] out;
  
    always @(MemToReg)begin
      case(MemToReg)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = 8'd227;
            6: out = F;
            7: out = {G[15:0], 16'd0};
            8: out = H;
        endcase
    end
endmodule