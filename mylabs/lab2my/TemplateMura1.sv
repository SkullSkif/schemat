module fsm (
	input clk, reset,
	input in,
	output out
);

typedef enum logic [1:0] { s0, s1, s2 } statetype;
statetype state, nextstate;

always_comb begin
	case (state)
	s0: if (in == 1) nextstate = s1;
		else nextstate = s0;
	s1: if (in == 0) nextstate = s2;
		else nextstate = s1;
	s2: nextstate = s0;
end

always_ff @( posedge clk ) begin
	if (reset) state = s0;
	else state = nextstate;
end

assign out = (state == s2);

endmodule
