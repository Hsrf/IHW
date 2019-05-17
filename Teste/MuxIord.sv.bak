module MuxIord(A, B, C, D, E, F, out, Iord);
  input logic B, C, D, E, F;
  input logic [31:0] A;
  input logic [2:0] Iord;
  output logic [31:0] out;
  
    always @(Iord)begin
      case(Iord)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = F;
        endcase
    end
endmodule