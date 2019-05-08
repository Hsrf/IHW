module Mux_Iord(PC, A, B, C, D, E, out, Iord);
  input logic PCOut, A, B, C, D, E;
  input logic [2:0] Iord;
  output logic out;
  
    always @(Iord)begin
      case(Iord)
            0: out = PC;
            1: out = A;
            2: out = B;
            3: out = C;
            4: out = D;
            5: out = E;
        endcase
    end
endmodule