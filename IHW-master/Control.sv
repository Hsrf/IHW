module Control(
	input logic clk,
	input logic reset,
	input logic opCode
);
	
output logic pcWriteCond [1:0];
output logic pcWrite [1:0];
output logic iord [3:0];
output logic memRead [1:0];
output logic memWrite [1:0];
output logic irWrite [1:0];
output logic regDst [2:0];
output logic regWrite [1:0];
output logic writeRegA [1:0];
output logic writeRegB [1:0];
output logic aluSrcA [2:0];
output logic aluSrcB [3:0];
output logic aluOutControl [1:0];
output logic epcWrite [1:0];
output logic pcSource [3:0];
output logic memToReg [4:0];
output logic aluOp [3:0];
output logic sControl [2:0];
output logic memMux [1:0];
output logic lsControl [2:0];
output logic multControl [1:0];
output logic divControl [1:0];
output logic muxHiControl [1:0];
output logic muxLoControl [1:0];
output logic writeHI [1:0];
output logic writeLO [1:0];
output logic shiftSrc [1:0];
output logic shiftAmt [1:0];
output logic shiftControl [3:0];
output logic divZero [1:0];
output logic overflow [1:0];
	
enum logic [6:0] {
	Reseta,
	Start
}
	
logic [6:0] state;
logic [6:0] nextstate;
	
always_ff@(posedge clk, posedge reset) begin
    if(reset) state <= reseta;
    else state <= nextstate;
    //stateout = state;
end

always_comb begin
	case(state)
		Reseta: pcWriteCond = 1'b0;
		
				
	endcase
	
endmodule;
