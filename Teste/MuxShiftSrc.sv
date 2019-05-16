module MuxShiftSrc(A, B, out, ShiftSrc);

	input logic [31:0] A, B;
	input logic ShiftSrc;
	output logic [31:0] out;
  
    always @(ShiftSrc)begin
      case(ShiftSrc)
            0: out = A;
            1: out = B;
        endcase
    end
endmodule