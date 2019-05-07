module CPU(
	input clock,
	input reset
);

Registrador pc(
	.clock(clock),
	.MuxPCSource(Mux_PCSource),
	.PCControlUnit(ControlUnit)
);



endmodule;