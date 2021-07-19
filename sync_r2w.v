`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 14:41:34
// Design Name: 
// Module Name: sync_r2w
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


module sync_r2w #(parameter ADDRSIZEL = 4)
(
input [ADDRSIZEL : 0] rptr,
input wclk,wrst_n,
output [ADDRSIZEL : 0] wq2_rptr
 );
 reg [ADDRSIZEL : 0] wq1_rptr,wq2_rptr;
 
 always @(posedge wclk or negedge wrst_n)
 if(!wrst_n)
   {wq2_rptr,wq1_rptr} <= 0;
 else
   {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr};
 
endmodule
