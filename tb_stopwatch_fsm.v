`timescale 1ns/1ps

module tb_stopwatch_fsm();

reg clk, start, hard_reset, soft_reset;
wire [1:0] en;

parameter T0 = 2'b00;  // base
parameter T1 = 2'b01; // count up
parameter T2 = 2'b10; // stop

stopwatch_fsm U0(
    .clk(clk), .start(start), .hard_reset(hard_reset), .soft_reset(soft_reset),
    .en(en)
);
parameter clk_period = 20;
always begin
    clk = 0;
    forever #(clk_period/2) clk = ~clk;
end

initial begin
  hard_reset = 1; soft_reset =1; start = 0; #100 //셋다 안눌림 = en==00
  hard_reset = 1; soft_reset =1; start = 1; #100 //스타트만 눌림 en==01
  hard_reset = 0; soft_reset =1; start = 0; #100 //하드리셋 눌림 en=00
  hard_reset = 1; soft_reset =1; start = 1; #100 //스타트만 눌림 en==01
  hard_reset = 1; soft_reset =0; start = 0; #100; //소프트만 눌림 en == 00
  

end

endmodule

//1us = 1000ns

