`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 21:26:21
// Design Name: 
// Module Name: asyn_fifo
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


module asyn_fifo #(parameter ADDRSIZEL = 4,parameter DATASIZEL = 8)
(
input wclk,rclk,wrst_n,rrst_n,winc,rinc,
input [DATASIZEL-1 : 0] wdata,
output wfull,rempty,
output [DATASIZEL-1 : 0] rdata
    );

wire [ADDRSIZEL - 1 : 0] waddr,raddr;
wire [ADDRSIZEL : 0] rptr,wptr,wq2_rptr,rq2_wptr;

fifomem fifomem11(
.waddr(waddr),
.raddr(raddr),
.wdata(wdata),
.wclk(wclk),
.wclken(winc),
.wfull(wfull),
.rdata(rdata)
);

sync_r2w sync_r2w11(
.rptr(rptr),
.wclk(wclk),
.wrst_n(wrst_n),
.wq2_rptr(wq2_rptr)
);

sync_w2r sync_w2r11(
.wptr(wptr),
.rq2_wptr(rq2_wptr),
.rclk(rclk),
.rrst_n(rrst_n)
);
 
rptr_empty  rpte_empty11(
.rrst_n(rrst_n),
.rclk(rclk),
.rinc(rinc),
.rq2_wptr(rq2_wptr),
.raddr(raddr),
.rptr(rptr),
.rempty(rempty)
);   

wptr_full wptr_full11(
.wclk(wclk),
.wrst_n(wrst_n),
.winc(winc),
.wq2_rptr(wq2_rptr),
.wptr(wptr),
.waddr(waddr),
.wfull(wfull)
);
endmodule
