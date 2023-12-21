module inst_mem (
    input wire [31:0] addr,
    input wire clk,
    output reg [31:0] inst
);

  reg [7:0] mem[2048];

  initial begin
    $readmemh("../memory/inst.mem", mem);
  end

  always_ff @(posedge clk) begin
    inst <= mem[addr+:4];
  end

endmodule
