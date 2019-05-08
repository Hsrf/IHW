module ControlUnit(
	input clock,
	input reset,
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
	input logic [6:0] state,
	input logic [6:0] nextstate
);

enum logic [6:0] {
	Reset = 7'd1,
	Start = 7'd2
}
	
always_ff @(posedge clock, posedge reset) begin
		if(reset) state <= Reset;
		else state <= nextstate;
		//stateout = state;
end

always_comb begin
	case(state)
		Start: begin
			ALUSrcA = 2'd0;
			ALUSrcB = 3'd1;
			ALUOp = 3'd1;
			PCSource = 3'd0;
			PCwrite = 1'd0;
			nextstate = Start;
		end		
	endcase
end



endmodule