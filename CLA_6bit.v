module CLA_6bit(
  input [5:0] a,b,
  input cin,
  output [5:0] sum,
  output cout, mode
);
  
  wire [4:0] c;
  wire c_temp;
  wire [5:0]gen,prop;
  
  //generate logic
  assign gen[0] = a[0] & b[0]; 
  assign gen[1] = a[1] & b[1]; 
  assign gen[2] = a[2] & b[2]; 
  assign gen[3] = a[3] & b[3];
  assign gen[4] = a[4] & b[4];
  assign gen[5] = a[5] & b[5];
  
  //propagate logic
  assign prop[0] = a[0] ^ b[0];
  assign prop[1] = a[1] ^ b[1];
  assign prop[2] = a[2] ^ b[2];
  assign prop[3] = a[3] ^ b[3];
  assign prop[4] = a[4] ^ b[4];
  assign prop[5] = a[5] ^ b[5];

  //combinational logic for carry calculation
  assign c[0] = gen[0] + (prop[0] & cin); 
  assign c[1] = gen[1] + (prop[1] & c[0]); 
  assign c[2] = gen[2] + (prop[2] & c[1]); 
  assign c[3] = gen[3] + (prop[3] & c[2]); 
  assign c[4] = gen[4] + (prop[4] & c[3]); 
  assign c_temp = gen[5] + (prop[5] & c[4]); 
  assign cout = mode ? 1'b0 : c_temp;
  
  //combinational logic for sum calculation
  assign sum[0] = prop[0] ^ cin;
  assign sum[1] = prop[1] ^ c[0];
  assign sum[2] = prop[2] ^ c[1];
  assign sum[3] = prop[3] ^ c[2];
  assign sum[4] = prop[4] ^ c[3];
  assign sum[5] = prop[5] ^ c[4];

endmodule
