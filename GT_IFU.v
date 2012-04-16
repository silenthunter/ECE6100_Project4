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
// GT_IFU()
// inst_addr: Address read out from the addr_stream_memory for cache lookup
// GCLK:     clock input, can be gated    
// CLEAR_BAR: clear the counter back to x00000000
// CTR_EN: enable up counting
//
//////////////////////////
module GT_IFU(inst_addr, GCLK, CLEAR_BAR, CTR_EN);
input GCLK, CLEAR_BAR, CTR_EN;
output [31:0] inst_addr;
reg [31:0] inst_addr;
reg [31:0] addr_stream_mem[63:0];    
wire [31:0] ctr_out;  /* sequence number from the counter */
   
Sync_counter_32bit Ctr_imem (.out(ctr_out), .clock(GCLK), .clear_bar(CLEAR_BAR), .count_en(CTR_EN));
   
initial 
begin    
   addr_stream_mem[0] = 32'h0000_0041;
   addr_stream_mem[1] = 32'h0000_0442; 
   addr_stream_mem[2] = 32'h0000_00c3;
   addr_stream_mem[3] = 32'h0000_4042; 	 
   addr_stream_mem[4] = 32'h0000_0043; 
   addr_stream_mem[5] = 32'h0000_0844;
   addr_stream_mem[6] = 32'h0000_1445;
   addr_stream_mem[7] = 32'h0000_1446;
   addr_stream_mem[8] = 32'h0000_0847;
   addr_stream_mem[9] = 32'h0000_0442;
   addr_stream_mem[10]= 32'h0000_0847; 
   inst_addr = addr_stream_mem[0];  
end
    
always @(ctr_out)
begin
   inst_addr = addr_stream_mem[ctr_out];
end
endmodule