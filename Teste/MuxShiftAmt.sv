module MuxShiftAmt(A, B, out, ShiftAmt);
	
	input logic [4:0] A, B;
	input logic ShiftAmt;
	output logic [4:0] out;
  
    always @(ShiftAmt)begin
      case(ShiftAmt)
            0: out = A;
            1: out = B;
        endcase
    end
endmodule