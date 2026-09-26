`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2026 01:55:33 PM
// Design Name: 
// Module Name: sevenseg
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


module sevenseg(
    input logic [3:0] data,
    output logic [6:0] segments
);
    logic A, B, C, D;
    
    assign A = data[3];
    assign B = data[2];
    assign C = data[1];
    assign D = data[0];
    
    assign segments[6] = (~A & ~B & ~C) | (~A & B & C & D);
    assign segments[5] = (~A & ~B & C) | (~A & ~B & D) | (~A & C & D) | (A & B & ~C);
    assign segments[4] = (~A & B & ~C) | (~A & D) | (~B & ~C & D);
    assign segments[3] = (~A & B & ~C & ~D) | (A & ~B & C & ~D) | (~B & ~C & D) | (B & C & D);
    assign segments[2] = (~A & ~B & C & ~D) | (A & B & C) | (A & B & ~D);
    assign segments[1] = (~A & B & ~C & D) | (A & B & ~D) | (A & C & D) | (B & C & ~D);
    assign segments[0] = (~A & ~B & ~C & D) | (A & ~B & C & D) | (A & B & ~C) | (B & ~C & ~D);
    
endmodule
