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

$monitor("%d\t%h\t%b\t%h\t%h", $time, nextAddr, hit, dataReturn, toMemData);
$display("Tick\tAddr\thit\tdata\tToMem");
$display("Beginning write to victim cache");

#2
memData =  256'hFFFF_EEEE_DDDD_CCCC_BBBB_AAAA_9999_8888_7777_6666_5555_4444_3333_2222_1111_0000;
nextAddr = 32'h01000001;
#2
nextAddr = 32'h02000002;
#2
nextAddr = 32'h03000003;
#2
nextAddr = 32'h04000004;
#2
$display("Push out another cacheline to main mem");
nextAddr = 32'h05000005;
#2
memData =  0;
$display("Beginning read");
#4
nextAddr = 32'h03000003;
#2
nextAddr = 32'h07000007;
#60 $stop;
end

always begin
#1 CLK = ~CLK;
end

always @ (posedge CLK)  begin

end

endmodule
