module tb_risc;

  reg clk;

  risc dut (.clk(clk));

  initial begin
    clk = 0;
  end

  always #(50) clk = ~clk;

endmodule
