module MuxRegDst(A, B, C, D, out, RegDst);
 input logic B, C;
 input logic [3:0] A;
 input logic [4:0] D;
 input logic [1:0] RegDst;
  output logic [31:0] out;
  
    always @(RegDst)begin
      case(RegDst)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
        endcase
    end
endmodule