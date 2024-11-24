module test_mem32_init();
logic clk, writeenable;
logic [31:0] writedata, readdata;
logic [4:0] dataadr;

// instantiate device to be tested
dmem_init memtest (clk, writeenable, dataadr, writedata,
readdata);
//initialize test
initial begin
	writeenable =0;

end

//generate clock to sequenc tests
always begin
clk <= 1; #5; clk<=0; #5;
end

//check results

endmodule
