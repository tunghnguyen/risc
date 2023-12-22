module registers (
    input wire [4:0] r_reg0,
    input wire [4:0] r_reg1,
    input wire [4:0] w_reg,
    input wire [31:0] w_dat,
    input wire write,
    input wire clk,
    output reg [31:0] r_dat0,
    output reg [31:0] r_dat1
);

  reg [31:0] regs[32];
  initial regs = '{default: '0};
  initial regs[2] = 32'd64;

  assign r_dat0 = regs[r_reg0];
  assign r_dat1 = regs[r_reg1];

  always @(posedge clk) begin
    if (write & |w_reg) regs[w_reg] <= w_dat;
  end

endmodule
