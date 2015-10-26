module clock #(parameter num = 10) (clock);

output reg clock;

initial
	clock = 0;

always
	begin
		#num clock = !clock; 
	end

endmodule
