// Testbench Code Goes here
`include "scoreboard.v"

module arbiter_tb( reset, req0, req1, gnt0, gnt1, clk);

output reset, req0, req1;
reg    reset, req0, req1;
input  gnt0,  gnt1, clk;

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
  fork
    drv_request(ITERATIONS);  
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
