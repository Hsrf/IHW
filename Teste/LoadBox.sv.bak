module LoadBox(A, out, IsControl);
  input logic [31:0] A;
  input logic [1:0] IsControl;
  output logic [31:0] out;

     always @(IsControl)begin
      case(IsControl)
            0: out = A;
            1: out = {16'd0, A[15:0]};
            2: out = {24'd0, A[7:0]};
        endcase
    end
endmodule 