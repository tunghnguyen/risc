module tb_adder #(
    parameter TB_WIDTH = 32
);

  reg  [TB_WIDTH-1:0] a;
  reg  [TB_WIDTH-1:0] b;

  wire [TB_WIDTH-1:0] o;

  adder #(
      .WIDTH(TB_WIDTH)
  ) dut (
      .a(a),
      .b(b),
      .o(o)
  );

  function void init();
    a <= 0;
    b <= 0;
  endfunction

  task test();
    repeat (19) begin
      #(20)
      a <= $random % 50;
      b <= $random % 50;
    end
  endtask

  initial begin
    init();
    test();
  end

endmodule
