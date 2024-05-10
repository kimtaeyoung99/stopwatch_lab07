module sec_counter(
            clk,
            hard_reset,
            sec_count,
            en);
            
input clk;
input hard_reset;
input [1:0] en; // 카운터 제어를 위한 2비트 입력

output reg [18:0] sec_count; // 19비트 카운터

// 상태 매개변수
parameter T0=2'b00; // 카운터 리셋
parameter T1=2'b01; // 카운터 증가
parameter T2=2'b10; // 카운터 유지

// 클록 또는 하드 리셋에 반응하는 always 블록
always @ (posedge clk or negedge hard_reset) 
begin
    if (~hard_reset) 
        sec_count <= 0; // 하드 리셋 시 카운터를 0으로 초기화
    else begin 
        if(en == T0) 
            sec_count <= 0; // en이 T0일 경우 카운터 리셋
        else begin
            if(en == T1) 
                sec_count <= sec_count + 19'd1; // en이 T1일 경우 카운터 증가
            else begin
                if (en == T2) 
                    sec_count <= sec_count; // en이 T2일 경우 카운터 유지
                if(sec_count == 19'd499_999) 
                    sec_count <= 0; // 카운터가 499,999에 도달하면 리셋
            end
        end
    end
end
endmodule