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
    dot = 0;
    a = 4'b0000; #10;
    a = 4'b0001; #10;
    a = 4'b0010; #10;
    a = 4'b0011; #10;
    a = 4'b0100; #10;
    a = 4'b0101; #10;
    a = 4'b0110; #10;
    a = 4'b0111; #10;
    a = 4'b1000; #10;
    a = 4'b1001; #10;
end
endmodule
