
`include "DUT.v"
`include "tb.v"
`include "CLK1.v"

module top;


wire  rst, wren, rden, full, empty, clk1, clk2;
wire [32-1:0] datain, datao;
tb test (
	.Datain(datain),
	.Rst(rst),
	.Wren(wren),
	.Rden(rden)

);

clock #(10) Clk1 (.clock(clk1));
clock #(5) Clk2 (.clock(clk2));


DUT #(0) dut (.Datain(datain), 
		.Dataout(datao), 
		.Wren(wren), 
		.Rden(rden), 
		.Wrclk(clk2), 
		.Rdclk(clk1), 
		.Full(full), 
		.Empty(empty), 
		.Rst(rst));




endmodule
