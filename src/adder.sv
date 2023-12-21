module adder (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire sub,
    output reg [31:0] o
);

  wire c[32]  /*verilator split_var*/;

  full_adder fa (
      .a (a[0]),
      .b (b[0] ^ sub),
      .ci(sub),
      .o (o[0]),
      .co(c[0])
  );

  generate
    for (genvar i = 1; i < 32; i = i + 1) begin : g_adder
      full_adder fa (
          .a (a[i]),
          .b (b[i] ^ sub),
          .ci(c[i-1]),
          .o (o[i]),
          .co(c[i])
      );
    end
  endgenerate

endmodule
