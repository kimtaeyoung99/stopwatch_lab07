module stopwatch_fsm(
                    clk,
                    hard_reset,
                    start,
			              soft_reset,
                    en
                    );
input clk;
input hard_reset;
input start;
input soft_reset;
output reg [1:0] en;

reg [1:0] state;
reg [1:0] nextstate;

parameter T0 = 2'b00;  // base
parameter T1 = 2'b01; // count up
parameter T2 = 2'b10; // stop

// 상태 레지스터: 클록의 상승 에지 또는 하드 리셋의 하강 에지에 반응
always@(posedge clk or negedge hard_reset) begin
  if(~hard_reset) state <= T0; // 하드 리셋 시 기본 상태로 초기화
  else state <= nextstate;     // 그 외 경우에는 다음 상태로 전환
end

// 다음 상태 로직: 현재 상태와 입력 신호에 따라 다음 상태 결정
always@(state or start or soft_reset) begin
  if(~soft_reset)
    nextstate = T0; // 소프트 리셋 시 모든 세그먼트를 0으로 리셋
  else begin
    case (state)
      T0 : if (start) nextstate = T1; // T0 상태에서 시작 신호가 있으면 T1로 전환
           else nextstate = T0;
      T1 : if (start) nextstate = T2; // T1 상태에서 시작 신호가 있으면 T2로 전환
           else nextstate = T1;
      T2 : if (start) nextstate = T1; // T2 상태에서 시작 신호가 있으면 T1로 전환
           else nextstate = T2;
    default : nextstate = T0; // 정의되지 않은 상태에 대해 기본 상태로 리셋
    endcase
  end
end

// 출력 로직: 현재 상태에 따라 출력 신호(en) 결정
always@(state) begin
  case (state)
    T1 : en = T1; // 카운트 업 상태
    T2 : en = T2; // 정지 상태
    default : en = T0; // 기본 상태
  endcase 
end
endmodule

