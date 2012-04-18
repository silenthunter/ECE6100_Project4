module GT_direct_map(CLK, memData, nextAddr, dataReturn, hit, toMemData);
input CLK;
input [255:0] memData;
input [31:0] nextAddr;
output [7:0] dataReturn;
reg [7:0] dataReturn;
output hit;
inout [255:0] toMemData;

reg [255:0] localToMemData;

reg [21:0] tag;
reg [4:0] idx;
reg [4:0] offset;
reg [255:0] cachelines [31:0];
reg [31:0] tags [21:0];

reg [31:0] data;
reg [31:0] dataShifted;
reg [21:0] cacheTag;

reg [26:0] lineTag;
//reg [255:0] toMemData;

integer i;

GT_victim victim(.memData(toMemData));
assign toMemData = localToMemData;

initial begin
$display("Setting up direct memory structure");
for (i = 0; i < 32; i = i + 1) begin
	cachelines[i] = 0;
	tags[i] = 0;
end
end

always @(posedge CLK) begin
tag = nextAddr[31:9];
idx = nextAddr[8:5];
offset = nextAddr[4:0];

//Cache-line received from main memory
if(memData) begin
	localToMemData = cachelines[idx];//Send the old line to the victim cache
	cachelines[idx] = memData;
end

data = cachelines[idx];
cacheTag = tags[idx];

if(cacheTag == tag) begin
	dataShifted = (data >> offset * 8);
	dataReturn = dataShifted[7:0];
end else begin
	$display("Miss");
end

end

endmodule
