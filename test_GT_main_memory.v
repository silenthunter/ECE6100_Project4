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
// test_GT_main_memory
// 
//////////////////////////
module test_GT_main_memory;
wire [255:0] cache_line_data;
reg  CLK, SIG_gate;
reg [31:0]  vaddr, line_addr;

and_2_GT6100 AndG (GCLK, CLK, SIG_gate);
GT_main_memory dMEM (.Dout(cache_line_data), .addr(line_addr), .GCLK(GCLK));

initial 
begin
#1    vaddr = 32'h0000_0000_0000_1445; // true address
      SIG_gate = 1;
      CLK = 0;
      
#800  SIG_gate = 0;
#200  SIG_gate = 1;

#2000 $stop;
end

always 
begin
#50 CLK = ~CLK;   
end

always @(posedge CLK)
begin
    line_addr = vaddr >> 5;
    #20 vaddr = vaddr + 32;
end     

endmodule
