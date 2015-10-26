module ram (dat_i, dat_o, adr_wr_i, adr_rd_i, we_i, rde_i, clk );

   parameter dat_width = 32;
   parameter adr_width = 6;
   parameter mem_size  = 64;
   
   input [dat_width-1:0]      dat_i;
   input [adr_width-1:0]      adr_rd_i;
   input [adr_width-1:0]      adr_wr_i;
   input 		      we_i;
   input 		      rde_i; 
   output reg [dat_width-1:0] dat_o;
   input 		      clk;   
  
   reg [dat_width-1:0] ram [0:mem_size - 1]; 
   
   always @ (posedge clk)
     begin 
       	if (we_i)
	  ram[adr_wr_i] <= dat_i;
     end 

   always @ (posedge clk)
     begin 
        if (rde_i)
	  dat_o <= ram[adr_rd_i];
     end
endmodule 
