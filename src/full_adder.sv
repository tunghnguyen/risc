module full_adder (
    input  wire a,
    input  wire b,
    input  wire ci,
    output reg o,
    output reg co
);

  assign o = a ^ b ^ ci;
  assign co = (a & b) | (b & ci) | (ci & a);

endmodule
