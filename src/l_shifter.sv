module l_shifter (
    input  wire [31:0] a,
    input  wire [ 4:0] b,
    output reg  [31:0] o
);

  always_comb begin
    o = a;
    if (b[0]) o = {o[31-1:0], 1'b0};
    if (b[1]) o = {o[31-2:0], 2'b0};
    if (b[2]) o = {o[31-4:0], 4'b0};
    if (b[3]) o = {o[31-8:0], 8'b0};
    if (b[4]) o = {o[31-16:0], 16'b0};
  end

endmodule
