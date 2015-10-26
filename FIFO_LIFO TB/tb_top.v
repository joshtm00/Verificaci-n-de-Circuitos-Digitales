`include "clock.v"
`include "arbiter.v"
`include "arbiter_tb.v"

module tb_top;

clk clock (.clock (clock));

arbiter_tb tb(
.reset (reset), 
.req0 (req0),
.req1 (req1),
.gnt0 (gnt0),
.gnt1 (gnt1),
.clk (clock)
);

arbiter dut (
.clock (clock),
.reset (reset),
.req_0 (req0),
.req_1 (req1),
.gnt_0 (gnt0),
.gnt_1 (gnt1)
);

endmodule





