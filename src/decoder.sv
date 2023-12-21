module decoder (
    input wire [31:0] inst,
    output reg [31:0] imm,
    output reg [3:0] alu_op,
    output reg alu_src,
    output reg mem_to_reg,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg branch_ne
);

  reg [10:0] ctrl_lines;

  always_comb begin
    case (inst[6:0])

      7'b0110011: begin  // arithmetic
        imm = 32'b0;
        ctrl_lines = {{inst[30], inst[14:12]}, 7'b0010000};
      end

      7'b0010011: begin  // arithmetic imm
        imm = {{20{inst[31]}}, inst[31:20]};
        ctrl_lines = {{inst[30], inst[14:12]}, 7'b1010000};
      end

      7'b0000011: begin  // load
        imm = {{20{inst[31]}}, inst[31:20]};
        case (inst[14:12])
          3'h2: ctrl_lines = {{1'b0, 3'h0}, 7'b1111000};  // lw
          default: ctrl_lines = 11'b0;
        endcase
      end

      7'b0100011: begin  // store
        imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
        case (inst[14:12])
          3'h2: ctrl_lines = {{1'b0, 3'h0}, 7'b1000100};  // sw
          default: ctrl_lines = 11'b0;
        endcase
      end

      7'b1100011: begin  // branch
        imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
        case (inst[14:12])
          3'h0: ctrl_lines = {{1'b1, 3'h0}, 7'b0000010};  // beq
          3'h1: ctrl_lines = {{1'b1, 3'h0}, 7'b0000011};  // bne
          3'h4: ctrl_lines = {{1'b0, 3'h2}, 7'b0000011};  // blt
          3'h5: ctrl_lines = {{1'b0, 3'h2}, 7'b0000010};  // bge
          3'h6: ctrl_lines = {{1'b0, 3'h3}, 7'b0000011};  // bltu
          3'h7: ctrl_lines = {{1'b0, 3'h3}, 7'b0000010};  // bgeu
          default: ctrl_lines = 11'b0;
        endcase
      end

      7'b1101111: begin  // jump and link
        imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
        ctrl_lines = 11'b0;
      end

      7'b1100111: begin  // jump and link reg
        imm = {{20{inst[31]}}, inst[31:20]};
        ctrl_lines = 11'b0;
      end

      7'b0110111: begin  // load upper imm
        imm = {inst[31:12], 12'b0};
        ctrl_lines = 11'b0;
      end

      7'b0010111: begin  // add upper imm to pc
        imm = {inst[31:12], 12'b0};
        ctrl_lines = 11'b0;
      end

      7'b1110011: begin  // environment
        imm = {{20{inst[31]}}, inst[31:20]};
        ctrl_lines = 11'b0;
      end

      default: begin
        imm = 32'b0;
        ctrl_lines = 11'b0;
      end

    endcase
  end

  assign alu_op = ctrl_lines[10:7];
  assign alu_src = ctrl_lines[6];
  assign mem_to_reg = ctrl_lines[5];
  assign reg_write = ctrl_lines[4];
  assign mem_read = ctrl_lines[3];
  assign mem_write = ctrl_lines[2];
  assign branch = ctrl_lines[1];
  assign branch_ne = ctrl_lines[0];

endmodule
