module GT_victim(CLK, memData, nextAddr, lineAddr, dataReturn, hit, toMemData);
input CLK;
input [255:0] memData;
input [31:0] nextAddr;
output [31:0] lineAddr;
output [8:0] dataReturn;
output hit;
output [255:0] toMemData;

reg [31:0] cacheLines [3:0];
reg [26:0] tagLines [3:0];
reg [26:0] tag;

integer i;

always @ (posedge CLK) begin

tag = nextAddr[31:5];

for(i = 0; i < 4; i = i + 1) begin
	if(tag == tagLines[i]) begin
	end

end //end for

end

endmodule
