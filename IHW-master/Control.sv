module Control(
	input logic clk,
	input logic reset
	);
	
enum logic [6:0] {
	Reseta,
	Start
}
	
	logic [6:0] state;
	logic [6:0] nextstate;
	
always_ff@(posedge clk, posedge reset) begin
    if(reset) state <= reseta;
    else state <= nextstate;
    //stateout = state;
end

always_comb begin
	case(state)
		Reseta: begin
		asdasdasds
	endcase