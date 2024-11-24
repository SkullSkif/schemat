module testbench();
logic clk, writeenable;
logic [31:0] writedata, readdata;
logic [5:0] dataadr;

// instantiate device to be tested
dmem memtest (clk, writeenable, dataadr, writedata,
readdata);
//initialize test
initial begin
	writeenable =1;
#10
	writedata = 6'b101011;
#10
	writeenable = 0;
end

//generate clock to sequenc tests
always begin
clk <= 1; #5; clk<=0; #5;
end

//check results
always @ (negedge clk) begin
	for (int i = 0; i < 5;i++) begin
		dataadr <= i;
		$display ("%b", readdata);
		if (readdata != 0) begin
			$display("mem isn't trash");
			$stop;	
		end
	end
end
endmodule
