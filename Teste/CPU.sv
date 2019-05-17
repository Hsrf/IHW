module CPU(
	input logic clock,
	input logic reset,
	output logic [6:0] stateout,
	output logic [31:0] MuxMemToRegOut,
	output logic [4:0] MuxRegDstOut,
	output logic [4:0] rd,
	output logic [31:0] ImediatoExtended,
	output logic [5:0] OpCode,
	output logic [5:0] Funct,
	output logic [4:0] MuxShiftAmtOut,
	output logic [31:0] MuxShiftSrcOut,
	output logic [31:0] RegDeslocResult,
	output logic [4:0] RegBOut5Bit,
	output logic [4:0] Shamt,
	output logic [31:0] RegBOut,
	output logic [2:0] ShiftControl,
	output logic [31:0] RegAOut
);

logic [31:0] MuxALUSourceAOut;
logic [31:0] MuxALUSourceBOut;
logic [4:0] Reg1;
logic [4:0] Reg2;
logic [31:0] RegWriteOut1;
logic [31:0] RegWriteOut2;
logic [31:0] ALUResult;
logic RegWrite;
logic [15:0] Imediato;
logic [31:0] ALUOutOut;
logic ALUOutControl;
logic [31:0] PCOut;
logic [31:0] EPCOut;
logic [31:0] MuxPCSourceOut;
logic [2:0] ALUOp;
logic PCWrite;
logic [1:0] ALUSrcA;
logic [2:0] ALUSrcB;
logic [2:0] PCSource;
logic Overflow;
logic Negativo;
logic Zero;
logic Igual;
logic MaiorQue;
logic MenorQue;
logic Load;
logic [31:0] MuxIordOut;
logic MemWr;
logic [31:0] MemOut;
logic IRWrite;
logic [2:0] Iord;
logic [3:0] MemToReg;
logic WriteRegA;
logic WriteRegB;
logic [1:0] RegDst;
logic EPCWrite;
logic ShiftSrc;
logic ShiftAmt;

Registrador PC(
	.Clk(clock),
	.Reset(reset),
	.Load(PCWrite),
	.Entrada(MuxPCSourceOut),
	.Saida(PCOut)
);

Registrador EPC(
	.Clk(clock),
	.Reset(reset),
	.Load(EPCWrite),
	.Entrada(PCOut),
	.Saida(EPCOut)
);

ControlUnit ControlUnit(
	.clock(clock),
	.reset(reset),
	.ALUSrcA(ALUSrcA),
	.ALUSrcB(ALUSrcB),
	.PCSource(PCSource),
	.ALUOp(ALUOp),
	.PCWrite(PCWrite),
	.Overflow(Overflow),
	.Negativo(Negativo),
	.Zero(Zero),
	.Igual(Igual),
	.MaiorQue(MaiorQue),
	.MenorQue(MenorQue),
	.MemWr(MemWr),
	.IRWrite(IRWrite),
	.Iord(Iord),
	.MemToReg(MemToReg),
	.WriteRegA(WriteRegA),
	.WriteRegB(WriteRegB),
	.ALUOutControl(ALUOutControl),
	.RegDst(RegDst),
	.RegWrite(RegWrite),
	.stateout(stateout),
	.OpCode(OpCode),
	.Funct(Funct),
	.EPCWrite(EPCWrite),
	.ShiftControl(ShiftControl),
	.ShiftSrc(ShiftSrc),
	.ShiftAmt(ShiftAmt)
);


MuxALUSrcA MuxALUSrcA(
	.A(PCOut),
	.B(1'd0),
	.C(RegAOut),
	.D(1'd0),
	.out(MuxALUSourceAOut),
	.SrcA(ALUSrcA)
);

MuxALUSrcB MuxALUSrcB(
	.A(RegBOut),
	.B(3'd4),
	.C(ImediatoExtended),
	.D(1'd0),
	.E(1'd0),
	.F(1'd0),
	.out(MuxALUSourceBOut),
	.SrcB(ALUSrcB)
);

MuxPCSource MuxPCSource(
	.A(ALUResult),
	.B(1'd0),
	.C(1'd0),
	.D(EPCOut),
	.E(RegAOut),
	.F(1'd0),
	.out(MuxPCSourceOut),
	.PCSource(PCSource)
);

ula32 ULA(
	.A(MuxALUSourceAOut),
	.B(MuxALUSourceBOut),
	.Seletor(ALUOp),
	.S(ALUResult),
	.Overflow(Overflow),
	.Negativo(Negativo),
	.z(Zero),
	.Igual(Igual),
	.Maior(MaiorQue),
	.Menor(MenorQue)
);

Memoria Memoria(
	.Address(MuxIordOut),
	.Clock(clock),
	.Wr(MemWr),
	.Datain(1'd0),
	.Dataout(MemOut)
);

Instr_Reg InstructionRegister(
	.Clk(clock),
	.Reset(reset),
	.Load_ir(IRWrite),
	.Entrada(MemOut),
	.Instr31_26(OpCode),
	.Instr25_21(Reg1),
	.Instr20_16(Reg2),
	.Instr15_0(Imediato)
);

MuxIord MuxIord(
	.A(PCOut),
	.B(1'd0),
	.C(1'd0),
	.D(1'd0),
	.E(1'd0),
	.F(1'd0),
	.out(MuxIordOut),
	.Iord(Iord)
);

MuxMemToReg MuxMemToReg(
	.A(ALUOutOut),
	.B(1'd0),
	.C(1'd0),
	.D(1'd0),
	.E(RegDeslocResult),
	.F(1'd0),
	.G(1'd0),
	.H(1'd0),
	.out(MuxMemToRegOut),
	.MemToReg(MemToReg)
);

Registrador A(
	.Clk(clock),
	.Reset(reset),
	.Load(WriteRegA),
	.Entrada(RegWriteOut1),
	.Saida(RegAOut)
);

Registrador B(
	.Clk(clock),
	.Reset(reset),
	.Load(WriteRegB),
	.Entrada(RegWriteOut2),
	.Saida(RegBOut)
);

Registrador ALUOut(
	.Clk(clock),
	.Reset(reset),
	.Load(ALUOutControl),
	.Entrada(ALUResult),
	.Saida(ALUOutOut)
);

MuxRegDst MuxRegDst(
	.A(Reg2),
	.B(1'd29),
	.C(1'd0),
	.D(rd),
	.out(MuxRegDstOut),
	.RegDst(RegDst)
);

Banco_reg BancoRegistradores(
	.Clk(clock),
	.Reset(reset),
	.RegWrite(RegWrite),
	.ReadReg1(Reg1),
	.ReadReg2(Reg2),
	.WriteReg(MuxRegDstOut),
	.WriteData(MuxMemToRegOut),
	.ReadData1(RegWriteOut1),
	.ReadData2(RegWriteOut2)
);

RegDesloc RegDesloc(
	.Clk(clock),
	.Reset(reset),
	.Shift(ShiftControl),
	.N(MuxShiftAmtOut),
	.Entrada(MuxShiftSrcOut),
	.Saida(RegDeslocResult)
);

MuxShiftSrc MuxShiftSrc(
	.A(RegAOut), 
	.B(RegBOut), 
	.out(MuxShiftSrcOut), 
	.ShiftSrc(ShiftSrc)
);

MuxShiftAmt MuxShiftAmt(
	.A(RegBOut5Bit), 
	.B(Shamt), 
	.out(MuxShiftAmtOut), 
	.ShiftAmt(ShiftAmt)
);

assign Shamt = Imediato[10:6];
assign RegBOut5Bit = RegBOut[4:0];
assign rd = Imediato [15:11];
assign Funct = Imediato [5:0];
assign ImediatoExtended = Imediato;

endmodule