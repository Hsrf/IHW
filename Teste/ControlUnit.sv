module ControlUnit(
	input logic clock,
	input logic reset,
	input logic [5:0] OpCode,
	input logic [5:0] Funct,
	output logic [2:0] ALUSrcA,
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
	input logic MultOut,
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
	output logic ShiftAmt,
	output logic [1:0] IsControl,
	output logic MemDataReg,
	output logic MultControl,
	output logic [1:0] SControl,
	output logic MuxWriteMemControl,
	output logic WriteHI,
	output logic WriteLO,
	output logic HIControl,
	output logic LOControl
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
	SllOp = 7'd25,
	Srav = 7'd26,
	SravOp = 7'd27,
	SravWriteReg = 7'd28,
	Srl = 7'd29,
	SrlOp = 7'd30,
	SrlWriteReg = 7'd31,
	Slt = 7'd32,
	Mfhi = 7'd69,
	Mflo = 7'd70,
	OverflowExc = 7'd33,
	Addiu = 7'd34,
	Slti = 7'd63,
	// DESVIOS
	Beq = 7'd35,
	BeqCompare = 7'd36,
	Bne = 7'd37,
	BneCompare = 7'd38,
	Bgt = 7'd39,
	BgtCompare = 7'd40,
	Ble = 7'd41,
	BleCompare = 7'd42,
	// LOADS
	Lw = 7'd43,
	LGet = 7'd44,
	LSave = 7'd45,
	LSaveh = 7'd46,
	LSaveb = 7'd47,
	Lui = 7'd48,
	Lui2 = 7'd49,
	LGet2 = 7'd53,
	LGet3 = 7'd54,
	// STORES
	Store = 7'd56,
	StoreGet = 7'd57,
	StoreData = 7'd58,
	StoreData2 = 7'd62,
	StoreSave = 7'd59,
	StoreSaveb = 7'd60,
	StoreSaveh = 7'd61,
	// JUMPS
	Jump = 7'd50,
	Jal = 7'd51,
	WriteJal = 7'd52,
	// INC E DEC
	Inc = 7'd64,
	IncWait = 7'd65,
	IncGetData = 7'd66,
	IncOp = 7'd67,
	IncWrite = 7'd68,
	// MULT E DIV
	Mult = 7'd55,
	Mult2 = 7'd80,
	Mult3 = 7'd81
} state, nextstate;
	
always_ff@(posedge clock, posedge reset) begin
		if(reset) state <= Reset;
		else state <= nextstate;
		stateout = state;
end

always @* begin
	case(state)
		Reset: begin
				ALUSrcA = 3'd0;
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
				EPCWrite = 1'd1;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Start;
		end
		Start: begin
				ALUSrcA = 3'd0 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = WaitMemRead;
		end	
		WaitMemRead: begin
				ALUSrcA = 3'd0 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = WaitMemRead2;
		end
		WaitMemRead2: begin
				ALUSrcA = 3'd0 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Decode;
		end
		Decode: begin
				ALUSrcA = 3'd0 ;
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
				IsControl = 2'd0;
				MultControl =1'd0;
				MemDataReg = 1'd0;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				MuxWriteMemControl = 1'd0;
				if(OpCode == 8)begin
					nextstate = Addi;
				end else if (OpCode == 6'h9) begin
					nextstate = Addiu;
				end else if (OpCode == 4) begin
					nextstate = Beq;
				end else if (OpCode == 5) begin
					nextstate = Bne;
				end else if (OpCode == 6) begin
					nextstate = Ble;
				end else if (OpCode == 7) begin
					nextstate = Bgt;
				end else if (OpCode == 6'hf) begin
					nextstate = Lui;
				end else if (OpCode == 6'h23 || OpCode == 6'h20 || OpCode == 6'h21) begin
					nextstate = Lw;
				end else if (OpCode == 2) begin
					nextstate = Jump;
				end else if (OpCode == 3) begin
					nextstate = Jal;
				end else if (OpCode == 6'h2b || OpCode == 6'h28 || OpCode == 6'h29) begin
					nextstate = Store;
				end else if (OpCode == 6'ha) begin
					nextstate = Slti;
				end else if (OpCode == 6'h10 || OpCode == 6'h11) begin
					nextstate = Inc;
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
						6'h7: nextstate = Srav;
						6'h2: nextstate = Srl;
						6'h2a: nextstate = Slt;
						6'h18: nextstate = Mult;
						6'h10: nextstate = Mfhi;
						6'h12: nextstate = Mflo;
					endcase
				end	
		end
		// R INSTRUCTIONS
		Add: begin
				ALUSrcA = 3'd2 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = WriteInReg;
		end
		And: begin
				ALUSrcA = 3'd2 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = WriteInReg;
		end
		Sub: begin
				ALUSrcA = 3'd2 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = WriteInReg;
		end
		Jr: begin
				ALUSrcA = 3'd0 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Slt: begin
				ALUSrcA = 3'd2 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd7;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd8;
				WriteRegA = 1'd1;
				WriteRegB = 1'd1;
				ALUOutControl = 1'd0;
				RegDst = 2'd3;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Sll: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SllOp;
		end
		SllOp: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SllWriteReg;
		end
		SllWriteReg: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Srl: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SrlOp;
		end
		SrlOp: begin
				ALUSrcA = 3'd0;
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
				ShiftControl = 3'd3;
				ShiftSrc = 1'd1;
				ShiftAmt = 1'd1;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				MuxWriteMemControl = 1'd0;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SrlWriteReg;
		end
		SrlWriteReg: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Sllv: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SllvOp;
		end
		SllvOp: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SllvWriteReg;
		end
		SllvWriteReg: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Sra: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SraOp;
		end
		SraOp: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SraWriteReg;
		end
		SraWriteReg: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Srav: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SravOp;
		end
		SravOp: begin
				ALUSrcA = 3'd0;
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
				ShiftControl = 3'd4;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = SravWriteReg;
		end
		SravWriteReg: begin
				ALUSrcA = 3'd0;
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
				ShiftControl = 3'd4;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Mfhi: begin
				ALUSrcA = 3'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd1;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd3;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Mflo: begin
				ALUSrcA = 3'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd2;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd3;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Rte: begin
				ALUSrcA = 3'd0 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Break: begin
				ALUSrcA = 3'd0 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = WriteInPC;
		end
		Mult: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl = 1'd1;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				MuxWriteMemControl = 1'd0;
				nextstate = Mult2;
		end
		Mult2: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl = 1'd1;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				MuxWriteMemControl = 1'd0;
				if (MultOut == 0) begin
					nextstate = Mult2;
				end else begin
					nextstate = Mult3;
				end
		end
		Mult3: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl = 1'd1;
				SControl = 2'd0;
				WriteHI = 1'd1;
				WriteLO = 1'd1;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				MuxWriteMemControl = 1'd0;
				nextstate = Wait;
		end
		// I INSTRUCTIONS
		Addi: begin
				ALUSrcA = 3'd2;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				SControl = 2'd0;
				case(Overflow)
					1'd0: nextstate = WriteInRegAddi;
					1'd1: nextstate = OverflowExc;
				endcase
		end
		Addiu: begin
				ALUSrcA = 3'd2;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = WriteInRegAddi;
		end
		Slti: begin
				ALUSrcA = 3'd2 ;
				ALUSrcB = 3'd2;
				PCSource = 3'd0;
				ALUOp = 3'd7;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd8;
				WriteRegA = 1'd1;
				WriteRegB = 1'd1;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		// BRANCHES
		Beq: begin
			ALUSrcA = 3'd0;
			ALUSrcB = 3'd3;
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
			IsControl = 2'd0;
			MemDataReg = 1'd0;
			MultControl =1'd0;
			SControl = 2'd0;
			MuxWriteMemControl = 1'd0;
			WriteHI = 1'd0;
			WriteLO = 1'd0;
			HIControl = 1'd0;
			LOControl  = 1'd0;
			nextstate = BeqCompare;
		end
		BeqCompare: begin
			ALUSrcA = 3'd2;
			ALUSrcB = 3'd0;
			PCSource = 3'd1;
			ALUOp = 3'd7;
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
			IsControl = 2'd0;
			MemDataReg = 1'd0;
			MultControl =1'd0;
			SControl = 2'd0;
			WriteHI = 1'd0;
			WriteLO = 1'd0;
			HIControl = 1'd0;
			LOControl  = 1'd0;
			MuxWriteMemControl = 1'd0;
			if (Igual == 1) begin
				PCWrite = 1'd1;
			end else begin
				PCWrite = 1'd0;
			end
			nextstate = Wait;
		end
		Bne: begin
			ALUSrcA = 3'd0;
			ALUSrcB = 3'd3;
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
			IsControl = 2'd0;
			MemDataReg = 1'd0;
			MultControl =1'd0;
			SControl = 2'd0;
			WriteHI = 1'd0;
			WriteLO = 1'd0;
			HIControl = 1'd0;
			LOControl  = 1'd0;
			MuxWriteMemControl = 1'd0;
			nextstate = BneCompare;
		end
		BneCompare: begin
			ALUSrcA = 3'd2;
			ALUSrcB = 3'd0;
			PCSource = 3'd1;
			ALUOp = 3'd7;
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
			IsControl = 2'd0;
			MemDataReg = 1'd0;
			nextstate = Wait;
			MultControl =1'd0;
			SControl = 2'd0;
			WriteHI = 1'd0;
			WriteLO = 1'd0;
			HIControl = 1'd0;
			LOControl  = 1'd0;
			MuxWriteMemControl = 1'd0;
			if (Igual == 0) begin
				PCWrite = 1'd1;
			end else begin
				PCWrite = 1'd0;
			end
		end
		Bgt: begin
			ALUSrcA = 3'd0;
			ALUSrcB = 3'd3;
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
			IsControl = 2'd0;
			MemDataReg = 1'd0;
			MultControl =1'd0;
			SControl = 2'd0;
			MuxWriteMemControl = 1'd0;
			WriteHI = 1'd0;
			WriteLO = 1'd0;
			HIControl = 1'd0;
			LOControl  = 1'd0;
			nextstate = BgtCompare;
		end
		BgtCompare: begin
			ALUSrcA = 3'd2;
			ALUSrcB = 3'd0;
			PCSource = 3'd1;
			ALUOp = 3'd7;
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
			IsControl = 2'd0;
			MemDataReg = 1'd0;
			MultControl =1'd0;
			nextstate = Wait;
			SControl = 2'd0;
			WriteHI = 1'd0;
			WriteLO = 1'd0;
			HIControl = 1'd0;
			LOControl  = 1'd0;
			MuxWriteMemControl = 1'd0;
			if (MaiorQue == 1) begin
				PCWrite = 1'd1;
			end else begin
				PCWrite = 1'd0;
			end
		end
		Ble: begin
			ALUSrcA = 3'd0;
			ALUSrcB = 3'd3;
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
			IsControl = 2'd0;
			MultControl =1'd0;
			MemDataReg = 1'd0;
			MuxWriteMemControl = 1'd0;
			SControl = 2'd0;
			WriteHI = 1'd0;
			WriteLO = 1'd0;
			HIControl = 1'd0;
			LOControl  = 1'd0;
			nextstate = BleCompare;
		end
		BleCompare: begin
			ALUSrcA = 3'd2;
			ALUSrcB = 3'd0;
			PCSource = 3'd1;
			ALUOp = 3'd7;
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
			IsControl = 2'd0;
			MemDataReg = 1'd0;
			MultControl =1'd0;
			SControl = 2'd0;
			WriteHI = 1'd0;
			WriteLO = 1'd0;
			HIControl = 1'd0;
			LOControl  = 1'd0;
			MuxWriteMemControl = 1'd0;
			nextstate = Wait;
			if (MaiorQue == 0) begin
				PCWrite = 1'd1;
			end else begin
				PCWrite = 1'd0;
			end
		end
		// LOADS
		Lw: begin
				ALUSrcA = 3'd2;
				ALUSrcB = 3'd2;
				PCSource = 3'd0;
				ALUOp = 3'd1;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd1;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd1;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				MuxWriteMemControl = 1'd0;
				nextstate = LGet;
		end
		LGet:begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd1;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = LGet2;
		end
		LGet2: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = LGet3;
		end
		LGet3: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MemDataReg = 1'd1;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				case(OpCode)
					6'h20: nextstate = LSaveb;
					6'h21: nextstate = LSaveh;
					6'h23: nextstate = LSave;
				endcase
		end
		LSave: begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd3;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		LSaveh: begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd3;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd1;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		LSaveb: begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd3;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd2;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Lui: begin
				ALUSrcA = 3'd1;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Lui2;
		end
		Lui2: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		// STORES
		Store: begin
				ALUSrcA = 3'd2;
				ALUSrcB = 3'd2;
				PCSource = 3'd0;
				ALUOp = 3'd1;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd0;
				MemToReg = 4'd0;
				WriteRegA = 1'd1;
				WriteRegB = 1'd1;
				ALUOutControl = 1'd1;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = StoreGet;
		end
		StoreGet: begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd1;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = StoreData;
		end
		StoreData: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = StoreData2;
		end
		StoreData2: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd1;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				SControl = 2'd0;
				case(OpCode)
					6'h28: nextstate = StoreSaveb;
					6'h29: nextstate = StoreSaveh;
					6'h2b: nextstate = StoreSave;
				endcase
		end
		StoreSave: begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd1;
				IRWrite = 1'd0;
				Iord = 3'd1;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		StoreSaveh: begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd1;
				IRWrite = 1'd0;
				Iord = 3'd1;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				SControl = 2'd1;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		StoreSaveb: begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd1;
				IRWrite = 1'd0;
				Iord = 3'd1;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				SControl = 2'd2;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		// J INSTRUCTIONS
		Jump: begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd2;
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
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Jal: begin
				ALUSrcA = 3'd0;
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
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = WriteJal;
		end
		WriteJal: begin
				ALUSrcA = 3'd0;
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
				RegDst = 2'd2;
				RegWrite = 1'd1;
				EPCWrite = 1'd0;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Jump;
		end
		// INC E DEC
		Inc: begin
				ALUSrcA = 3'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd5;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd5;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = IncWait;
		end
		IncWait: begin
				ALUSrcA = 3'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd5;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd5;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				MuxWriteMemControl = 1'd0;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = IncGetData;
		end
		IncGetData: begin
				ALUSrcA = 3'd0 ;
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
				IsControl = 2'd0;
				MemDataReg = 1'd1;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = IncOp;
		end 
		IncOp: begin
				PCSource = 3'd0;
				case (OpCode)
					6'h10: begin
						ALUSrcA = 3'd3;
						ALUSrcB = 3'd5;
						ALUOp = 3'd1;
					end
					6'h11: begin
						ALUSrcA = 3'd4;
						ALUSrcB = 3'd6;
						ALUOp = 3'd2;
					end
				endcase
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = IncWrite;
		end
		IncWrite: begin
				ALUSrcA = 3'd0 ;
				ALUSrcB = 3'd0;
				PCSource = 3'd5;
				ALUOp = 3'd2;
				PCWrite = 1'd0;
				MemWr = 1'd1;
				IRWrite = 1'd0;
				Iord = 3'd5;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				MuxWriteMemControl = 1'd1;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		// WRITE AND WAITS
		WriteInRegAddi: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		WriteInReg: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end 
		WriteInPC: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		OverflowExc: begin
				ALUSrcA = 3'd0;
				ALUSrcB = 3'd0;
				PCSource = 3'd0;
				ALUOp = 3'd0;
				PCWrite = 1'd0;
				MemWr = 1'd0;
				IRWrite = 1'd0;
				Iord = 3'd3;
				MemToReg = 4'd0;
				WriteRegA = 1'd0;
				WriteRegB = 1'd0;
				ALUOutControl = 1'd0;
				RegDst = 2'd0;
				RegWrite = 1'd0;
				EPCWrite = 1'd1;
				ShiftControl = 3'd0;
				ShiftSrc = 1'd0;
				ShiftAmt = 1'd0;
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Wait;
		end
		Wait: begin
				ALUSrcA = 3'd0;
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
				IsControl = 2'd0;
				MemDataReg = 1'd0;
				MultControl =1'd0;
				SControl = 2'd0;
				WriteHI = 1'd0;
				WriteLO = 1'd0;
				HIControl = 1'd0;
				LOControl  = 1'd0;
				nextstate = Start;
		end
	endcase
end

endmodule
