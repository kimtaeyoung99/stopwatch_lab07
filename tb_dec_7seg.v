`timescale 1ns/10ps

module tb_dec_7seg();

reg [3:0] a;
reg dot;

wire [7:0] seg;

dec_7seg U0(
    .a(a),
    .dot(dot),
    .seg(seg)
);

initial begin
    // a의 초기 값 설정 및 dot의 초기 상태
    a = 4'b0000; 
    dot = 0; #10;

    // a값을 0부터 15까지 증가시키면서 각 경우에 대해 테스트
    repeat (16) begin
        #10; a = a + 1;
    end

    // a 값 테스트 후 dot의 상태를 변경하여 같은 테스트 반복
    a = 4'b0000; // a를 다시 0으로 초기화
    dot = 1; #10; // dot 신호 활성화

    repeat (16) begin
        #10; a = a + 1;
    end

end
endmodule
