module u_cmper (
    input  wire [31:0] a,
    input  wire [31:0] b,
    output reg  [31:0] o
);

  wire [31:0] sub_res;

  adder adder0 (
      .a  (a),
      .b  (b),
      .sub(1'b1),
      .o  (sub_res)
  );

  always @(*) begin
    if (a[31] == b[31]) o = {31'b0, sub_res[31]};
    else o = {31'b0, (a[31] == 1'b0) ? 1'b1 : 1'b0};
  end

endmodule
