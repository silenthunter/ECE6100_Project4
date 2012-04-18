module test_victim;
reg CLK;
reg [255:0] memData;
reg [31:0] nextAddr;
wire [31:0] lineAddr;
wire [7:0] dataReturn;
wire hit;
wire [255:0] toMemData;
wire [255:0] contMemData;
reg [31:0] memAddr;
wire [255:0] Dout;
wire [255:0] memDataOut;

GT_victim v(CLK, contMemData, memDataOut, nextAddr, lineAddr, dataReturn, hit, toMemData);
GT_main_memory m(Dout, memAddr, CLK);
assign contMemData = memData;

initial begin
CLK = 0;
memData = 0;
nextAddr = 0;
memAddr = 0;

#500 $stop;
end

always begin
#10 CLK = ~CLK;
end

always @ (posedge CLK)  begin
if(!hit) memAddr = nextAddr;
$display("dataReturn: %h\ntoMemData: %h\nhit: %b", dataReturn, toMemData, hit);
$display("Dout: %h", Dout);
$display("MemData: %h\n", memDataOut);
//nextAddr = nextAddr + (1 << 5);

end

endmodule
