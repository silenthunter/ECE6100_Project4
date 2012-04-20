module GT_cache(CLK, nextAddr, dataReturn, hit, miss, toMemData, lineAddr);
//input [255:0] memData;
input CLK;
output [31:0] lineAddr;
output [7:0] dataReturn;
output hit;
output miss;
output [255:0] toMemData;
output [31:0] nextAddr;

wire [255:0] toDirectMap;
wire [255:0] toVictim;
wire [7:0] victimReturn;
wire [7:0] directMapReturn;
wire [31:0] nextAddr;
wire [255:0] memData;
//reg [7:0] dataReturn;
//reg [31:0] lineAddr;

wire GCLK;
wire GCLK2;
reg CLEAR, CTR_EN;
reg SIG_gate, SIG_gate2;
wire victimHit;
wire directMapHit;

GT_direct_map map(.CLK(CLK), .memData(memData), .nextAddr(nextAddr), .dataReturn(directMapReturn), .hit(directMapHit), .memDataFromVictim(toDirectMap));
GT_victim victim(.CLK(CLK), .memDataIn(toVictim), .memDataOut(toVictim), .nextAddr(nextAddr), .dataReturn(victimReturn), .hit(victimHit), .toMemData(toMemData));
delay_unit delay(.addr(lineAddr), .GCLK(GCLK2), .Dout(memData));
and_2_GT6100 gated(GCLK, CLK, SIG_gate);
and_2_GT6100 gated2(GCLK2, CLK, SIG_gate2);
GT_IFU ifu(.inst_addr(nextAddr), .GCLK(GCLK), .CLEAR_BAR(CLEAR), .CTR_EN(CTR_EN));

assign hit = victimHit | directMapHit;
assign miss = ~hit;
assign dataReturn = victimHit ? victimReturn : directMapReturn;
assign lineAddr = hit ? 32'hxxxxxxxx : nextAddr >> 5;

initial begin
//dataReturn = 0;
SIG_gate = 1;
SIG_gate2 = 1;
CLEAR = 0;
CTR_EN = 1;
#2 CLEAR = 1;
end

always @ (posedge CLK) begin
#1 SIG_gate = 0;
SIG_gate2 = ~SIG_gate2;
if(dataReturn !== 8'hxx) begin
	SIG_gate = 1;
end
end

endmodule
