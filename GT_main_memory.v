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
// GT_main_memory()
// input_addr : input address to instruction memory
// out_addr: Address read out from the memory for cache lookup
// GCLK:     clock input, can be gated    
// CLEAR_BAR: clear the counter back to x00000000
// CTR_EN: enable up counting
//
//////////////////////////
module GT_main_memory(Dout, addr, GCLK);
input [31:0] addr;
input GCLK;
output [255:0] Dout;
reg [255:0] Dout;
reg [255:0] main_memory[1023:0]; // total = 256bit*1024 = 32KB 
integer i;   

initial 
begin    
   main_memory[0] = 256'hFFFF_EEEE_DDDD_CCCC_BBBB_AAAA_9999_8888_7777_6666_5555_4444_3333_2222_1111_0000;
   
   for (i = 1; i < 1024; i = i+1) 
   begin 
      main_memory[i] = main_memory[i-1] + 1;
   end
end
    
always @(posedge GCLK)
begin
   Dout = main_memory[addr];
end
endmodule