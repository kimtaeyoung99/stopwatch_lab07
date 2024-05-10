module dp_fsm(
clk, hard_reset, dot,
dp_count, // count value
a, // segment data in
seg_sel, // segment select
d, e, f, g, h, i); // 세그먼트 각 데이터 입력

input clk;
input hard_reset;
input [9:0] dp_count;
input [3:0] d;
input [3:0] e;
input [3:0] f;
input [3:0] g;
input [3:0] h;
input [3:0] i;
output reg [3:0] a;
output reg [5:0] seg_sel;
output reg dot;

reg [2:0] state, next_state;
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

// 상태 레지스터: 클록 또는 하드 리셋 신호에 대한 반응
always @ (posedge clk or negedge hard_reset) begin
  if (~hard_reset) state <= S5; // 하드 리셋 시 가장 오른쪽 세그먼트만 활성화
  else state <= next_state;
end

// next state logic
always @ (state or dp_count) begin
  case (state)
    S0: if (dp_count==10'h3FF) next_state=S1;
        else next_state=S0;
    S1: if (dp_count==10'h3FF) next_state=S2;
        else next_state=S1;
    S2: if (dp_count==10'h3FF) next_state=S3;
        else next_state=S2;
    S3: if (dp_count==10'h3FF) next_state=S4;
        else next_state=S3;
    S4: if (dp_count==10'h3FF) next_state=S5;
        else next_state=S4;
    S5: if (dp_count==10'h3FF) next_state=S0;
        else next_state=S5;
    default: next_state=S0;
  endcase
end

// output logic
always @ (state) begin
  if (state==S0) begin
    a=i;
    dot=0;
    seg_sel = seg_sel0;
  end
  else if (state==S1) begin
    a=h;
    dot=1;
    seg_sel = seg_sel1;
  end
  else if (state==S2) begin
    a=g;
    dot=0;
    seg_sel = seg_sel2;
  end
  else if (state==S3) begin
    a=f;
    dot=1;
    seg_sel = seg_sel3;
  end
  else if (state==S4) begin
    a=e;
    dot=0;
    seg_sel = seg_sel4;
  end
  else if (state==S5) begin
    a=d;
    dot=0;
    seg_sel = seg_sel5;
  end
end

endmodule



