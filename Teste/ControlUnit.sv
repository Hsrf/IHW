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
	output logic [6:0] stateout,
	output logic EPCWrite,
	output logic [2:0] ShiftControl,
	output logic ShiftSrc,
	output logic ShiftAmt
);

enum logic [6:0] {
	Reset = 7'd1,
	Start = 7'd2,
	WaitMemRead = 7'd3,
	Decode = 7'd4,
	Add = 7'd5,
	WriteInReg = 7'd6,
	Wait = 7'd7,
	Addi = 7'd8,
	WriteInRegAddi = 7'd9,
	WaitMemRead2 = 7'd10,
	And = 7'd11,
	Sub = 7'd12,
	Break = 7'd13,
	WriteInPC = 7'd14,
	Rte = 7'd15,
	Jr = 7'd16,
	Sll = 7'd17,
	SllWriteReg = 7'd18,
	Sllv = 7'd19,
	SllvWriteReg = 7'd20,
	Sra = 7'd21,
	SraOp = 7'd22,
	SraWriteReg = 7'd23,
	SllvOp = 7'd24,
	SllOp = 7'd25
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
				MemToReg = 4'd0;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd1;
				RegWrite = 1'd1;
				EPCWrite = 1'd1;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = WaitMemRead2;
		end
		WaitMemRead2: begin
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = Decode;
		end
		Decode: begin
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				if(OpCode == 8)begin
					nextstate = Addi;
				end else if(OpCode == 0)begin
					case(Funct)
						6'h20: nextstate = Add;
						6'h24: nextstate = And;
						6'h22: nextstate = Sub;
						6'h8: nextstate = Jr;
						6'hd: nextstate = Break;
						6'h13: nextstate = Rte;
						6'h0: nextstate = Sll;
						6'h4: nextstate = Sllv;
						6'h3: nextstate = Sra;
					endcase
				end
				
					
		end
		// R INSTRUCTIONS
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = WriteInReg;
		end
		And: begin
				ALUSrcA = 2'd2 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd3;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = WriteInReg;
		end
		Sub: begin
				ALUSrcA = 2'd2 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd2;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = WriteInReg;
		end
		Jr: begin
				ALUSrcA = 2'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd4;
				ALUOp = 3'd0;
				PCWrite = 1'd1;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd1;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = Wait;
		end
		Sll: begin
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
				WriteRegB = 1'd1;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				EPCWrite = 1'd0;
				ShiftControl = 3'd1;
				ShiftSrc = 1'd1;
				ShiftAmt = 1'd1;
				nextstate = SllOp;
		end
		SllOp: begin
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd2;
				ShiftSrc = 1'd1;
				ShiftAmt = 1'd1;
				nextstate = SllWriteReg;
		end
		SllWriteReg: begin
				ALUSrcA = 2'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd4;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd3;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd2;
				ShiftSrc = 1'd1;
				ShiftAmt = 1'd1;
				nextstate = Wait;
		end
		Sllv: begin
				ALUSrcA = 2'd0;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd1;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = SllvOp;
		end
		SllvOp: begin
				ALUSrcA = 2'd0;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd2;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = SllvWriteReg;
		end
		SllvWriteReg: begin
				ALUSrcA = 2'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd4;
				WriteRegA = 1'd1;
				WriteRegB = 1'd1;
				ALUOutControl = 1'd0;
				RegDst = 2'd3;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd2;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = Wait;
		end
		Sra: begin
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
				WriteRegB = 1'd1;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				EPCWrite = 1'd0;
				ShiftControl = 3'd1;
				ShiftSrc = 1'd1;
				ShiftAmt = 1'd1;
				nextstate = SraOp;
		end
		SraOp: begin
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd4;
				ShiftSrc = 1'd1;
				ShiftAmt = 1'd1;
				nextstate = SraWriteReg;
		end
		SraWriteReg: begin
				ALUSrcA = 2'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd4;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd3;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd4;
				ShiftSrc = 1'd1;
				ShiftAmt = 1'd1;
				nextstate = Wait;
		end
		Rte: begin
				ALUSrcA = 2'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd3;
				ALUOp = 3'd0;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = Wait;
		end
		Break: begin
				ALUSrcA = 2'd0 ;
				ALUSrcB = 3'd1;
				PCSource = 3'd0;
				ALUOp = 3'd2;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = WriteInPC;
		end
		// I INSTRUCTIONS
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = WriteInRegAddi;
		end
		// WRITE AND WAITS
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = Wait;
		end
		WriteInReg: begin
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = Wait;
		end
		WriteInPC: begin
				ALUSrcA = 2'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd1;
				ALUOp = 3'd0;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				nextstate = Start;
		end
	endcase
end

endmodule