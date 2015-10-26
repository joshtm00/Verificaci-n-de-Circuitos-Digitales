// Testbench Code Goes here
`include "scoreboard.v"

module LIFOFIFO_tb(    output reg [32-1:0]  Datain,
			output reg	      Wren,
			output reg	      Rden,
			output reg	      Rst);

input Wclk,Rclk;


`include "driver.v"
`include "checker.v"

parameter ITERATIONS = 100;
integer log;

initial begin

  $dumpfile("test.vcd");
  $dumpvars(0);

  log = $fopen("tb.log");
  $fdisplay(log, "time=%5d, Simulation Start", $time);
  $fdisplay(log, "time=%5d, Starting Reset", $time);

  drv_init();

  $fdisplay(log, "time=%5d, Reset Completed", $time);

  $fdisplay(log, "time=%5d, Starting Test", $time);
  
  //Hilo de ejecucion paralelo con fork 
  fork
    write_request(ITERATIONS);
    read_request(ITERATIONS);
    checker(ITERATIONS);
  join

  $fdisplay(log, "time=%5d, Test Completed", $time);
  $fdisplay(log, "time=%5d, Simulation Completed", $time);
  $fclose(log);
  #200 $finish;
end

scoreboard sb(
.clk (clk),
.req0 (req0),
.req1 (req1)
);

endmodule
