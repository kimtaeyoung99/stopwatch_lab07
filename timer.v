// timer 모듈은 50 MHz 클럭에서 동작하는 타이머로, 분, 초, 및 1/100초를 계산하여 표현.
module timer(
    clk,          // 클럭 신호
    hard_reset,   // 하드 리셋 신호
    sec_count,    // 1/100초를 계산하기 위한 카운터
    soft_reset,   // 소프트 리셋 신호
    d, e, f, g, h, i  // 각 시간 세그먼트 출력
);

input clk;               // 클럭 입력
input hard_reset;        // 하드 리셋 입력
input [18:0] sec_count;  // 1/100초 카운터 입력
input soft_reset;        // 소프트 리셋 입력

output reg [3:0] d;      // 1/100초 (하위 자리)
output reg [3:0] e;      // 1/100초 (상위 자리)
output reg [3:0] f;      // 초 (하위 자리)
output reg [3:0] g;      // 초 (상위 자리)
output reg [3:0] h;      // 분 (하위 자리)
output reg [3:0] i;      // 분 (상위 자리)

// 1/100초 하위 자리 세그먼트 관리
always@(posedge clk or negedge hard_reset) begin
    if (~hard_reset)  d <= 4'd0;  // 하드 리셋 시 초기화
    else begin 
        if ((d == 4'd10) || ~soft_reset) d <= 4'd0;  // 10에 도달하거나 소프트 리셋 시 초기화
        else if(sec_count == 19'd499_999) d <= d + 4'd1;  // 1/100초 마다 증가
    end
end

// 1/100초 상위 자리 세그먼트 관리
always@(posedge clk or negedge hard_reset) begin
    if (~hard_reset)  e <= 4'd0;
    else begin 
        if ((e == 4'd10) || ~soft_reset) e <= 4'd0;
        else if(d == 4'd10) e <= e + 4'd1;  // 하위 자리가 10에 도달할 때 마다 증가
    end
end

// 초 하위 자리 세그먼트 관리
always@(posedge clk or negedge hard_reset) begin
    if (~hard_reset)  f <= 4'd0;
    else begin 
        if ((f == 4'd10) || ~soft_reset) f <= 4'd0;
        else if(e == 4'd10) f <= f + 4'd1;  // 1/100초 상위 자리가 10에 도달할 때 마다 증가
    end
end

// 초 상위 자리 세그먼트 관리
always@(posedge clk or negedge hard_reset) begin
    if (~hard_reset)  g <= 4'd0;
    else begin 
        if ((g == 4'd6) || ~soft_reset) g <= 4'd0;  // 60초에 리셋
        else if(f == 4'd10) g <= g + 4'd1;  // 초 하위 자리가 10에 도달할 때 마다 증가
    end
end

// 분 하위 자리 세그먼트 관리
always@(posedge clk or negedge hard_reset) begin
    if (~hard_reset)  h <= 4'd0;
    else begin 
        if ((h == 4'd10) || ~soft_reset) h <= 4'd0;
        else if(g == 4'd6) h <= h + 4'd1;  // 60초에 도달할 때 마다 증가
    end
end

// 분 상위 자리 세그먼트 관리
always@(posedge clk or negedge hard_reset) begin
    if (~hard_reset)  i <= 5'd0;
    else begin 
        if ((i == 4'd6) || ~soft_reset) i <= 4'd0;  // 60분에 리셋
        else if(h == 4'd10) i <= i + 4'd1;  // 분 하위 자리가 10에 도달할 때 마다 증가
    end
end

endmodule
