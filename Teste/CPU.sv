module CPU(
	input logic clock,
	input logic reset
);

logic [2:0] ALUOp;
logic PCWrite;
logic [31:0] MuxPCSourceOut;
logic [31:0] MuxALUSourceAOut;
logic [1:0] ALUSrcA;
logic [2:0] ALUSrcB;
logic [31:0] MuxALUSourceBOut;
logic [31:0] ALUResult;
logic [2:0] PCSource;
logic Overflow;
logic Negativo;
logic Zero;
logic Igual;
logic MaiorQue;
logic MenorQue;
logic [31:0] PCOut;
logic Load;

Registrador PC(
	.Clk(clock),
	.Reset(reset),
	.Load(Load),
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
	.MenorQue(MenorQue)
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
	
);


endmodule