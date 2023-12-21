module pc (
    input wire [31:0] imm,
    input wire clk,
    output reg [31:0] o
);

  always @(posedge clk) begin
    o <= imm;
  end

endmodule
