module GT_direct_map(CLK, memData, memDataFromVictim, nextAddr, dataReturn, hit, toMemData);
input CLK;
input [255:0] memData;
input [255:0] memDataFromVictim;
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

reg [255:0] data;
reg [255:0] dataShifted;
reg [21:0] cacheTag;

reg [26:0] lineTag;
reg hit;
//reg [255:0] toMemData;

integer i;

assign toMemData = localToMemData;

initial begin
//$display("Setting up direct memory structure");
for (i = 0; i < 32; i = i + 1) begin
	cachelines[i] = 0;
	tags[i] = 0;
end
end

always @(posedge CLK) begin
#1 tag = nextAddr[31:9];
idx = nextAddr[8:5];
offset = nextAddr[4:0];
localToMemData = 256'hxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
dataReturn = 8'hxx;
hit = 0;

//Cache-line received from main memory
if(memData) begin
	localToMemData = cachelines[idx];//Send the old line to the victim cache
	cachelines[idx] = memData;
	tags[idx] = tag;
	//$display("[%h]Data[%h] from memory: %h", nextAddr, idx, memData);
end
else
	//Cache-line received from the victim cache
if(memDataFromVictim) begin
	localToMemData = cachelines[idx];//Send the old line to the victim cache
	cachelines[idx] = memDataFromVictim;
	tags[idx] = tag;
	//$display("Data[%h] from victim: %h", idx, memDataFromVictim);
end 

data = cachelines[idx];
cacheTag = tags[idx];

//$display("[%t]comparing %h : %h", $time, cacheTag, tag);
if(cacheTag == tag) begin
	dataShifted = (data << offset * 8);
	dataReturn = dataShifted[255:248];
	hit = 1;
	//$display("[%h][%d]Direct hit // %h : %h >> %h shifted %d", nextAddr, idx, cacheTag, tag, dataReturn, offset);
end

end

endmodule
