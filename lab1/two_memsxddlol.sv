module two_mem32_32 (input logic [4:0] adr1, input logic [4:0] adr2, input logic clk, we, output logic [31:0] readdata); 
  wire [31:0]in;
  mem32_32_initiated frst (clk, 0, adr1, 0, in);
  mem32_32 scnd (clk, we, adr2, in, readdata); 
endmodule
