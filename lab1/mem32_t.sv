`timescale 1ns/1ps

module mem32_t();
  logic [31:0] in1;
  logic [31:0] out1;
  logic [5:0] a1;
  logic we1, clk;
  int w;
  mem32 memtest(clk, we1, a1, in1, out1);
  initial
  begin
    for(w = 0; w < 64;w++)
      begin
        a1 = a1 + 1'b1;
          assert(!out1) $error ("error, memory isnt trash"); else $error ("yeah, memory is trash");
      end
      a1 = 6'b0;
      #10 a1 = 6'b001010;
      in1 = 32'b1;
      we1 = 1'b1;
      #10 clk = 1;
      #10 clk = 0;
      #10 a1 = 6'b0;
      for(w = 0; w < 64;w++)
      begin
        if(a1 == 6'b001010)
          begin
            assert(out1 == 32'b1) $error("Yeah, 10 slovo is 1"); else $error("Guess it's error");
          end
          assert(!out1 && a1 != 6'b001010) $error ("error, memory isnt trash"); else $error ("yeah, memory is trash");
      end
  end  
endmodule