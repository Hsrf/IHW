module MuxHIControl(A, B, out, HIControl);

	input logic [31:0] A, B;
	input logic HIControl;
	output logic [31:0] out;
  
    always @(HIControl)begin
      case(HIControl)
            0: out = A;
            1: out = B;
        endcase
    end
endmodule