module alu (
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [ 3:0] funct,
    output reg  [31:0] o
);

  wire [31:0] add_res;
  wire [31:0] sll_res;
  wire [31:0] slt_res;
  wire [31:0] sltu_res;
  wire [31:0] srl_res;

  adder adder0 (
      .a  (a),
      .b  (b),
      .sub(funct[3]),
      .o  (add_res)
  );

  l_shifter sller0 (
      .a(a),
      .b(b[4:0]),
      .o(sll_res)
  );

  s_cmper slter0 (
      .a(a),
      .b(b),
      .o(slt_res)
  );

  u_cmper sltuer0 (
      .a(a),
      .b(b),
      .o(sltu_res)
  );

  r_shifter srler0 (
      .a(a),
      .b(b[4:0]),
      .arith(funct[3]),
      .o(srl_res)
  );

  always @(*) begin
    case (funct[2:0])
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

endmodule
