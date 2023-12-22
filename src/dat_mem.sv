module dat_mem (
    input wire [31:0] addr,
    input wire [31:0] w_dat,
    input wire [2:0] dat_op,
    input wire mem_read,
    input wire mem_write,
    input wire clk,
    output reg [31:0] r_dat
);

  reg [31:0] mem[32];

  initial begin
    $readmemh("../memory/ram.mem", mem);
  end

  assign r_dat = mem_read ? mem[addr>>2] : 32'b0;

  always @(posedge clk) begin
    if (mem_write) begin
      mem[addr>>2] <= w_dat;
    end
  end

endmodule
