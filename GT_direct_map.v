module GT_direct_map(CLK, memData, nextAddr, dataReturn, hit, toMemData);
input CLK;
input [255:0] memData;
input [31:0] nextAddr;
output [7:0] dataReturn;
reg [7:0] dataReturn;
output hit;
output [255:0] toMemData;

reg [21:0] tag;
reg [4:0] idx;
reg [4:0] offset;
reg [31:0] cachelines [31:0];
reg [31:0] tags [21:0];

reg [31:0] data;
reg [31:0] dataShifted;
reg [21:0] cacheTag;

reg [26:0] lineTag;

always @(posedge CLK) begin
tag = nextAddr[31:9];
idx = nextAddr[8:5];
offset = nextAddr[4:0];

//Cache-line received from main memory
if(memData) begin
	cachelines[idx] = memData;
end

data = cachelines[idx];
cacheTag = tags[idx];

if(cacheTag == tag) begin
	dataShifted = (data >> offset * 8);
	dataReturn = dataShifted[7:0];
end else begin
	$display("Miss\n");
end

end

endmodule
