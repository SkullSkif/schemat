module mem32 (
	input logic clk,
	input logic we,
	input logic [4:0] a,
	input logic [31:0] wd,
	output logic [31:0] rd
);

logic [31:0] RAM[31:0];

assign rd = RAM[a[4:0]];

always_ff @(posedge clk)
	if (we) RAM[a[4:0]] <= wd;
endmodule

module mem32x2 (
	input logic xclk,
	input logic writeenable,
	logic [31:0] xwd,
	input logic [4:0] dataadr1,
	input logic [4:0] dataadr2, 
	output logic [31:0] readdata2
);

dmem_init mem1(.clk(xclk), .we(0), .a(dataadr1), .wd(0), .rd(xwd));
mem32 mem2(.clk(xclk), .we(writeenable), .a(dataadr2), .wd(xwd), .rd(readdata2));

endmodule

