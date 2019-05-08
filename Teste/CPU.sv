module CPU(
	input clock,
	input reset
);

logic Mux_PCSource [31:0];
logic PC_MuxPCSource [31:0];
logic ALUOp [2:0];
logic PCWrite;
logic MuxPCSourceOut [31:0];
logic MuxALUSourceAOut [31:0];
logic ALUSrcA [1:0];
logic ALUSrcB [2:0];
logic MuxALUSourceBOut [31:0];
logic ALUResult[31:0];
logic MuxPCSourceOut[31:0];
logic PCSource[2:0];



Registrador PC(
	.Clk(clock),
	.Reset(reset),
	.Load(load),
	.Entrada(Mux_PCSource),
	.Saida(MuxPCSourceOut)
);

ControlUnit ControlUnit(
	.Clk(clock),
	.Reset(reset),
	.ALUSrcA(ALUSrcA),
	.ALUSrcB(ALUSrcB),
	.PCSource(PCSource),
	.ALUOp(ALUOp),
	.PCWrite(PCWrite)
);

MuxALUSrcA MuxALUSrcA(
	.A(PC_MuxPCSource),
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


endmodule