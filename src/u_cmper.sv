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

  assign o = {31'b0, sub_res[31]};

endmodule
