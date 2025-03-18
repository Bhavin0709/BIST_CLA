module comp(
  input [3:0] ora, sign, 
  input enc, mode, 
  output result
);
  wire pass;
  
  assign result = (mode & enc) ? (ora === sign) : 1'bz;
endmodule
