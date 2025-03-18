// x^4 + x^3 + 1

module SISR_4bit_sig(
  input clk,rst,ens,
  input [6:0] in,
  output reg [3:0] out,
  output reg enc
);
  integer i = 0;

  initial
    begin
      out = 4'b0000;
      enc = 0;
    end

  always @(posedge clk, posedge rst)
    begin
      if(rst)
        begin
          out <= 4'b0000;
          i <= 0;
          enc <= 0;
        end 
      else if(ens)
        begin
          enc <= 0;
          i <= i + 1;
        end 
      else
        begin
          out <= 4'b0000;
          i <= 0;
          enc <= 0;
        end         
    end
   
  always @(i)
    begin
      if(i<7)
        begin
          $display("current loop# %d",i);
          $display("out value %d",out);
          out[0] <= in[i]^out[3];
          out[1] <= out[0];
          out[2] <= out[1];
          out[3] <= out[2]^out[3];
        end
      else
        begin
          enc <= 1;
          out <= out;
        end     
    end
endmodule
