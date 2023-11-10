module full_adder (
    input  a,
    input  b,
    input  ci,
    output o,
    output co
);
  assign o = a ^ b ^ ci;
  assign co = (a & b) | (b & ci) | (ci & a);

endmodule
