module imm_gen (
    input  wire [31:0] inst,
    output reg  [31:0] imm
);

  always @(*) begin
    casez (inst[6:5])
      2'b00: imm = {{20{inst[31]}}, inst[31:20]};
      2'b01: imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
      2'b1?: imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
    endcase
  end

endmodule
