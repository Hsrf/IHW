module MuxLOControl(A, B, out, LOControl);
	
	input logic [31:0] A, B;
	input logic LOControl;
	output logic [31:0] out;
  
    always @(LOControl)begin
      case(LOControl)
            0: out = A;
            1: out = B;
        endcase
    end
endmodule