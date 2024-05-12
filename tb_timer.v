`timescale 1ns/100ps

module tb_timer();

reg clk, hard_reset, soft_reset;
reg [18:0] sec_count;
wire [3:0] d,e,f,g,h,i;


timer U0(
    .clk(clk), .hard_reset(hard_reset), .soft_reset(soft_reset),
    .sec_count(sec_count), .d(d), .e(e), .f(f), .g(g), .h(h), .i(i)
);
parameter clk_period = 20;
always begin
    clk = 0;
    forever #(clk_period/2) clk = ~clk;
end
always begin 
    sec_count = 0;
    forever #(clk_period) sec_count <= sec_count + 19'd1;
    end
initial begin
  hard_reset = 1; soft_reset =1;  #100 //둘다 안눌림 = en==00
  
  hard_reset = 0; soft_reset =1;  #100 //하드리셋 눌림 en=00
  
  hard_reset = 1; soft_reset =0;  #100 //소프트만 눌림 en == 00
  
  hard_reset = 1; soft_reset =1;  #100; //둘다 안눌림 = en==00


end

endmodule

//1us = 1000ns

