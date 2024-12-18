module test_mem32x2();
	logic clk;
	logic twriteenable;
	logic twd;
	logic [4:0] tdataadr1;
	logic [4:0] tdataadr2;
	logic [31:0] treaddata2;

mem32x2 memtestx2 (clk, twriteenable, twd, tdataadr1, tdataadr2, treaddata2);

	assign tdataadr1 = 2;
	assign tdataadr2 = 4;
	assign twriteenable = 1;
	

always_comb begin
	$display("%h",treaddata2);
end
always begin
clk <= 1; #5; clk<=0; #5;
end


endmodule

