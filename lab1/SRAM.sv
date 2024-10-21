module sram (input logic clk, input logic [4:0] addr, output logic [31:0] out);
	logic [31:0] SRAM [31:0];
	initial
	 $readmemh("sram_inp.dat.txt", SRAM);
	always_ff @(posedge clk)
	 out <= SRAM[addr[4:0]];
endmodule
