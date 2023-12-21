module cmper (
    input  wire [31:0] a,
    input  wire [31:0] b,
    output reg  [31:0] o,
    output reg  [31:0] uo
);

  wire [31:0] sub_res;

  adder adder0 (
      .a  (a),
      .b  (b),
      .sub(1'b1),
      .o  (sub_res)
  );

  always_comb begin
    o = {31'b0, sub_res[31]};
    if (a[31] ~^ b[31]) uo = {31'b0, sub_res[31]};
    else uo = {31'b0, b[31]};
  end

endmodule
