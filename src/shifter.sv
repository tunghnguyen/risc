module shifter #(
    parameter WIDTH = 32,
    parameter SHIFT = $clog2(WIDTH)
) (
    input wire [WIDTH-1:0] a,
    input wire [SHIFT-1:0] b,
    input wire dir,
    output reg [WIDTH-1:0] o
);

  always @(*) begin
    o = a;
    if (dir) begin  // shift right
      if (b[0]) o = {1'b0, o[WIDTH-1:1]};
      if (b[1]) o = {2'b0, o[WIDTH-1:2]};
      if (b[2]) o = {4'b0, o[WIDTH-1:4]};
      if (b[3]) o = {8'b0, o[WIDTH-1:8]};
      if (b[4]) o = {16'b0, o[WIDTH-1:16]};
    end else begin  // shift left
      if (b[0]) o = {o[WIDTH-1-1:0], 1'b0};
      if (b[1]) o = {o[WIDTH-2-1:0], 2'b0};
      if (b[2]) o = {o[WIDTH-4-1:0], 4'b0};
      if (b[3]) o = {o[WIDTH-8-1:0], 8'b0};
      if (b[4]) o = {o[WIDTH-16-1:0], 16'b0};
    end
  end

endmodule
