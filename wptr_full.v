`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 20:05:02
// Design Name: 
// Module Name: wptr_full
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


module wptr_full #(parameter ADDRSIZEL = 4)
(
input wclk,wrst_n,winc,
input [ADDRSIZEL : 0] wq2_rptr,
output [ADDRSIZEL : 0] wptr,
output [ADDRSIZEL-1 : 0] waddr,
output wfull
);

reg [ADDRSIZEL : 0] wbin,wptr;
reg wfull;
wire [ADDRSIZEL : 0] wbnext,wgnext;

always@(posedge wclk or negedge wrst_n)
if(!wrst_n)
  {wbin,wptr} <= 0;
else
  {wbin,wptr} <= {wbnext,wgnext};
  
assign waddr = wbin[ADDRSIZEL-1 : 0];    

assign wbnext = wbin + (winc & ~wfull);

assign wgnext = (wbnext>>1) ^ (wbnext);

wire wfull_val;

assign wfull_val = (wgnext == {~wq2_rptr[ADDRSIZEL : ADDRSIZEL-1],wq2_rptr[ADDRSIZEL-2 : 0]});

always@(posedge wclk or negedge wrst_n)
if(!wrst_n)
  wfull <= 0;
else
  wfull <= wfull_val;
  
endmodule
