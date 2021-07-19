`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 15:14:12
// Design Name: 
// Module Name: sync_w2r
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


module sync_w2r #(parameter ADDRSIZEL = 4)
(
input [ADDRSIZEL : 0] wptr,
output [ADDRSIZEL : 0] rq2_wptr,
input rclk,rrst_n
);

reg [ADDRSIZEL : 0] rq1_wptr,rq2_wptr;
always@(posedge rclk or negedge rrst_n)
if(!rrst_n)
  {rq2_wptr,rq1_wptr} <= 0;
else
  {rq2_wptr,rq1_wptr} <= {rq1_wptr,wptr};
  
endmodule
