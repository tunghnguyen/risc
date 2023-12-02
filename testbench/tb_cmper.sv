module tb_cmper;

  reg  [31:0] a;
  reg  [31:0] b;
  wire [31:0] o;

  s_cmper dut (
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
      #(20) a <= $random % 50;
      b <= $random % 50;
    end
  endtask

  initial begin
    init();
    test();
  end

endmodule
