module PC(
	input clock, 
	input reset,
	input wire [31:0]MuxPCSource,
	input wire [31:0]PCControlUnit,
	output wire [31:0]PC;
	

);


always @(posedge clock or negedge reset) begin
	if(clock)
		if(PCControlUnit == 1)
			PC <= MuxPCSource;
	end
endmodule;