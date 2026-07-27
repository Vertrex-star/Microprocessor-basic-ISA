module verf;

    reg  [5:0]  wrt;
    reg  [5:0]  rd;
    wire [7:0]  alu;          // driven by the DUT, must be a wire, not reg
    reg  [23:0] i_instructions;
    reg         rst;
    reg         clk;

    microprocessor UUT (
        .wrt(wrt), .rd(rd), .i_instructions(i_instructions),
        .clk(clk), .rst(rst), .alu(alu)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
	 
	 task load_instr(input [23:0] instr);
		begin
			@(negedge clk);
			wrt = 1;
			i_instructions = instr;
			@(posedge clk);
			@(negedge clk);
			wrt = 0;
		end
	endtask

    initial begin
	     // Load instructions
        rd  = 0;
        rst = 1;
        wrt = 0;
        #10;

		  load_instr(24'b0000_0001_0010_0011_00000000); // 1. and  x1,x2,x3
        load_instr(24'b0001_0100_0101_0110_00000000); // 2. or   x4,x5,x6
        load_instr(24'b0010_0001_0010_0011_00000000); // 3. add  x1,x2,x3
        load_instr(24'b0011_0111_0001_0010_00000000); // 4. sub  x7,x1,x2
        load_instr(24'b0100_0010_0011_0000_00000101); // 5. andi x2,x3,#5
        load_instr(24'b0101_0011_0100_0000_00000011); // 6. ori  x3,x4,#3
        load_instr(24'b0110_0101_0110_0000_00001010); // 7. addi x5,x6,#10
        load_instr(24'b0111_0000_0001_0010_00000100); // 8. beq  x1,x2,#4 

			// Reading
			@(negedge clk);
			rst = 0;
			rd = 1;
			
			repeat(16) begin
				@(posedge clk);
				$display("Time=%0t ALU = %d (0x%h)", $time, alu, alu);
			end
		end
endmodule
