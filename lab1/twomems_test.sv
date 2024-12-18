`timescale 1ns/1ps
module twomems_test();
logic [4:0] addr1;
logic [4:0] addr2;
logic clk, we;
logic [31:0] out_put;
logic [31:0] new_RAM [31:0];
two_mem32_32 testing(addr1, addr2, clk, we, out_put);
initial
$readmemh("sram_inp.dat.txt", RAM);
begin
	assign addr1 = 19;
	assign addr2 = 25;
	assign we = 1;
	assign clk = 1;
	assert (out_put == new_RAM[addr1[4:0]]) $error ("yeah, it works"); else $error ("nah, it not works");
	assign clk = 0; 
end
endmodule
