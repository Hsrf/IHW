module MuxWriteMem(A, B, out, MuxWriteMemControl);
 
  input logic [31:0] A, B;
  input logic MuxWriteMemControl;
  output logic [31:0] out;
  
    always @(MuxWriteMemControl)begin
      case(MuxWriteMemControl)
            0: out = A;
            1: out = B;
        endcase
    end
endmodule