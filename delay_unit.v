module delay_unit(Dout, addr, GCLK);
input [31:0] addr;
input GCLK;
output [255:0] Dout;
wire [255:0] Dout;
reg [31:0] addrOut;

GT_main_memory main(Dout, addrOut, GCLK);

integer counter;

initial counter = 0;

always @ (posedge GCLK) begin
#1 addrOut = 32'hxxxxxxxx;
if(addr) begin
	//$display("Requesting %h", addr);
	counter = counter + 1;
	if(counter % 4 == 0)
		addrOut = addr;
end
end
endmodule
