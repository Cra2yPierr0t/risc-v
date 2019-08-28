module branchcontroller(in, ctrl, out);
	input [31:0] in;
	input [2:0] ctrl;
	output out;

	assign out = controller(in, ctrl);

	function controller(input [31:0] in, input [2:0] ctrl);
		begin
			case(ctrl)
			3'b000: controller = ~|in;
			3'b001:	controller = |in;
			3'b100:	controller = in[0];
			3'b101: controller = ~in[0];
			3'b110: controller = in[0];
			3'b111: controller = ~in[0];
			default: controller = 1'b0;
			endcase
		end
	endfunction
endmodule
