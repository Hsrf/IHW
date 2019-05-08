module MuxDST(A, B, C, D, out, DSTOut);
 input logic A, B, C, D;
 input logic [1:0] DSTOut;
  output logic out;
  
    always @(DSTOut)begin
      case(DSTOut)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
        endcase
    end
endmodule