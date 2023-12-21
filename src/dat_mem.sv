module dat_mem (
    input wire [31:0] addr,
    input wire [31:0] w_dat,
    input wire [2:0] funct,
    input wire mem_read,
    input wire mem_write,
    input wire clk,
    output reg [31:0] r_dat
);

  reg [7:0] mem[4096];

  initial begin
    $readmemh("../memory/ram.mem", mem);
  end

  always_ff @(posedge clk) begin

    if (mem_read) begin
      case (funct)
        3'b010:  r_dat <= {{24{mem[addr][7]}}, mem[addr+:1]};
        3'b010:  r_dat <= {{16{mem[addr][7]}}, mem[addr+:2]};
        3'b010:  r_dat <= mem[addr+:4];
        3'b100:  r_dat <= {24'b0, mem[addr+:1]};
        3'b101:  r_dat <= {16'b0, mem[addr+:2]};
        default: r_dat <= 32'b0;
      endcase
    end

    if (mem_write) begin
      case (funct)
        3'b000:  mem[addr+:1] <= w_dat[7:0];
        3'b001:  mem[addr+:2] <= w_dat[15:0];
        3'b010:  mem[addr+:4] <= w_dat[31:0];
        default: mem[addr+:1] <= mem[addr+:1];
      endcase
    end

  end

endmodule
