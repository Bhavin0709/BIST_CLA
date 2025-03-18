module CLA_BIST(
  input clk, rst, cin,
  input enl,          // Load signal for LFSR
  input ens,          // Load signal for SISR
  input mode,
  output wire pass     // BIST pass/fail signal
);

  reg [3:0] i = 0;
  reg [3:0] mem [0:13];
  wire cla_cin = 0;
  wire enc;
  wire mode;
  wire [5:0] cla_in1, cla_in2;   // Input to CLA
  wire [6:0] cla_sum;  // Sum of CLA (including cout)
  wire [3:0] sisr_out; // Output of SISR
  wire [3:0] golden_sign;
  reg [3:0] gold_sign; // Golden signature value for comparison
  

  // LFSR generates pseudo-random test vectors for the CLA adder
  lfsr6bit lfsr1(.clk(clk), .rst(rst), .mode(mode), .enl(enl), .out(cla_in1));
  lfsr6bit lfsr2(.clk(clk), .rst(rst), .mode(mode), .enl(enl), .out(cla_in2));

  // CLA adder adds the inputs and generates sum and carry out
  CLA_6bit cla(.mode(mode), .a(cla_in1), .b(cla_in2), .cin(cin), .sum(cla_sum[5:0]), .cout(cla_sum[6]));

  // SISR calculates signature based on input data
  sisr_4bit_sig sisr(.clk(clk), .rst(rst), .ens(ens), .in(cla_sum), .out(sisr_out), .enc(enc));

  // Comparator compares SISR output with golden signature value
  comp comparator(.ora(sisr_out), .mode(mode), .enc(enc), .sign(golden_sign), .result(pass));

  assign golden_sign = gold_sign;

  always@(posedge enc)
    begin
      if(i >= 14)
        i = 0;
      
      if(enc && !mode)
        begin
          $display("enc %d",sisr_out);
          mem[i] = sisr_out;
          i = i + 1;
        end
        
      if(mode)
        begin
          gold_sign = mem[i];
          i = i + 1;
        end 
    end
endmodule
