`timescale 1ns/1ps

module tb_sec_counter();

reg clk, hard_reset;
reg [1:0] en;

wire [18:0] sec_count;
// 상태 매개변수
parameter T0=2'b00; // 카운터 리셋
parameter T1=2'b01; // 카운터 증가
parameter T2=2'b10; // 카운터 유지

sec_counter U0(
    .clk(clk), .hard_reset(hard_reset), .en(en), .sec_count(sec_count)
);
parameter clk_period = 20;
always begin
    clk = 0;
    forever #(clk_period/2) clk = ~clk;
end

initial begin
  hard_reset = 0; #10;
  hard_reset = 1; 

end
initial begin
  
  en = T0; #15
  en = T1; #300
  en = T2; #300
  en = T0; #300;
end
endmodule

//1us = 1000ns
