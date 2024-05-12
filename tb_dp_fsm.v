`timescale 1ns/1ps

module tb_dp_fsm();

reg clk, hard_reset;
reg [9:0] dp_count;
reg [3:0] d,e,f,g,h,i;

wire [3:0] a;
wire [5:0] seg_sel;
wire dot;



dp_fsm U0(
    .clk(clk), .hard_reset(hard_reset),
    .dp_count(dp_count), .d(d), .e(e), .f(f), .g(g), .h(h), .i(i),
    .a(a), .seg_sel(seg_sel), .dot(dot)
);
parameter clk_period = 20;
// 상태 정의
parameter S0=3'b000;
parameter S1=3'b001;
parameter S2=3'b010;
parameter S3=3'b011;
parameter S4=3'b100;
parameter S5=3'b101;

// 세그먼트 선택 파라미터 (왼쪽부터 오른쪽까지)
parameter seg_sel0 = 6'b100000; // left
parameter seg_sel1 = 6'b010000;
parameter seg_sel2 = 6'b001000;
parameter seg_sel3 = 6'b000100;
parameter seg_sel4 = 6'b000010;
parameter seg_sel5 = 6'b000001; // right

always begin
    clk = 0;
    forever #(clk_period/2) clk = ~clk;
end

initial begin
  hard_reset = 1; dp_count = 0;   #10 //둘다 안눌림 = en==00
  d = 4'h0; e = 4'h1; f = 4'h2; g = 4'h3; h = 4'h4; i = 4'h5;
  #100; dp_count = 10'h3FE;
  #10; dp_count = 10'h3FF;  // 상태 전이 트리거
  #100; dp_count = 10'h3FE;
  #10; dp_count = 10'h3FF;  // 상태 전이 트리거
  #100; dp_count = 10'h3FE;
  #10; dp_count = 10'h3FF;  // 상태 전이 트리거
  #100; dp_count = 10'h3FE;
  #10; dp_count = 10'h3FF;  // 상태 전이 트리거
  #100; dp_count = 10'h3FE;
  #10; dp_count = 10'h3FF;  // 상태 전이 트리거
  #100; dp_count = 10'h3FE;
  #10; dp_count = 10'h3FF;  // 상태 전이 트리거
  #100; dp_count = 10'h3FE;
  #10; dp_count = 10'h3FF;  // 상태 전이 트리거
  #100; dp_count = 10'h3FE;
  #10; dp_count = 10'h3FF;  // 상태 전이 트리거
  
  hard_reset = 0;   #10; //하드리셋 눌림 en=00
  


end

endmodule

//1us = 1000ns

