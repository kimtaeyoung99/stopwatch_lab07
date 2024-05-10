// stopwatch_top 모듈은 스톱워치의 주요 기능을 총괄하는 최상위 모듈.
// 시간 계산, 상태 전환 및 디스플레이 출력을 관리.
module stopwatch_top(
    clk,          // 클록 신호 입력
    hard_reset,   // 하드 리셋 신호 입력
    start,        // 외부에서 제공되는 시작 신호 입력
    soft_reset,   // 소프트 리셋 신호 입력
    d, e, f, g, h, i  // 디지털 시계 출력을 위한 4비트 각 세그먼트 데이터 출력
);

input clk;
input hard_reset;
input start;
input soft_reset;

output [3:0] d;
output [3:0] e;
output [3:0] f;
output [3:0] g;
output [3:0] h;
output [3:0] i;

wire [18:0] sec_count;  // 초 카운터에서 생성된 카운트 값
wire [1:0] en;          // 스톱워치 FSM에서 제공되는 현재 상태
wire new_start;         // 시작 신호를 안정화(debounce 처리) 후 전달

// 초 카운터 모듈 인스턴스화
sec_counter U0_sec_counter(
    .clk(clk),
    .hard_reset(hard_reset),
    .en(en),
    .sec_count(sec_count)
);

// 시작 신호 안정화를 위한 start_fsm 인스턴스화
start_fsm U0_start_fsm(
    .clk(clk),
    .start(start),
    .new_start(new_start)
);

// 스톱워치의 상태 관리를 위한 stopwatch_fsm 인스턴스화
// 이 모듈은 스톱워치의 동작 상태(기본, 카운트, 정지)를 제어
stopwatch_fsm U1_stopwatch_fsm(
    .clk(clk),
    .soft_reset(soft_reset),
    .hard_reset(hard_reset),
    .start(new_start),  // 여기에서 new_start는 처리된 안정적인 시작 신호를 받음
                        // 이 신호는 start_fsm 모듈에서 스위치 바운스를 제거한 후 제공
                        // 스톱워치의 상태 전환(시작/정지/재시작)을 결정하는 데 사용
    .en(en)
);

// 시간 표시를 위한 timer 모듈 인스턴스화
timer U2_timer(
    .clk(clk),
    .hard_reset(hard_reset),
    .soft_reset(soft_reset),
    .sec_count(sec_count),
    .d(d),
    .e(e),
    .f(f),
    .g(g),
    .h(h),
    .i(i)
);

endmodule
