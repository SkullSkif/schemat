module dmem_init(
  input logic clk,
  input logic we,
  input logic [4:0] a, // ???????? ?? 5 ??? ??? 32 ???????
  input logic [31:0] wd,
  output logic [31:0] rd
);

  logic [31:0] RAM[31:0]; // ????? ?????? 32 ????? (32 * 4 ?????)

  // ????????????? ??????
  initial begin
    RAM[0] = 32'h00000000;
    RAM[1] = 32'h00000000;
    RAM[2] = 32'h00000055;
    RAM[3] = 32'h00000000;
    RAM[4] = 32'h00020007;
    RAM[5] = 32'h00000000;
    RAM[6] = 32'h00000000;
    RAM[7] = 32'h00000044;
    RAM[8] = 32'h00000000;
    RAM[9] = 32'h00001043;
    RAM[10] = 32'h01000008;
    RAM[11] = 32'h00000000;
    RAM[12] = 32'h00003040;
    // ????????? ?????? ?????????????? ??????

  end

  // ?????? ?????? ?? ??????
  assign rd = RAM[a[4:0]];
  // ?????? ?????? ? ??????
	always @(posedge clk)
		if (we) RAM[a[4:0]] <= wd;

endmodule
