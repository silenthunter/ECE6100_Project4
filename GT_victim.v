module GT_victim(CLK, memDataIn, memDataOut, nextAddr, lineAddr, dataReturn, hit, toMemData);
input CLK;
input [255:0] memDataIn;
output [255:0] memDataOut;
input [31:0] nextAddr;
output [31:0] lineAddr;
output [7:0] dataReturn;
output hit;
output [255:0] toMemData;

reg [255:0] cacheLines [3:0];
reg [26:0] tagLines [3:0];
reg [26:0] tag;
reg [4:0] offset;
reg [255:0] toMemData;
reg [7:0] dataReturn;
reg hit;
reg [31:0] lineAddr;
reg [255:0] memDataOut;

reg [255:0] offsetData;

reg [2:0] PLRU;

integer i;
integer replacedIdx;

initial begin

for (i = 0; i < 4; i = i + 1) begin
	cacheLines[i] = 0;
	tagLines[i] = 0;
end

PLRU = 0;

end

always @ (posedge CLK) begin
#1 tag = nextAddr[31:5];
dataReturn = 8'hxx;
toMemData = 255'hxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
offset = nextAddr[4:0];

//Replace LRU entry with memData
if(memDataIn) begin

	//1 is right in this traversal
	replacedIdx = PLRU[2] * 2 + (((PLRU[1:0]) >> PLRU[2]) & 1);
	
	PLRU[1:0] = PLRU [1:0] ^ 2 >> PLRU[2];//Switch lower part of the tree
	PLRU[2] = PLRU[2] ^ 1;//Switch upper tree

	toMemData = cacheLines[replacedIdx];
	cacheLines[replacedIdx] = memDataIn;
	tagLines[replacedIdx] = tag;
	//$display("Tree %b", PLRU);
end
else begin
	//Find the tag in the associative cache, if it exists
	hit = 0;
	for(i = 0; i < 4; i = i + 1) begin
		if(tag == tagLines[i]) begin
			offsetData = cacheLines[i] << (offset * 8);
			dataReturn = offsetData[255:248];
			memDataOut = cacheLines[i];
			hit = 1;

			//Set the entry to LRU. It will be swapped with the direct cache
			PLRU[2] = i / 2;
			PLRU[i / 2 + 1] = ~(i % 2);
		end

	end //end for
end

end

endmodule
