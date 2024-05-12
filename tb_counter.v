`timescale 1ns/1ps
module tb_counter();

reg clk, hard_reset;
wire [9:0] dp_count;

parameter clk_period = 20; // 50MHz 1/20ns = 50M

counter U0( //10 bit count
            .clk(clk),
            .hard_reset(hard_reset),
            .dp_count(dp_count)); //10 bit count

initial begin
    hard_reset = 1;
    #13 hard_reset = 0;
    #(clk_period) hard_reset = 1;
    #100 hard_reset = 0;
end

always begin //clock signal generation
    clk = 0;
    forever #(clk_period/2) clk = ~clk;
end
endmodule