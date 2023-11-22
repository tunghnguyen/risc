module adder #(
    parameter WIDTH = 32
) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    output reg  [WIDTH-1:0] o
);

  wire c[WIDTH-1:0]  /*verilator split_var*/;
  genvar i;
  full_adder fa (
      .a (a[0]),
      .b (b[0]),
      .ci(1'b0),
      .o (o[0]),
      .co(c[0])
  );

  generate
    for (i = 1; i < WIDTH; i = i + 1) begin : no
      full_adder fa (
          .a (a[i]),
          .b (b[i]),
          .ci(c[i-1]),
          .o (o[i]),
          .co(c[i])
      );
    end
  endgenerate

endmodule
