`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2026 02:08:10 PM
// Design Name: 
// Module Name: testbench_sevenseg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_sevenseg( );

    logic        clk, reset;

    logic [3:0] data;
    logic [6:0] segments;
    
    logic [6:0] segments_expected;
    logic [31:0] vectornum, errors;     //int32
    logic [10:0]  testvectors[100:0];
    
    
    sevenseg dut (.data(data),.segments(segments));
    

  // generate clock
  always 
    begin
      clk = 1; #5; clk = 0; #5;
    end

  // at start of test, load vectors
  // and pulse reset
  initial
    begin
      $readmemh("sevenseg.tv", testvectors);
      vectornum = 0; errors = 0;
      reset = 1; #22; reset = 0;
    end

  // apply test vectors on rising edge of clk
  always @(posedge clk)
    begin
      #1; {segments_expected, data} = testvectors[vectornum];
    end

  // check results on falling edge of clk
  always @(negedge clk)
    if (~reset) begin // skip during reset
      if (segments !== segments_expected) begin  // check result
        $display("Error: inputs = %h",data);
        $display("  outputs = %h (%h expected)",segments, segments_expected);
        errors = errors + 1;
      end
      vectornum = vectornum + 1;
      if (testvectors[vectornum] === 11'bx) begin  //'x
        $display("%d tests completed with %d errors", 
	           vectornum, errors);
        $stop;
      end
    end


endmodule
