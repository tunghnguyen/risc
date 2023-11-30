module tb_shifter;

  reg [31:0] a;
  reg [4:0] b;
  reg arith;

  wire [31:0] o;

  r_shifter dut (
      .a(a),
      .b(b),
      .arith(arith),
      .o(o)
  );

  function void init();
    a <= 0;
    b <= 0;
    arith <= 0;
  endfunction

  task test();
    repeat (49) begin
      #(20) a <= $random % 2**31;
      b <= $random % 2**5;
      arith <= $random % 2;
    end
  endtask

  initial begin
    init();
    test();
  end

endmodule
