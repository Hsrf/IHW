module ControlUnit(
	input logic clock,
	input logic reset,
	output logic ALUSrcA,
	output logic ALUSrcB,
	output logic PCSource,
	output logic ALUOp,
	output logic PCWrite,
	input logic Overflow,
	input logic Negativo,
	input logic Zero,
	input logic Igual,
	input logic MaiorQue,
	input logic MenorQue,
	input logic MemWr,
	input logic IRWrite,
	input logic Iord,
	input logic MemToReg,
	input logic WriteRegA,
	input logic WriteRegB,
	input logic ALUOutControl,
	input logic [1:0] RegDst,
	input logic RegWrite
);

enum logic [6:0] {
	Reset = 7'd1,
	Start = 7'd2
} state, nextstate;
	
always_ff@(posedge clock, posedge reset) begin
		if(reset) state <= Reset;
		else state <= nextstate;
		//stateout = state;
end

always @* begin
	case(state)
		Start: begin
			ALUSrcA = 2'd0;
			ALUSrcB = 3'd1;
			ALUOp = 3'd1;
			PCSource = 3'd0;
			PCWrite = 1'd0;
			nextstate = Start;
		end		
	endcase
end



endmodule