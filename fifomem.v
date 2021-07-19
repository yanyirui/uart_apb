`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 18:19:19
// Design Name: 
// Module Name: fifomem
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


module fifomem  #( parameter DATASIZEl = 8,parameter ADDRSIZEl = 4)  //number of mem address bits
(
  input [ADDRSIZEl-1 : 0] waddr,raddr,
  input [DATASIZEl-1 : 0] wdata,
  input wclk,wclken,wfull,
  output [DATASIZEl-1 : 0] rdata
 );
 
 //RTL verilog memory model
 localparam DEPTH = 1<<ADDRSIZEl;
 reg [DATASIZEl-1 : 0] mem[DEPTH-1 : 0];
 
 assign rdata = mem[raddr];
 always@(posedge wclk)
   if(wclken && ~wfull) mem[waddr] = wdata;
    
endmodule
