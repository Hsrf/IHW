module A(
	input wire [31:0]data1,
	input wire writeRegA,
	output wire [31:0]valueA
	);
	
always @(posedge clock or negedge reset)
begin
 if(clock)
	if(writeRegA == 1)
		valueA = data1
end
endmodule
	
