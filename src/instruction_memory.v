module instruction_memory
(
    input        wr,
    input        rd,
    input [23:0] i_instructions,
    input [7:0]  PC,
    input        clk,
    output [23:0] o_instructions
);

    reg [23:0] mem [0:7];
    integer N = 0;
	 
    always @(posedge clk) begin
        if (wr == 1'b1 && ~rd && (i_instructions != 24'd0) && (N < 8)) begin
            mem[N] <= i_instructions;
            N <= N + 1;
        end
    end

    assign o_instructions = mem[PC];
endmodule
