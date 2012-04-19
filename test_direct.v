module test_direct;
reg CLK;
reg [255:0] memData;
reg [31:0] nextAddr;
wire [7:0] dataReturn;
wire hit;
wire [255:0] toMemData;

GT_direct_map map(.CLK(CLK), .memData(memData), .nextAddr(nextAddr), .dataReturn(dataReturn), .hit(hit), .toMemData(toMemData));

initial
begin

$display("Beginning direct test");
CLK = 0;
nextAddr = 32'h00100001;

$monitor("%h\t%h\t%h\t%h", nextAddr, hit, dataReturn, toMemData);

memData = 256'hFFFF_EEEE_DDDD_CCCC_BBBB_AAAA_9999_8888_7777_6666_5555_4444_3333_2222_1111_0000;

$display("Writing Data");
#2 nextAddr = 32'h00200002;
#2 nextAddr = 32'h00300003;
#2 nextAddr = 32'h023000F3;
#2
$display("Reading Data");
memData = 0;
#2 nextAddr = 32'h00300003;
#2 nextAddr = 32'h00200002;


#50 $stop;

end

always begin
#1 CLK = ~CLK;
end

endmodule
