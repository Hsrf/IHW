module CPU(
	input logic clock,
	input logic reset,
	output logic [6:0] stateout,
	output logic [5:0] OpCode,
	output logic [31:0] MuxALUSourceAOut,
	output logic [31:0] MuxALUSourceBOut,
	output logic [31:0] ALUOutOut,
	output logic [31:0] MemOut,
	output logic [31:0] MuxIordOut,
	output logic [31:0] MemDataRegOut,
	output logic [1:0] SControl,
	output logic [31:0] MultA;
	output logic [31:0] MultB;
	output logic [31:0] MultHi;
	output logic [31:0] MultLo;
	output logic MultStop;
);

logic MuxWriteMemControl;
logic [31:0] PCOut;
logic [31:0] MuxMemToRegOut;
logic [4:0] MuxRegDstOut;
logic MemWr;
logic [31:0] ExtendLeft2;
logic [1:0] IsControl;
logic [27:0] ExtendLeftImediato2;
logic [25:0] Imediato2;
logic [31:0] ExtendLeftImediato2PC;
logic [31:0] RegAOut;
logic [4:0] rd;
logic [31:0] ImediatoExtended;
logic [5:0] Funct;
logic [31:0] MenorQueExtended;
logic [31:0] LoadBoxOut;
logic [4:0] MuxShiftAmtOut;
logic [31:0] MuxShiftSrcOut;
logic [31:0] RegDeslocResult;
logic [4:0] RegBOut5Bit;
logic [4:0] Shamt;
logic [2:0] ShiftControl;
logic MenorQue;
logic Igual;
logic MaiorQue;
logic Overflow;
logic [4:0] Reg1;
logic [4:0] Reg2;
logic [31:0] RegWriteOut1;
logic [31:0] RegWriteOut2;
logic [31:0] ALUResult;
logic RegWrite;
logic [15:0] Imediato;
logic ALUOutControl;
logic [31:0] EPCOut;
logic [31:0] MuxPCSourceOut;
logic [2:0] ALUOp;
logic PCWrite;
logic [2:0] ALUSrcA;
logic [2:0] ALUSrcB;
logic [2:0] PCSource;
logic Negativo;
logic Zero;
logic Load;
logic IRWrite;
logic [2:0] Iord;
logic [3:0] MemToReg;
logic WriteRegA;
logic WriteRegB;
logic [1:0] RegDst;
logic EPCWrite;
logic ShiftSrc;
logic ShiftAmt;
logic MemDataRegControl;
logic MultControl;
logic [31:0] MuxHIOut;
logic [31:0] MuxLOOut;
logic [31:0] HIOut;
logic [31:0] LOOut;
logic WriteHI;
logic WriteLO;
logic HIControl;
logic LOControl;
logic [31:0] StoreBoxOut;
logic [31:0] RegBOut;
logic [31:0] ExtendImediato2to32bit;
logic [31:0] MuxWriteMemOut;

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
	.ShiftAmt(ShiftAmt),
	.IsControl(IsControl),
	.MemDataReg(MemDataRegControl),
	.MultControl(MultControl),
	.SControl(SControl),
	.MuxWriteMemControl(MuxWriteMemControl),
	.WriteHI(WriteHI),
	.WriteLO(WriteLO),
	.HIControl(HIControl),
	.LOControl(LOControl),
	.MultOut(MultStop)
);


MuxALUSrcA MuxALUSrcA(
	.A(PCOut),
	.B(32'd0),
	.C(RegAOut),
	.D(32'd1),
	.E(MemDataRegOut),
	.out(MuxALUSourceAOut),
	.SrcA(ALUSrcA)
);

MuxALUSrcB MuxALUSrcB(
	.A(RegBOut),
	.B(3'd4),
	.C(ImediatoExtended),
	.D(ExtendLeft2),
	.E(1'd0),
	.F(MemDataRegOut),
	.G(32'd1),
	.out(MuxALUSourceBOut),
	.SrcB(ALUSrcB)
);

MuxPCSource MuxPCSource(
	.A(ALUResult),
	.B(ALUOutOut),
	.C(ExtendLeftImediato2PC),
	.D(EPCOut),
	.E(RegAOut),
	.F(ExtendImediato2to32bit),
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
	.Datain(MuxWriteMemOut),
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
	.B(ALUOutOut),
	.C(32'd253),
	.D(32'd254),
	.E(32'd255),
	.F(MuxPCSourceOut),
	.out(MuxIordOut),
	.Iord(Iord)
);

MuxMemToReg MuxMemToReg(
	.A(ALUOutOut),
	.B(HIOut),
	.C(LOOut),
	.D(LoadBoxOut),
	.E(RegDeslocResult),
	.F(1'd0),
	.G(1'd0),
	.H(MenorQueExtended),
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
	.B(5'd29),
	.C(5'd31),
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

Registrador MemDataReg(
	.Clk(clock),
	.Reset(reset),
	.Load(MemDataRegControl),
	.Entrada(MemOut),
	.Saida(MemDataRegOut)
);

 LoadBox LoadBox(
	.A(MemDataRegOut),
	.IsControl(IsControl),
	.out(LoadBoxOut)
);

Multi Multi(
	.Clk(clock),
	.Reset(reset),
	.MultControl(MultControl),
	.MultA(RegAOut),
	.MultB(RegBOut),
	.Hi(MultHi),
	.Lo(MultLo),
	.out(MultStop)
);

StoreBox StoreBox(
	.A(MemDataRegOut),
	.B(RegBOut),
	.SControl(SControl),
	.out(StoreBoxOut)
);

MuxWriteMem MuxWriteMem(
	.A(StoreBoxOut),
	.B(ALUOutOut),
	.MuxWriteMemControl(MuxWriteMemControl),
	.out(MuxWriteMemOut)
);

Registrador HI(
	.Clk(clock),
	.Reset(reset),
	.Load(WriteHI),
	.Entrada(MuxHIOut),
	.Saida(HIOut)
);

Registrador LO(
	.Clk(clock),
	.Reset(reset),
	.Load(WriteLO),
	.Entrada(MuxLOOut),
	.Saida(LOOut)
);

MuxHI MuxHI(
	.A(MultHI), 
	.B(32'd0), 
	.out(MuxHIOut), 
	.HIControl(HIControl)
);

 MuxLO MuxLO(
	.A(MultLO), 
	.B(32'd0), 
	.out(MuxLOOut), 
	.LOControl(LOControl)
);

assign MenorQueExtended = MenorQue;
assign Shamt = Imediato[10:6];
assign RegBOut5Bit = RegBOut[4:0];
assign rd = Imediato [15:11];
assign Funct = Imediato [5:0];
assign ImediatoExtended = Imediato;
assign ExtendLeft2[31:2] = ImediatoExtended[29:0];
assign Imediato2 = {Reg1, Reg2, Imediato};
assign ExtendLeftImediato2[27:2] = Imediato2[25:0];
assign ExtendImediato2to32bit = Imediato2;
assign ExtendLeftImediato2PC = {PCOut[31:28], ExtendLeftImediato2};

endmodule