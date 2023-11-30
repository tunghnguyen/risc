module r_shifter (
    input wire [31:0] a,
    input wire [4:0] b,
    input wire arith,
    output reg [31:0] o
);

  always @(*) begin
    o = a;
    if (arith) begin  // arithmetic
      if (b[0]) o = {{1{a[31]}}, o[31:1]};
      if (b[1]) o = {{2{a[31]}}, o[31:2]};
      if (b[2]) o = {{4{a[31]}}, o[31:4]};
      if (b[3]) o = {{8{a[31]}}, o[31:8]};
      if (b[4]) o = {{16{a[31]}}, o[31:16]};
    end else begin  // logical
      if (b[0]) o = {1'b0, o[31:1]};
      if (b[1]) o = {2'b0, o[31:2]};
      if (b[2]) o = {4'b0, o[31:4]};
      if (b[3]) o = {8'b0, o[31:8]};
      if (b[4]) o = {16'b0, o[31:16]};
    end
  end

endmodule
