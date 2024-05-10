module seg_controller(
                      clk, hard_reset,
                      d, e, f, g, h, i,
                      seg, // data to segment
                      seg_sel); // segment select

input clk;
input hard_reset;
input [3:0] d;
input [3:0] e;
input [3:0] f;
input [3:0] g;
input [3:0] h;
input [3:0] i;
output [7:0] seg;
output [5:0] seg_sel;
wire [9:0] dp_count;
wire [3:0] a;
wire dot;

// 10비트 카운터 모듈 인스턴스
counter U1_counter(
                  .clk(clk), // 클록 신호 입력
                  .hard_reset(hard_reset), // 하드 리셋 입력
                  .dp_count(dp_count)); // 10비트 카운트 출력

dp_fsm U0_dp_fsm(
          .clk(clk), .hard_reset(hard_reset), .dot(dot),
          .dp_count(dp_count), .d(d), .e(e), .f(f), .g(g), .h(h), .i(i),
			 .a(a), .seg_sel(seg_sel));

// 7-segment 디코더 모듈 인스턴스
dec_7seg U2_dec_7seg(
                    .a(a), // 4비트 데이터 입력
                    .dot(dot), // 도트 제어 입력
                    .seg(seg)); // 7-segment 디스플레이 출력

endmodule

