//Joshua Toores Morales A76478
// joshtm00@gmail.com
// MODO = 1 FIFO
// MODO = 0 LIFO
`include "ram.v"
module DUT # (parameter MODE=1'b1) (Datain, Dataout, Wren, Rden, Wrclk, Rdclk, Full, Empty, Rst);

	input [dat_width-1:0]      Datain;
	input 		      Wren;
	input 		      Rden; 
	input 		      Wrclk;   
	input 		      Rdclk;   
	input			  Rst;
	output reg [dat_width-1:0]  Dataout;
	output  		  Full;
	output  		  Empty;
	   
	   
	wire [dat_width-1:0] data_ram;
	
	parameter L = 6;
	parameter DEPTH  = 64;
	parameter dat_width = 32;
	  
	//Punteros de escritura y lectura
	reg [L-1:0]      adr_rd_i;
	reg [L-1:0]      adr_wr_i;
   
    //-----------Asignaciones para full y empty---------------
	assign Full = (status_cnt == (DEPTH-1));
	assign Empty = (status_cnt == 0);
  
	reg [L-1:0] status_cnt; //Variable para contar datos en la memoria
	
	
	wire CLK;
	
	//Esto es para decidir cual reloj usar dependiedo del modo
	assign CLK = (MODE == 1'b1 && Rden == 1 )? Rdclk : Wrclk; 


	//Manejo del puntero de escritura
	always @ (posedge Wrclk or posedge Rst)
		begin : WRITE_POINTER
			 if (Rst) begin
				adr_wr_i <= 0;
		end else if (Wrclk && Wren) begin
				adr_wr_i <= adr_wr_i + 1;
		end 
	end
	
	//Manejo del puntero de lectura
	always @ (posedge CLK or posedge Rst)
		begin : READ_POINTER
			if (Rst) begin
				adr_rd_i <= 0;
			end else if (Rden && (MODE == 1'b1) ) begin
				adr_rd_i <= adr_rd_i + 1;
			end else if (Rden && (MODE == 1'b0) ) begin
				adr_rd_i = adr_wr_i - 1;
				adr_wr_i = adr_wr_i - 1;
			end
	end
	
	//Se optiene el dato de memoria
	always  @ (posedge CLK or posedge Rst )
		begin : READ_DATA
			if (Rst) begin
				Dataout <= 0;
			end else if (Rden) begin
				Dataout <= data_ram;
			end 
	end
	
	
	always @ (posedge CLK or posedge Rst)
	  begin : STATUS_COUNTER
		 if (Rst) begin
		   status_cnt <= 0;
		 // Leectura pero no escritura. MODO FIFO
		 end else if (Rden &&  !(Wren) && (status_cnt  != 0) && (MODE == 1'b1)) begin
		   status_cnt <= status_cnt - 1;
		 //Lectura pero no escritura en modo LIFO
		 end else if (Rden &&  !(Wren) && (status_cnt  != 0) && (MODE == 1'b0)) begin
		 // Escritura pero no lectura. AMBOS MODOS
		 end else if (Wren &&  !(Rden) && (status_cnt  != DEPTH)) begin
		   status_cnt <= status_cnt + 1;
		 end
	end 
	
	
	//Instancia de memoria RAM como buffer de almacenamiento
	ram RAM  (.dat_i(Datain), 
			.dat_o(data_ram), 
			.adr_wr_i(adr_wr_i), 
			.adr_rd_i(adr_rd_i), 
			.we_i(Wren), 
			.rde_i(Rden), 
			.clk(CLK)
			);
endmodule 
