module pc (
    input wire [31:0] imm,
    input wire clk,
    output reg [31:0] o
);

  initial o = 32'b0;

  always @(posedge clk) begin
    o <= imm;
  end

endmodule
