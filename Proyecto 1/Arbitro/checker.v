task checker;

input integer iteration;

repeat (iteration) @ (posedge clk) begin
	if ({sb.sb_gnt0,sb.sb_gnt1} == {gnt0, gnt1}) begin
          //$fdisplay(log, "PASS");
        end
        else begin
          $fdisplay(log, "Time=%.0f Error dut: gnt0=%b, gnt1=%b, scoreboard: gnt0=%b, gnt1=%b", $time, gnt0, gnt1, sb.sb_gnt0,sb.sb_gnt1);
        end
end
endtask
