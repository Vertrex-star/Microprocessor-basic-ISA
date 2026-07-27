module flip_flop (
    input      [7:0] a,
    input            clk,
    output     [7:0] b
);
 
reg [7:0] out = 8'd0;
 
always @(posedge clk) begin
	out <= a;
end
 
assign b = out;
 
endmodule
