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
	output logic MemWr,
	output logic IRWrite,
	output logic Iord,
	output logic MemToReg,
	output logic WriteRegA,
	output logic WriteRegB,
	output logic ALUOutControl,
	output logic RegDst,
	output logic RegWrite
);

enum logic [6:0] {
	Reset = 7'd1,
	Start = 7'd2,
	Wait1 = 7'd3,
	Wait2 = 7'd4,
	ADD1 = 7'd5,
	ADD2 = 7'd6,
	ADD3 = 7'd7,
	ADD4 = 7'd8,
	Wait3 = 7'd9
} state, nextstate;
	
always_ff@(posedge clock, posedge reset) begin
		if(reset) state <= Reset;
		else state <= nextstate;
		//stateout = state;
end

always @* begin
	case(state)
		Reset: begin
				ALUSrcA = 2'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd5;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd1;
				RegWrite = 1'd1;
				nextstate = Start;
		end
		Start: begin
				ALUSrcA = 2'd0 ;
				ALUSrcB = 3'd1;
				PCSource = 3'd0;
				ALUOp = 3'd1;
				PCWrite = 1'd1;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				nextstate = Wait1;
		end	
		Wait1: begin
				ALUSrcA = 2'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd1;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				nextstate = Wait2;
		end
		Wait2: begin
				ALUSrcA = 2'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd1;
				nextstate = ADD1;
		end
		ADD1: begin
				ALUSrcA = 2'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd1;
				WriteRegB = 1'd1;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				nextstate = ADD2;
		end
		ADD2: begin
				ALUSrcA = 2'd2 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd1;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				nextstate = ADD3;
		end
		ADD3: begin
				ALUSrcA = 2'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd1;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				nextstate = ADD4;
		end
		ADD4: begin
				ALUSrcA = 2'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd3;
				RegWrite = 1'd1;
				nextstate = Wait3;
		end
		Wait3: begin
				ALUSrcA = 2'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				nextstate = Start;
		end
	endcase
end

/*
ALUSrcA = 2'd0 ;
ALUSrcB = 3'd0;
PCSource = 3'd0;
ALUOp = 3'd0;
PCWrite = 1'd0;
Overflow = 1'd0;
Negativo = 1'd0;
Zero = 1'd0;
Igual = 1'd0;
MaiorQue = 1'd0;
MenorQue = 1'd0;
MemWr = 1'd0;
IRWrite = 1'd0;
Iord = 3'd0;
MemToReg = 4'd0;
WriteRegA = 1'd0;
WriteRegB = 1'd0;
ALUOutControl = 1'd0;
RegDst = 2'd0;
RegWrite = 1'd0;
nextstate = ;
*/


endmodule