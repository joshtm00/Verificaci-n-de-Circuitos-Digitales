`include "stack.v"


module scoreboard_fifolifo #(parameter MODE=1'b1, parameter dat_width=32, parameter L=6, parameter DEPTH=64) 
(	input   [dat_width-1:0] Datain,
	input   Wren,
	input   Rden, 
	input   Wrclk,   
	input   Rdclk,   
	input   Rst,
	output  reg [dat_width-1:0] Dataout
);   
	wire [dat_width-1:0] StackOut;
	
	//In Stack Mode, the module Output is the stack output
	always @(Wrclk) begin :Stack
		if(MODE == 0)begin
			Dataout <= StackOut;
		end
	end


/*	reg [dat_width:0] fifo_ram[0:DEPTH-1];
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
*/
 
 
 //Stack Instantiation
   Stack #( 
        .WIDTH(dat_width),
        .DEPTH(DEPTH)
    ) 
	 stack(
         .clk (Wrclk),
        	.reset (Rst),
        	.q (StackOut),
        	.d (Datain),
        	.push (Wren),
        	.pop (Rden)
    );

endmodule
