module MuxPCSource(A, B, C, D, E, F, out, PCSource);
 input logic A, B, C, D, E, F, PCSource[2:0];
  output logic out;
  
    always @(PCSource)begin
      case(PCSource)
            0: out = A;
            1: out = B;
            2: out = C;
            3: out = D;
            4: out = E;
            5: out = F;
        endcase
    end
endmodule