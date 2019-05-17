module StoreBox(A, B, out, SControl);
  input logic [31:0] A, B;
  input logic [1:0] SControl;
  output logic [31:0] out;
  
    always @(SControl)begin
      case(SControl)
            0: out = B;
            1: out = {A[31:16],B[15:0]};
            2: out = {A[31:8], B[7:0]};
        endcase
    end
endmodule