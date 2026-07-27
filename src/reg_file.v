module reg_file (
	input clk,
	input [3:0] A1,
	input [3:0] A2,
	input [3:0] A3,
	input [7:0] WD3,
	input regWrite,
	output [7:0] RD1,
	output [7:0] RD2
);

reg [7:0] r_RD1;
reg [7:0] r_RD2;
reg [7:0] mem [0:15];

// Just for show mostly
parameter x0  = 4'b0000;
parameter x1  = 4'b0001;
parameter x2  = 4'b0010;
parameter x3  = 4'b0011;
parameter x4  = 4'b0100;
parameter x5  = 4'b0101;
parameter x6  = 4'b0110;
parameter x7  = 4'b0111;
parameter x8  = 4'b1000;
parameter x9  = 4'b1001;
parameter x10 = 4'b1010;
parameter x11 = 4'b1011;
parameter x12 = 4'b1100;
parameter x13 = 4'b1101;
parameter x14 = 4'b1110;
parameter x15 = 4'b1111;

integer k;
initial begin
	for (k = 0; k < 16; k = k + 1) begin
		mem[k] = 8'd0;
	end
end

always @(posedge clk) begin
	r_RD1 <= mem[A1];
	r_RD2 <= mem[A2];
	if (regWrite && ~(A3 == 0)) begin
		mem[A3] <= WD3;
	end
end

assign RD1 = r_RD1;
assign RD2 = r_RD2;

endmodule
