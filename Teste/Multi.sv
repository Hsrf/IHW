module Multi(MultA, MultB, Hi, Lo, MultiControl, Clk, Reset);
	input logic [31:0] MultA, MultB;
	input logic MultControl;
	output logic [31:0] Hi, Lo;
	
	logic [64:0] A, S, P;
	logic [1:0] finalP;
	logic [63:0] result;
	logic resultHiLo;
	
    always @(posedge clk or posedge Reset)begin
		if (Reset) begin
			HI <= 32'b0;
			LO <= 32'b0;
			A <= 65'b0;
			S <= 65'b0;
			P <= 65'b0;
			finalP <= 2'b0;
			resultHiLo <= 0;
		end else if (MultControl) begin
			A = {MultA[31:0], 33'b0};
			S = -A;
			P = {32'b0, MultB[31:0], 1'b0};
			for(int i = 0; iteracao < 32; i++) begin
				finalP = P[1:0];
				case (finalP)
					2'b01: P = P + A;
					2'b10: P = P + S;
					2'b00: P = P;
					2'b11: P = P;
				endcase
				P = P >> 1;
			end
			result = P[64:1];
			resultHiLo <= 1;
		end else if (resultHiLo == 1) begin
				Hi <= result[63:32];
				Lo <= result[31:0];
				resultHiLo <= 0;
		end
    end
endmodule 