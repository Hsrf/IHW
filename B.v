module B(
	input clock,
	input reset,
	input wire [31:0]data2,
	input wire writeRegB,
	output wire [31:0]valueB
);
	
	always @(posedge clock or negedge reset) begin
		if(clock)
			if(writeRegB == 1)
				valueB <= data2;
	end
endmodule
