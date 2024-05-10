`timescale 1ns/1ps

module tb_start_fsm();

reg clk, start;
wire new_start;


start_fsm U0(
    .clk(clk), .start(start), .new_start(new_start)
);
parameter clk_period = 20;
always begin
    clk = 0;
    forever #(clk_period/2) clk = ~clk;
end

initial begin
  start = 1; #(clk_period*99)
  start = 0; #3000000;
  //run 10ms

end
endmodule

//1us = 1000ns
