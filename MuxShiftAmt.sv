module MuxShiftAmt(A, B, out, ShiftAmt);
	
	input logic [31:0] A;
	input logic [5:0] B;
	input logic ShiftAmt;
	output logic [31:0] out;
  
    always @(ShiftAmt)begin
      case(ShiftAmt)
            0: out = A;
            1: out = B;
        endcase
    end
endmodule