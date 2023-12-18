module tb_registers;

  reg [4:0] r_reg0;
  reg [4:0] r_reg1;
  reg [4:0] w_reg;
  reg [31:0] w_dat;
  reg write;
  reg clk;
  reg [31:0] r_dat0;
  reg [31:0] r_dat1;

  registers dut (
      .r_reg0(r_reg0),
      .r_reg1(r_reg1),
      .w_reg(w_reg),
      .w_dat(w_dat),
      .write(write),
      .clk(clk),
      .r_dat0(r_dat0),
      .r_dat1(r_dat1)
  );

  function void init();
    r_reg0 = 0;
    r_reg1 = 0;
    w_reg = 0;
    w_dat = 0;
    write = 1;
    clk = 0;
  endfunction

  task test();
    for (int i = 0; i < 32; ++i) begin
      #(20) w_reg <= i;
      w_dat <= $urandom % 100;
    end

    repeat (50) begin
      #(20) write <= 0;
      r_reg0 <= $urandom % 31;
      r_reg1 <= $urandom % 31;
    end
  endtask

  always #(10) clk = ~clk;

  initial begin
    init();
    test();
  end

endmodule
