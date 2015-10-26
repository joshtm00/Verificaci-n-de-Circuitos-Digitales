//Init task for clean output signals
task drv_init;
  begin
    @(negedge clk)
      reset = 1;
    @(negedge clk)
      reset = 0;
    @(negedge clk)
      reset = 0;
  end
endtask

//Drive request to the arbiter
task drv_request;

input integer iteration;

  repeat (iteration) begin  
    @(negedge clk) begin
        req0 = $random;
        req1 = $random;
    end
  end
endtask


