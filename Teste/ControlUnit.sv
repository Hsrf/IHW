module ControlUnit(
	input logic clock,
	input logic reset,
	input logic [5:0] OpCode,
	input logic [5:0] Funct,
	output logic [1:0] ALUSrcA,
	output logic [2:0] ALUSrcB,
	output logic [2:0] PCSource,
	output logic [2:0] ALUOp,
	output logic PCWrite,
	input logic Overflow,
	input logic Negativo,
	input logic Zero,
	input logic Igual,
	input logic MaiorQue,
	input logic MenorQue,
	output logic MemWr,
	output logic IRWrite,
	output logic [2:0] Iord,
	output logic [3:0] MemToReg,
	output logic WriteRegA,
	output logic WriteRegB,
	output logic ALUOutControl,
	output logic [1:0] RegDst,
	output logic RegWrite,
	output logic [6:0] stateout
);

enum logic [6:0] {
	Reset = 7'd1,
	Start = 7'd2,
	WaitMemRead = 7'd3,
	Decode = 7'd4,
	Add = 7'd5,
	WriteInRegAdd = 7'd6,
	Wait = 7'd7,
	Addi = 7'd8,
	WriteInRegAddi = 7'd9
} state, nextstate;
	
always_ff@(posedge clock, posedge reset) begin
		if(reset) state <= Reset;
		else state <= nextstate;
		stateout = state;
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
				nextstate = WaitMemRead;
		end	
		WaitMemRead: begin
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
				RegWrite = 1'd0;
				nextstate = Decode;
		end
		Decode: begin
				ALUSrcA = 2'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd1;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd1;
				WriteRegB = 1'd1;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				case(OpCode)
					6'h8: begin
						nextstate = Addi;
					end
					6'h0: begin //sem nextstate
						case(Funct)
							6'h20: begin
								nextstate = Add;
							end
						endcase
					end
				endcase
		end
		Add: begin
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
				ALUOutControl = 1'd1;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				nextstate = WriteInRegAdd;
		end
		Addi: begin
				ALUSrcA = 2'd2;
				ALUSrcB = 3'd2;
				PCSource = 3'd0;
				ALUOp = 3'd1;
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
				nextstate = WriteInRegAddi;
		end
		WriteInRegAddi: begin
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
				RegWrite = 1'd1;
				nextstate = Wait;
		end
		WriteInRegAdd: begin
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
				nextstate = Wait;
		end
		Wait: begin
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

endmodule