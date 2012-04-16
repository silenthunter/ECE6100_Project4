//
// ECE4100/6100 Advanced Computer Architecture 
//
// Prof. Hsien-Hsin Sean Lee
// School of Electrical and Computer Engineering
// Georgia Institute of Technology
// Atlanta, GA 30332
// email: leehs@ece.gatech.edu
//
//
// test_GT_IFU
// 
// This test will read the address from addr_stream_mem[] 
// Clock gating was applied in the middle to stall the 
// fetching of next cache lookup address.  The access was 
// resumed later by settin SIG_gate back to 1.
//
//////////////////////////
module test_GT_IFU;
wire [31:0] addr_for_icache;
reg CLK, SIG_gate, CLEAR_BAR, CTR_EN;
wire GCLK;

and_2_GT6100 Ax2 (GCLK, CLK, SIG_gate);
GT_IFU IFU (.inst_addr(addr_for_icache), .GCLK(GCLK), .CLEAR_BAR(CLEAR_BAR), .CTR_EN(CTR_EN));

initial 
begin
#1 CLEAR_BAR = 0;
   CTR_EN  = 1;   
   CLK = 0;
   SIG_gate = 1;

#100 CLEAR_BAR = 1;
#500 SIG_gate = 0;
#1000 SIG_gate = 1;
//#1000 $stop;
end

always
begin
#20 CLK = ~CLK;   
end

endmodule