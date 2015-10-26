`include "stack.v"


module scoreboard_fifolifo # (parameter MODE=1, parameter DEPTH=64, parameter dat_width=32) (

	input [dat_width-1:0] data_in,
	input	 		      Wren;
	input 			      Rden; 
	input 			      Wrclk;   
	input 		    	  Rdclk;   
	input	 	          Rst;
    output reg [dat_width-1:0]  DataOut;
);



	reg [dat_width:0] fifo_ram[0:DEPTH-1];
	reg [5:0] rd_ptr, wr_ptr;


	always @( * ) 
		begin
		
		if (MODE == 1) begin
			if(wr && !rd) begin
				fifo_ram[wr_ptr] = data_in;
				wr = wr+1;
				rd = rd;
			end
			else if(wr && rd) begin
				fifo_ram[wr_ptr] = data_in;
				data_out = fifo_ram[rd_ptr];
				wr = wr+1;
				rd = rd+1;
			end
			else if(rd && !wr) begin
				data_out = fifo_ram[rd_ptr];
				wr = wr;
				rd = rd+1;
			end
		end
	end

	always @( posedge clk ) 
		begin
		
		if (MODE==0) begin
			if( rst ) 
			  begin 
				wr_ptr <= 0; 
				rd_ptr <= 0;
			  end 
		end
	end

    Stack #( 
        .WIDTH(dat_width)
        .DEPTH(DEPTH)
    ) stack(
            .CLK (clock),
        	.reset (Rst),
        	.q (data_in),
        	.d (DataOut),
        	.push (Wren),
        	.pop (Rden)
    );

endmodule
