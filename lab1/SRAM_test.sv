`timescale 1ns/1ps
module SRAM_test();
  logic [31:0] testing;
  logic clk;
  logic [4:0] adr;
  logic [31:0] ent_test [31:0];
  sram sram_test(clk, adr, testing);
  initial
  begin
    $readmemh("sram_inp.dat.txt", ent_test);
    adr = 32'b0;
    for (int i = 0; i < 32; i++)
    begin
     #10 clk = 1;
      assert (testing == ent_test[i]) $error ("SRAM non valid"); else $error ("SRAM valid");
      #10 clk = 0;
      adr = adr + 1'b1;
  end
  end
endmodule
