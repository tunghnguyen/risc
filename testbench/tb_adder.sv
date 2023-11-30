module tb_adder;

  reg [31:0] a;
  reg [31:0] b;
  reg sub;
  wire [31:0] o;

  adder dut (
      .a  (a),
      .b  (b),
      .sub(sub),
      .o  (o)
  );

  function void init();
    a   <= 0;
    b   <= 0;
    sub <= 0;
  endfunction

  task test();
    repeat (19) begin
      #(20) a <= $random % 50;
      b   <= $random % 50;
      sub <= $random % 2;
    end
  endtask

  initial begin
    init();
    test();
  end

endmodule
