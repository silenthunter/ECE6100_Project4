module GT_cache(CLK, memData, nextAddr, lineAddr, dataReturn, hit, miss, toMemData);
input [255:0] memData;
input [31:0] nextAddr;
input CLK;
output [31:0] lineAddr;
output [7:0] dataReturn;
output hit;
output miss;
output [255:0] toMemData;

wire [255:0] toDirectMap;
wire [255:0] toVictim;
wire [7:0] victimReturn;
wire [7:0] directMapReturn;

reg miss;
wire victimHit;
wire directMapHit;

GT_direct_map map(.CLK(CLK), .memData(memData), .nextAddr(nextAddr), .dataReturn(directMapReturn), .hit(directMapHit), .memDataFromVictim(toDirectMap));
GT_victim victim(.CLK(CLK), .memDataIn(toVictim), .memDataOut(toVictim), .nextAddr(nextAddr), .dataReturn(victimReturn), .hit(victimHit), .toMemData(toMemData));

assign hit = victimHit | directMapHit;

always @ (posedge CLK) begin

miss = ~ hit;
end

endmodule
