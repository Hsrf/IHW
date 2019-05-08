module MuxRegDst(A, B, C, D, out, RegDst);
 input logic A, B, C, D;
 input logic [1:0] RegDst;
  output logic out;
  
    always @(RegDst)begin
      case(RegDst)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
        endcase
    end
endmodule