module test_direct;
reg CLK;
reg [255:0] memData;
reg [31:0] nextAddr;
wire [7:0] dataReturn;
wire hit;
wire [255:0] toMemData;

GT_direct_map map(CLK, memData, nextAddr, dataReturn, hit, toMemData);

initial
begin

$display("Beginning direct test");
CLK = 0;
nextAddr = 0;

#2000 $stop;

end

always begin
#50 CLK = ~CLK;
end

always @(posedge CLK) begin
#10 $display("Test");
end
endmodule
