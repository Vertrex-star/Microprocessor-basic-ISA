module count #(parameter inc = 1)
	  (
	  input        rst,
	  input  [7:0] count, 
	  output reg [7:0] countNext  
	  );

always @(*) begin
	if (rst) begin
		countNext = 8'd0;
	end else begin
		countNext <= count + inc;
	end
end

endmodule

