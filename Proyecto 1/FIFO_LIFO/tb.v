module tb(	output reg [32-1:0]  Datain,
			output reg	      Wren,
			output reg	      Rden,
			output reg		  Rst);


	initial begin

		$dumpfile("test.vcd");
		$dumpvars(0);
		Rst = 0;
		Datain = 0;
		Wren = 0;
		Rden = 0;
		#30 Rst = 1;
		#20 Rst = 0;
		#20 Wren = 1;
		Datain = 20;
		#20 Datain = 10;
		#20 Datain = 30;
		#20 Datain = 40;
		#20 Datain = 50;
		#20 Wren = 0;
		#20 Rden = 1;
		#250 $finish;
		
	end
      
endmodule
