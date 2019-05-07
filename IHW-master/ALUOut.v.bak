module ALUOut(
	input wire [31:0]ALUResult,
	input wire ALUOutControl,
	output wire [31:0]ALUOutResult
	);
	
always @(posedge clock or negedge reset)
begin
 if(clock)
	if(ALUOutControl == 1)
		ALUOutResult <= ALUOutControl;
end
endmodule
