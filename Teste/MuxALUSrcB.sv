module MuxALUSrcB(A, B, C, D, E, F, G, out, SrcB);
 
  input logic E;
  input logic [31:0] A, D, F, G;
  input logic [15:0] C;
  input logic [2:0] B;
  input logic [2:0] SrcB;
  output logic [31:0] out;
  
    always @(SrcB)begin
      case(SrcB)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = F;
            6: out = G;
        endcase
    end
endmodule