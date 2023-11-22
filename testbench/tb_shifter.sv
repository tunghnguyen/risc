module tb_shifter #(
    parameter TB_WIDTH = 32,
    parameter TB_SHIFT = $clog2(TB_WIDTH)
);

  reg [TB_WIDTH-1:0] a;
  reg [TB_SHIFT-1:0] b;
  reg dir;

  wire [TB_WIDTH-1:0] o;

  shifter #(
      .WIDTH(TB_WIDTH)
  ) dut (
      .a  (a),
      .b  (b),
      .dir(dir),
      .o  (o)
  );

  function void init();
    a <= 0;
    b <= 0;
    dir <= 0;
  endfunction

  task test();
    repeat (19) begin
      #(20)
      a <= $random % 50;
      b <= $random % 32;
      dir <= $random % 2;
    end
  endtask

  initial begin
    init();
    test();
  end

endmodule
