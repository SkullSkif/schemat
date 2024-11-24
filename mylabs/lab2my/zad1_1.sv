module First #(parameter N = 3)(
	input logic clk, reset,
	input logic start,
	output logic done
);

typedef enum logic [1:0] { s0, s1, s2 } statetype;
statetype state, nextstate;

logic [N-1:0] delay;

always_comb begin
	case (state)
	s0: if (start == 1) begin 
		nextstate = s1;
	end
	else nextstate = s0;
	s1: if (start == 0) nextstate = s2;
		else begin
			nextstate = s1;
			if ((delay + 1) == '0)
				nextstate = s2;
		end			
	s2: nextstate = s0;
	endcase
end

always_ff @( posedge clk ) begin
	if ((reset) || (state == s0)) begin
		delay <= '0;
	end else begin
		delay <= delay + 1;
	end

	if (reset) state = s0;
	else state = nextstate;
end


assign done = (state == s2);

endmodule
