module inst_mem (
    input wire [31:0] addr,
    input wire clk,
    output reg [31:0] inst
);

  reg [31:0] mem[16];

  initial begin
    $readmemh("../memory/rom.mem", mem);
  end

  always @(posedge clk) begin
    inst[31:0] <= mem[addr>>2];
  end

endmodule
