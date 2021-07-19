`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 15:23:42
// Design Name: 
// Module Name: rptr_empty
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


module rptr_empty #(parameter ADDRSIZEL = 4)
(
input rrst_n,rclk,rinc,
input [ADDRSIZEL : 0] rq2_wptr,
output [ADDRSIZEL-1 : 0] raddr,
output [ADDRSIZEL : 0] rptr,
output rempty
);

reg [ADDRSIZEL : 0] rbin,rptr;
reg rempty;
wire [ADDRSIZEL : 0] rbnext,rgnext;
wire rempty_val;

always@(posedge rclk or negedge rrst_n)
if(!rrst_n)
  {rptr,rbin} <= 0;
else
  {rptr,rbin} <= {rgnext,rbnext};

assign raddr = rbin[ADDRSIZEL-1 : 0];

assign rbnext = rbin + (rinc & ~rempty);
  
assign rgnext = rbnext>>1 ^ rbnext;

//assign rempty = (rq2_wptr == rptr) ? 1 : 0;   rempty为什么不能写成组合逻辑
assign rempty_val = (rgnext == rq2_wptr) ? 1 : 0;
always@(posedge rclk or negedge rrst_n)
  if(!rrst_n) 
    rempty <= 1;
  else
    rempty <= rempty_val;
endmodule
