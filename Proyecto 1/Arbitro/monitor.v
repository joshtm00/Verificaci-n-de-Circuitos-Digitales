task monitor;

reg mon_gnt0, mon_gnt1, mon_req0, mon_req1; 

forever always (posedge clk)begin
    mon_req0 <= req0;
    mon_req1 <= req1;
    mon_gnt0 <= gnt0;
    mon_gnt1 <= gnt1;
end
 
endtask
