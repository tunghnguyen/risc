module dat_mem (
    input wire [31:0] addr,
    input wire [31:0] w_dat,
    input wire [2:0] dat_op,
    input wire mem_read,
    input wire mem_write,
    input wire clk,
    output reg [31:0] r_dat
);

  reg [31:0] mem[16];

  initial begin
    $readmemh("../memory/ram.mem", mem);
  end

  always @(posedge clk) begin

    if (mem_read) begin
      case (dat_op)
        3'b010:  r_dat <= mem[addr>>2];
        default: r_dat <= 32'b0;
      endcase
    end

    if (mem_write) begin
      case (dat_op)
        3'b010:  mem[addr>>2] <= w_dat;
        default: ;
      endcase
    end

  end

endmodule
