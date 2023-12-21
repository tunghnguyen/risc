module risc (
    input wire clk
);

  wire [31:0] i_pc;
  wire [31:0] o_pc;

  pc pc0 (
      .imm(i_pc),
      .clk(clk),
      .o  (o_pc)
  );

  wire [31:0] o_adder0;

  adder adder0 (
      .a  (o_pc),
      .b  (32'h4),
      .sub(1'b0),
      .o  (o_adder0)
  );

  wire [31:0] inst;

  inst_mem inst_mem0 (
      .addr(o_pc),
      .clk (clk),
      .inst(inst)
  );

  wire [31:0] imm;
  wire [3:0] alu_op;
  wire [2:0] dat_op;
  wire alu_src;
  wire mem_to_reg;
  wire reg_write;
  wire mem_read;
  wire mem_write;
  wire branch;
  wire branch_ne;

  decoder decoder0 (
      .inst(inst),
      .imm(imm),
      .alu_op(alu_op),
      .dat_op(dat_op),
      .alu_src(alu_src),
      .mem_to_reg(mem_to_reg),
      .reg_write(reg_write),
      .mem_read(mem_read),
      .mem_write(mem_write),
      .branch(branch),
      .branch_ne(branch_ne)
  );

  wire [31:0] o_adder1;

  adder adder1 (
      .a  (o_pc),
      .b  (imm),
      .sub(1'b0),
      .o  (o_adder1)
  );

  wire [31:0] r_dat0;
  wire [31:0] r_dat1;
  wire [31:0] w_dat0;

  registers registers0 (
      .r_reg0(inst[19:15]),
      .r_reg1(inst[24:20]),
      .w_reg(inst[11:7]),
      .w_dat(w_dat0),
      .write(reg_write),
      .clk(clk),
      .r_dat0(r_dat0),
      .r_dat1(r_dat1)
  );

  wire [31:0] o_mux0;

  assign o_mux0 = alu_src ? imm : r_dat1;

  wire [31:0] o_alu;
  wire zero;

  alu alu0 (
      .a(r_dat0),
      .b(o_mux0),
      .alu_op(alu_op),
      .o(o_alu),
      .zero(zero)
  );

  wire o_mux1;

  assign o_mux1 = branch_ne ? ~zero : zero;

  assign i_pc   = branch & o_mux1 ? o_adder1 : o_adder0;

  wire [31:0] r_dat2;

  dat_mem dat_mem0 (
      .addr(o_alu),
      .w_dat(r_dat1),
      .dat_op(dat_op),
      .mem_read(mem_read),
      .mem_write(mem_write),
      .clk(clk),
      .r_dat(r_dat2)
  );

  assign w_dat0 = mem_to_reg ? r_dat2 : o_alu;

endmodule
