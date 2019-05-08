module ControlUnit(
	input clock,
	input reset,
	output logic ALUSrcA,
	output logic ALUSrcB,
	output logic PCSource,
	output logic ALUOp,
	output logic PCWrite
);


enum logic [6:0] {
	Reset = 7'd1,
	Start = 7'd2
}
	
input logic [6:0] state;
input logic [6:0] nextstate;
	
always_ff@(posedge clk, posedge reset) begin
    if(reset) state <= Reset;
    else state <= nextstate;
    //stateout = state;
end

always_comb begin
	case(state)
		Start: begin
			ALUSrcA = 2'd0;
			ALUSrcB = 3'd1;
			ALUOp = 3'd1;
			PCSource = 3'd0;
			PCwrite = 1'd0;
			nextstate = Start;
		end
		
				
	endcase
end



endmodule