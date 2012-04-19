module driver;

reg CLK;
wire hit, miss;
wire [31:0] line;
wire [7:0] dataReturn;

GT_cache cache(.CLK(CLK), .hit(hit), .miss(miss), .dataReturn(dataReturn), .nextAddr(line));

initial begin
CLK = 0;
#100 $stop;
end

always begin
#1 CLK = ~CLK;
end

always @ (posedge CLK) begin
#1 $display("%g\t%h\t%b\t%b\t%h", $time, line, hit, miss, dataReturn);
end

endmodule
