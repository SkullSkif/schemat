module mem32_32_initiated(input logic clk, we, input logic [4:0] adr, input logic [31:0] wd, output logic [31:0]rd);
  initial
    $readmemh("sram_inp.dat.txt", RAM);
  logic [31:0] RAM [31:0];
  
  assign rd = RAM[adr[4:0]];
  
  always_ff @(posedge clk)
	if (we) RAM[adr[4:0]] <= wd;

endmodule

