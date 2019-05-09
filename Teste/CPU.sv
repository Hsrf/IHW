module CPU(
	input logic clock,
	input logic reset,
	output logic [31:0] AluOutOut,
	output logic [31:0] PCOut,
	output logic [31:0] MuxPCSourceOut,
	output logic [31:0] MuxALUSourceAOut,
	output logic [31:0] MuxALUSourceBOut,
	output logic [6:0] stateout,
	output logic [4:0] Reg1,
	output logic [4:0] Reg2,
	output logic [31:0] RegAOut,
	output logic [31:0] RegBOut,
	output logic [31:0] RegWriteOut1,
	output logic [31:0] RegWriteOut2
);

logic [2:0] ALUOp;
logic PCWrite;
logic [1:0] ALUSrcA;
logic [2:0] ALUSrcB;
logic [31:0] ALUResult;
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
logic [31:0] MemToRegOut;
logic [3:0] MemToReg;
logic WriteRegA;
logic WriteRegB;
logic ALUOutControl;
logic [31:0] MuxRegDstOut;
logic [1:0] RegDst;
logic RegWrite;
logic [5:0] OpCode;
logic [15:0] Imeadiato;


Registrador PC(
	.Clk(clock),
	.Reset(reset),
	.Load(PCWrite),
	.Entrada(MuxPCSourceOut),
	.Saida(PCOut)
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
	.OpCode(OpCode)
);


MuxALUSrcA MuxALUSrcA(
	.A(PCOut),
	.B(1'd0),
	.C(1'd0),
	.D(1'd0),
	.out(MuxALUSourceAOut),
	.SrcA(ALUSrcA)
);

MuxALUSrcB MuxALUSrcB(
	.A(1'd0),
	.B(3'd4),
	.C(1'd0),
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
	.D(1'd0),
	.E(1'd0),
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
	.A(AluOutOut),
	.B(1'd0),
	.C(1'd0),
	.D(1'd0),
	.E(1'd0),
	.F(1'd0),
	.G(1'd0),
	.H(1'd0),
	.out(MemToRegOut),
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
	.Entrada(WriteRegOut2),
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
	.A(MemOut[20:16]),
	.B(1'd0),
	.C(1'd0),
	.D(1'd0),
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


endmodule