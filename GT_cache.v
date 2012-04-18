module GT_cache(CLK, memData, nextAddr, lineAddr, dataReturn, hit, miss, toMemData);
input [255:0] memData;
input [31:0] nextAddr;
input CLK;
output [31:0] lineAddr;
output [7:0] dataReturn;
output hit;
output miss;
output [255:0] toMemData;

reg miss;

GT_direct_map map(.CLK(CLK), .memData(memData), .nextAddr(nextAddr), .dataReturn(dataReturn), .hit(hit), .toMemData(toMemData));

always @ (posedge CLK) begin

miss = ~ hit;
end

endmodule
