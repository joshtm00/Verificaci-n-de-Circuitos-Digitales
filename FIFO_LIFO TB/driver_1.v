//Init task for clean output signals

//
// Task for the Reset
//       __    __    __   
//clk __|  |__|  |__|  |__
//
//          _____
//reset____|     |________ 
//

task drv_init;
  begin
    @(posedge Wclk)
      reset = 1;
    @(posedge Wclk)
      reset = 0;
    @(posedge Wclk)
      reset = 0;
  end
endtask

//Drive request to the arbiter
task write_request;

input integer iteration;

  repeat (iteration) begin  
    @(posedge Wclk) begin
        Datain = $random;
        Wren = $random;
    end
  end
endtask

//Drive request to the arbiter
task read_request;

input integer iteration;

  repeat (iteration) begin  
    @(posedge Rclk) begin
        Rden = $random;;
    end
  end
endtask

