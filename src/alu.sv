module alu (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [3:0] alu_op,
    output reg [31:0] o,
    output reg zero
);

  wire [31:0] add_res;
  wire [31:0] sll_res;
  wire [31:0] slt_res;
  wire [31:0] sltu_res;
  wire [31:0] srl_res;

  adder adder0 (
      .a  (a),
      .b  (b),
      .sub(alu_op[3]),
      .o  (add_res)
  );

  l_shifter l_shifter0 (
      .a(a),
      .b(b[4:0]),
      .o(sll_res)
  );

  cmper cmper0 (
      .a (a),
      .b (b),
      .o (slt_res),
      .uo(sltu_res)
  );

  r_shifter r_shifter0 (
      .a(a),
      .b(b[4:0]),
      .arith(alu_op[3]),
      .o(srl_res)
  );

  always @(*) begin
    case (alu_op[2:0])
      3'h0: o = add_res;
      3'h1: o = sll_res;
      3'h2: o = slt_res;
      3'h3: o = sltu_res;
      3'h4: o = a ^ b;
      3'h5: o = srl_res;
      3'h6: o = a | b;
      3'h7: o = a & b;
    endcase
  end

  assign zero = ~|o;

endmodule
