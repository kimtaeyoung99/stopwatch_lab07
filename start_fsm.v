// start_fsm 모듈은 외부 start 신호에 반응하여 내부 타이머를 기반으로 새로운 시작 신호를 생성
module start_fsm(
    clk,        // 클럭 신호 입력
    start,      // 외부에서 받은 시작 신호 입력
    new_start   // 새로운 시작 신호 출력
);

input clk;         // 시스템 클럭 입력
input start;       // 시작 신호 입력. 이 신호가 활성화될 때 내부 로직이 초기화
output reg new_start; // 새로운 시작 신호를 출력할 레지스터
reg [18:0] count;     // 19비트 카운터, 시간 지연을 계산하기 위해 사용

reg s;             // 내부 상태를 저장하는 레지스터. 타이머 활성화 상태를 나타냄

// 클럭의 상승 에지마다 이 블록의 로직이 실행
always @ (posedge clk) begin
    if (start) begin
        count <= 1'b0;          // 시작 신호가 활성화되면 카운터를 0으로 초기화
        s <= 1'b1;              // 내부 상태 s를 활성화(1)로 설정
        new_start <= 1'b0;      // 새 시작 신호를 0으로 초기화
    end
    else count <= count + 1'b1; // 시작 신호가 비활성화된 경우, 카운터를 증가시킵니다.

    if ((count == 19'd50000) & s) new_start <= 1;  // 카운터가 50000에 도달하고 s가 활성화된 상태면 new_start를 1로 설정
    else if (count == 19'd100000) s <= 1'b0;       // 카운터가 100000에 도달하면 s를 비활성화(0)로 설정
    else new_start <= 0;                           // 위 조건에 해당하지 않는 경우, new_start를 0으로 유지
end

endmodule

